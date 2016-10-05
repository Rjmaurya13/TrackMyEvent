//
//  TrackingViewController.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/3/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EventData.h"

@interface TrackingViewController : UIViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *trackingEventArray;

@end
