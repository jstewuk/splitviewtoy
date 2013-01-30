//
//  JSContainerViewController.h
//  SplitViewToy
//
//  Created by James Stewart on 1/30/13.
//  Copyright (c) 2013 StewartStuff. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    Container view controller to manage a left view controller, a right view controller and a background view
    controller.  
    - Handles Autorotation
    - Handles left shifting of rightViewController in both orientations
    - Handles right shifting of righViewController in both orientations
    - In landscape, exposes bacground view on right when shifted to the left
    - Uses autolayout
*/

@protocol JSContainerViewControllerProtocol<NSObject>
- (void)shiftViewLeft:(id)sender;
- (void)shiftViewRight:(id)sender;
@end

@interface JSContainerViewController : UIViewController
@property (nonatomic, copy) IBOutlet UIViewController *leftViewController;
@property (nonatomic, copy) IBOutlet UIViewController *rightViewController;
@property (nonatomic, copy) IBOutlet UIViewController *backGroundViewController;
@end
