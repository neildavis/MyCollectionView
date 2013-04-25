//
//  CustomItem.h
//  MyCollectionView
//
//  Created by Neil Davis on 24/04/13.
//  Copyright (c) 2013 Neil Davis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomItem : PSUICollectionViewCell

+ (NSString*) reuseIdentifier;
@property (nonatomic, strong) UILabel *label;

@end
