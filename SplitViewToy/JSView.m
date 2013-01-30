//
//  JSView.m
//  SplitViewToy
//
//  Created by James Stewart on 1/28/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSView.h"

@implementation JSView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
