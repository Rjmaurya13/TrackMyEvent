//
//  ViewController.m
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/1/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import "HomeViewController.h"
#import "ListViewController.h"
#import <QuartzCore/QuartzCore.h>

#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2
#define RIGHT_PANEL_TAG 3

#define CORNER_RADIUS 4

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface HomeViewController () {
    NSArray *eventArray;
}

@end

@implementation HomeViewController
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Track Your Event";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EventList" ofType:@"plist"];
    eventArray = [[NSArray alloc] initWithContentsOfFile:path];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    [self setUpView:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)setUpView:(BOOL)isEnable {
    continueButton.enabled = NO;
}

-(void)movePanel:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [delegate movePanelLeft];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [delegate hidePanel];
    }
}

#pragma mark - TextFied Delegate 

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}

#pragma mark - IBAction Method
-(IBAction)onContinueButtonClick:(id)sender {
    if (nameTextField.text.length >0) {
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSString *name = [nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        appDelegate.userName = name;
    }
    [self performSegueWithIdentifier:@"ListVC" sender:self];
}

-(IBAction)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        continueButton.enabled = YES;
    } else {
        continueButton.enabled = NO;
    }
}
-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"ListVC"]) {
        ListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ListVC"];
        controller.eventArray = eventArray;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
