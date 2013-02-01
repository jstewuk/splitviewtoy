//
//  JSTapGestureRecognizer.m
//  SplitViewToy
//
//  Created by James Stewart on 1/31/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSTapGestureRecognizer.h"

@implementation JSTapGestureRecognizer
- (void)reset {
    [super reset];
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

@end
