//
//  JSView.m
//  SplitViewToy
//
//  Created by James Stewart on 1/28/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSView.h"
#import <QuartzCore/QuartzCore.h>

@implementation JSView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _hasShadow = NO;
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
    if (self.hasShadow) {
        [self addShadowsToView];
    }
}

- (void)addShadowsToView {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:0.0f];
    CALayer *layer = self.layer;
    layer.shadowPath = shadowPath.CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowRadius = 10.0f;
    layer.shadowOpacity = 0.75f;
    self.clipsToBounds = NO;
}
@end
