//
//  MyCollectionViewController.m
//  MyCollectionView
//
//  Created by Neil Davis on 24/04/13.
//  Copyright (c) 2013 Neil Davis. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "CustomItem.h"
#import "GridLayout.h"

static const NSInteger kNumRows = 100;
static const NSInteger kNumCols = 500;

@interface MyCollectionViewController () <PSUICollectionViewDataSource, PSUICollectionViewDelegate,
                                            UIAlertViewDelegate>
{
    BOOL    _alertVisible;
}

@property (nonatomic, weak) PSUICollectionView *collectionView;

@end

@implementation MyCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize collection view and layout object
    GridLayout *layout = [[GridLayout alloc] init];
    PSUICollectionView *collectionView = [[PSUICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    [self.collectionView registerClass:[CustomItem class] forCellWithReuseIdentifier:[CustomItem reuseIdentifier]];
    
    // Add a long tap gesture recognizer
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didRecognizeGesture:)];
    [self.collectionView addGestureRecognizer:longPressRecognizer];

    self.collectionView.backgroundColor = [UIColor blackColor];
 
}

#pragma mark - PSUICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(PSUICollectionView *)collectionView
{
    return kNumRows;
}

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kNumCols;
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CustomItem reuseIdentifier] forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"(%d,%d)", indexPath.item, indexPath.section];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gesture recognition

- (void) didRecognizeGesture:(UIGestureRecognizer*)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && !_alertVisible)
    {
        // Respond to long press gesture
        _alertVisible = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalidate Layout?" message:@"Invalidate the layout and force an update?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        // Yes, invalidate the layout
        [self.collectionView.collectionViewLayout invalidateLayout];
    }
    _alertVisible = NO;
}

@end
