//
//  CustomItem.m
//  MyCollectionView
//
//  Created by Neil Davis on 24/04/13.
//  Copyright (c) 2013 Neil Davis. All rights reserved.
//

#import "CustomItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomItem

+ (NSString*) reuseIdentifier
{
    return @"CustomItem";
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor lightTextColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        self.contentView.backgroundColor = [UIColor darkGrayColor];        
    }
    return self;
}

@end
