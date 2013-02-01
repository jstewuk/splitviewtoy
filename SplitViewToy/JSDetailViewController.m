//
//  JSDetailViewController.m
//  SplitViewToy
//
//  Created by James Stewart on 1/27/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSDetailViewController.h"
#import "JSView.h"


@interface UIWindow (AutoLayoutDebug)
+ (UIWindow *)keyWindow;
- (NSString *)_autolayoutTrace;
@end
 

@interface JSDetailViewController ()
@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) UIView *playView;
@property (nonatomic, strong) NSArray *originalConstraints;
@property (nonatomic, strong) NSDictionary *viewsDictionary;
@property (nonatomic, strong) NSArray *contentViewConstraints;

@end

@implementation JSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // remove autoresize constraints
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    JSView *contentView = [[JSView alloc] initWithFrame:CGRectZero];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    CGRect rect = CGRectMake(0, 0, 20, 20);
    UIView *playView = [[UIView alloc] initWithFrame:rect];
    [playView setBackgroundColor:[UIColor blueColor]];
    playView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:playView];
    _playView = playView;
    
    [self.contentView removeConstraints:self.contentView.constraints];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
    
    // Why do I have to do this????
    self.contentView.frame = self.view.bounds;
    
    NSLog(@"autolayout Trace: %@", [[UIWindow keyWindow] _autolayoutTrace]);
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - Constraints

- (NSDictionary *)viewsDictionary {
    if (! _viewsDictionary ) {
        _viewsDictionary = (@{@"mView" : self.contentView,
                            @"playView" : self.playView,
                            @"mainView" : self.view });
    }
    return _viewsDictionary;
}

// Expand contentView to match view controllers view (set on self.view)
- (NSArray *)contentViewConstraints {
    if (! _contentViewConstraints ) {
        NSArray *h1Constr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:self.viewsDictionary];
        _contentViewConstraints = [NSArray arrayWithArray:h1Constr];
        
        NSArray *vConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mView]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _contentViewConstraints = [_contentViewConstraints arrayByAddingObjectsFromArray:vConstr];
    }
    return _contentViewConstraints;
}

- (NSArray *)originalConstraints {

    if ( ! _originalConstraints ) {
        NSArray *hConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[playView(20)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _originalConstraints =  [NSArray arrayWithArray:hConstr];
        
        
        NSArray *vConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[playView(20)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _originalConstraints = [_originalConstraints arrayByAddingObjectsFromArray:vConstr];
        
    }
    return _originalConstraints;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    [self.contentView addConstraints:self.originalConstraints];
    [self.view addConstraints:self.contentViewConstraints];
}
@end

