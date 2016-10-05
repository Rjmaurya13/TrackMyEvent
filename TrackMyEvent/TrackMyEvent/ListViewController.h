//
//  ListViewController.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingViewController.h"
#import <CoreData/CoreData.h>

@interface ListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,NSFetchedResultsControllerDelegate> {
    IBOutlet UICollectionView *collectionView;
    IBOutlet UITableView *mainTableView;
    IBOutlet UITableView *sidePanelTableView;
    IBOutlet UIView *sideView;
    IBOutlet UIView *centerView;
    IBOutlet UIButton *gridButton;
}
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) TrackingViewController *trackingViewController;
@property (nonatomic,strong) NSArray *eventArray;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;


@end
