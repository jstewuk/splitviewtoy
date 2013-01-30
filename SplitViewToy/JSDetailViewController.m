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
@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) NSDictionary *viewsDictionary;
@property (nonatomic, strong) NSDictionary *metricsDictionary;
@property (nonatomic, strong) NSArray *expConstraints;
@property (nonatomic, strong) NSArray *contentViewConstraints;
@property (nonatomic, strong) NSArray *viewConstraints;

@end

@implementation JSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isExpanded = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // add gesture recognizer
    UIGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:gr];

    // remove autoresize constraints
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    JSView *contentView = [[JSView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    CGRect rect = CGRectMake(0, 0, 20, 20);
    UIView *playView = [[UIView alloc] initWithFrame:rect];
    [playView setBackgroundColor:[UIColor blueColor]];
    playView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:playView];
    _playView = playView;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
    
    CGRect frame = {CGPointZero, [self superSize]};
    self.contentView.frame = frame;
    
 
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.contentView addConstraints:self.originalConstraints];
    
    [self.view addConstraints:self.contentViewConstraints];
    
    NSLog(@"autolayout Trace: %@", [[UIWindow keyWindow] _autolayoutTrace]);
    //[self.view setNeedsLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setExpandedConstraints {
    self.isExpanded = !self.isExpanded;
    
    if (self.isExpanded) {
        [self.contentView removeConstraints:self.originalConstraints];
        [self.contentView addConstraints:self.expConstraints];
    } else {
        [self.contentView removeConstraints:self.expConstraints];
        [self.contentView addConstraints:self.originalConstraints];
    }
}

- (IBAction)handleTap:(id)sender {
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
    [self setExpandedConstraints];
    
    NSLog(@"%@", [[UIWindow keyWindow] _autolayoutTrace]);
}

- (NSDictionary *)viewsDictionary {
    if (! _viewsDictionary ) {
        _viewsDictionary = (@{@"mView" : self.contentView,
                            @"playView" : self.playView,
                            @"mainView" : self.view });
    }
    return _viewsDictionary;
}

- (NSDictionary *)metricsDictionary {
    if (! _metricsDictionary ) {
        NSNumber *widthNum = @([self superSize].width);
        NSNumber *heightNum = @([self superSize].height);
        _metricsDictionary = @{@"superWidth": widthNum,  @"superHeight": heightNum};
    }
    return _metricsDictionary;
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

- (NSArray *)expConstraints {
    
    if ( ! _expConstraints ) {
        NSArray *hConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[playView(30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _expConstraints =  [NSArray arrayWithArray:hConstr];
        
        NSArray *vConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[playView(30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _expConstraints = [_expConstraints arrayByAddingObjectsFromArray:vConstr];
        
    }
    return _expConstraints;
}

- (NSArray *)viewConstraints {
    if (! _viewConstraints) {
        NSArray *hConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-320-[mainView]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _viewConstraints =  [NSArray arrayWithArray:hConstr];
        
        NSArray *vConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainView]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:self.viewsDictionary];
        _viewConstraints =  [_viewConstraints arrayByAddingObjectsFromArray:vConstr];
    }
    return _viewConstraints;
}

- (CGSize)superSize  {
    return [self.view superview].frame.size;
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    NSLog(@"%@: %@", self, NSStringFromSelector(_cmd));
    
    [[self.view superview] addConstraints:self.viewConstraints];
}
@end

