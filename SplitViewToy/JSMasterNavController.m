//
//  JSMasterNavController.m
//  SplitViewToy
//
//  Created by James Stewart on 1/27/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSMasterNavController.h"
#import "JSView.h"

@interface JSMasterNavController ()

@end

@implementation JSMasterNavController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

#pragma mark - autolayout fun


@end
