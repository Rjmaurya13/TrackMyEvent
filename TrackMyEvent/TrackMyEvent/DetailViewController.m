//
//  DetailViewController.m
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    AppDelegate * appdelegate;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isFromTracking) {
        trackButton.hidden = YES;
        trackButton.userInteractionEnabled = NO;
    }
    self.titleLabel.text = self.event.title;
    self.eventPlace.text = self.event.place;
    self.entryType.text = self.event.entryType;
    self.eventImage.image = [UIImage imageNamed:self.event.imageName];

    appdelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = [appdelegate managedObjectContext];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onBackButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)onTrackEventButtonClick:(id)sender {
    [self insertNewObject:self];
}

- (void)insertNewObject:(id)sender {
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    EventData *eventModel = [NSEntityDescription insertNewObjectForEntityForName:@"EventData" inManagedObjectContext:context];
    eventModel.title = self.event.title;
    eventModel.place = self.event.place;
    eventModel.entryType = self.event.entryType;
    eventModel.imageName = self.event.imageName;
    eventModel.userId = appdelegate.userName;

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
