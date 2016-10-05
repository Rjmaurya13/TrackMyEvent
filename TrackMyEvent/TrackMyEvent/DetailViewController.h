//
//  DetailViewController.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "EventData.h"

@interface DetailViewController : UIViewController <NSFetchedResultsControllerDelegate> {
    IBOutlet UIButton *trackButton;
}
@property (nonatomic) BOOL isFromTracking;
@property (nonatomic,strong) Event *event;
@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UILabel *entryType;
@property (nonatomic,strong) IBOutlet UIImageView *eventImage;
@property (nonatomic,strong) IBOutlet UILabel *eventPlace;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end
