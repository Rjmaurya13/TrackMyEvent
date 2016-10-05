//
//  ViewController.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/1/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingViewController.h"
#import "AppDelegate.h"

@protocol HomeViewControllerDelegate <NSObject>

@optional
- (void)movePanelLeft;
- (void)movePanelRight;
- (void)hidePanel;

@required
- (void)movePanelToOriginalPosition;

@end

@interface HomeViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *nameTextField;
    IBOutlet UIButton *continueButton;
}
@property (nonatomic, assign) id<HomeViewControllerDelegate> delegate;

@end

