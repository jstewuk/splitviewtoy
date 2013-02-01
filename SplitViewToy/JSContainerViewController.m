//
//  JSContainerViewController.m
//  SplitViewToy
//
//  Created by James Stewart on 1/30/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import "JSContainerViewController.h"
#import "JSView.h"
#import "JSTapGestureRecognizer.h"

typedef enum  {
    JSContainerViewControllerStateLeft = 0,
    JSContainerViewControllerStateRight
} JSContainerViewControllerState;

@interface JSContainerViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSDictionary* viewsDictionary;
@property (nonatomic, strong) NSArray* viewRightPositionConstraints;
@property (nonatomic, strong) NSArray* viewLeftPositionConstraints;
@property (nonatomic, assign) JSContainerViewControllerState controllerState;
@property (nonatomic, strong) JSView *leftContainerView;
@property (nonatomic, strong) JSView *rightContainerView;

@end

@implementation JSContainerViewController

- (id)init {
    self = [super init];
    if (self) {
        _controllerState = JSContainerViewControllerStateRight;
    }
    return self;
}

- (void)loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    UIView *contentView = [[UIView alloc] initWithFrame:applicationFrame];
    contentView.backgroundColor = [UIColor redColor];
    self.view = contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addChildViewController:self.leftViewController];
    [self.view addSubview:self.leftContainerView];
    [self.leftContainerView addSubview:self.leftViewController.view];
    [self constrainView:self.leftViewController.view toBoundsOf:self.leftContainerView];
    [self.leftViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.rightViewController];
    [self.view addSubview:self.rightContainerView];
    [self.rightContainerView addSubview:self.rightViewController.view];
    [self constrainView:self.rightViewController.view toBoundsOf:self.rightContainerView];
    [self.rightViewController didMoveToParentViewController:self];
    
    [self addChildViewController:self.backGroundViewController];
    [self.view addSubview:self.backGroundViewController.view];
    //[self constrainView:self.backGroundViewController.view toBoundsOf:self.view];  //can't be satisfied
    [self.backGroundViewController didMoveToParentViewController:self];
    
    self.rightViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addTapGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    if (self.controllerState == JSContainerViewControllerStateRight) {
        [self.view removeConstraints:self.viewLeftPositionConstraints];
        [self.view addConstraints:self.viewRightPositionConstraints];
    } else {
        [self.view removeConstraints:self.viewRightPositionConstraints];
        [self.view addConstraints:self.viewLeftPositionConstraints];
    }
}



- (void)constrainView:(UIView *)innerView toBoundsOf:(UIView*)outerView {
    NSDictionary *viewDict = @{@"innerView":innerView,
                               @"outerView":outerView};
    NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[innerView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDict];
    NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[innerView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDict];
    [outerView addConstraints:[hConstraint arrayByAddingObjectsFromArray:vConstraint]];
}

#pragma mark - accessors

- (JSView*)rightContainerView {
    if (! _rightContainerView) {
        _rightContainerView = [[JSView alloc] initWithFrame:CGRectZero];
        [_rightContainerView setHasShadow:YES];
        _rightContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _rightContainerView;
}

- (JSView*)leftContainerView {
    if (! _leftContainerView) {
        _leftContainerView = [[JSView alloc] initWithFrame:CGRectZero];
        [_leftContainerView setHasShadow:NO];
        _leftContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _leftContainerView;
}

- (NSDictionary *)viewsDictionary {
    if (! _viewsDictionary ) {
        _viewsDictionary = (@{@"rView" : self.rightViewController.view,
                            @"lView" : self.leftViewController.view,
                            @"bgView" : self.backGroundViewController.view,
                            @"lContainerView" : self.leftContainerView,
                            @"rContainerView" : self.rightContainerView});
    }
    return _viewsDictionary;
}

- (NSArray*)viewRightPositionConstraints {
    if (! _viewRightPositionConstraints) {
        _viewRightPositionConstraints = [NSArray array];
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-320-[rContainerView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:self.viewsDictionary];
        _viewRightPositionConstraints = [_viewRightPositionConstraints arrayByAddingObjectsFromArray:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rContainerView]|"
                                                              options:0
                                                              metrics:nil
                                                                views:self.viewsDictionary];
        _viewRightPositionConstraints = [_viewRightPositionConstraints arrayByAddingObjectsFromArray:constraints];
    }
    return _viewRightPositionConstraints;
}

- (NSArray*)viewLeftPositionConstraints {
    if (! _viewLeftPositionConstraints) {
        _viewLeftPositionConstraints = [NSArray array];
        NSArray *constraints;
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[rContainerView]-320-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:self.viewsDictionary];
        _viewLeftPositionConstraints = [_viewLeftPositionConstraints arrayByAddingObjectsFromArray:constraints];
        
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rContainerView]|"
                                                              options:0
                                                              metrics:nil
                                                                views:self.viewsDictionary];
        _viewLeftPositionConstraints = [_viewLeftPositionConstraints arrayByAddingObjectsFromArray:constraints];
    }
    return _viewLeftPositionConstraints;
}

#pragma mark - Pan Gesture Recognizer

// start with Tap GR to bootstrap
- (void)addTapGestureRecognizer {
    
    /*
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.delegate = self;
    [self.rightViewController.view addGestureRecognizer:tapGR];
    */
    
    JSTapGestureRecognizer *tapGR = [[JSTapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGR.delegate = self;
    [self.view addGestureRecognizer:tapGR];
}

- (void)handleTap:(UIGestureRecognizer*)tapGR {
    self.controllerState = (self.controllerState == JSContainerViewControllerStateLeft) ? JSContainerViewControllerStateRight : JSContainerViewControllerStateLeft;
    
    [self.view setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return YES;
}

/*
- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGR.delegate = self;
    panGR.maximumNumberOfTouches = 1;
    panGR.minimumNumberOfTouches = 1;
    [self.rightViewController.view addGestureRecognizer:panGR];
}

- (void)handlePan:(UIGestureRecognizer*)sender {
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGR = (UIPanGestureRecognizer*)sender;
        
        if (panGR.state == UIGestureRecognizerStateBegan) {
            
        }
        switch (self.controllerState) {
            case JSContainerViewControllerStateLeft:
                ;
                break;
            case JSContainerViewControllerStateRight:
                ;
                break;
            default:
                break;
        }
    }
}
*/




#pragma mark -

- (void)shiftViewLeft:(id)sender; {
    
}

- (void)shiftViewRight:(id)sender; {
    
}

@end
