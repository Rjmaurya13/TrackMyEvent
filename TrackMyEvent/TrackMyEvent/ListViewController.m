//
//  ListViewController.m
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "GridCollectionViewCell.h"
#import "Event.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

#define CORNER_RADIUS 4
#define TrackingEventTag 101

@interface ListViewController () {
    BOOL isGridView;
    NSMutableArray *dataArray;
    AppDelegate * appdelegate;
}
@end

@implementation ListViewController
@synthesize eventArray,trackingViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Event List";
    collectionView.hidden = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Grid-50"] style:UIBarButtonItemStylePlain target:self action:@selector(onGridButtonClick:)];
    
    sideView.translatesAutoresizingMaskIntoConstraints = YES;
    sideView.frame = CGRectMake(self.view.frame.size.width, 0, 200, self.view.frame.size.height);
    sideView.layer.borderWidth = 1;
    
    // Do any additional setup after loading the view.
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
    appdelegate = [UIApplication sharedApplication].delegate;
    _managedObjectContext = [appdelegate managedObjectContext];
}

-(void)viewWillAppear:(BOOL)animated {
    [self hidePanel];
    [self gettingData];
    [mainTableView reloadData];
    [sidePanelTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Method 

-(IBAction)onBackButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onGridButtonClick:(UIButton *)sender {
    isGridView = !isGridView;
    if (isGridView) {
        [sender setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
        mainTableView.hidden = YES;
        mainTableView.userInteractionEnabled = NO;
        collectionView.hidden = NO;
        collectionView.userInteractionEnabled = YES;
        collectionView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0);
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(self.topLayoutGuide.length, 64, 0, 0);

    } else {
        [sender setImage:[UIImage imageNamed:@"Grid-50"] forState:UIControlStateNormal];
        mainTableView.hidden = NO;
        mainTableView.userInteractionEnabled = YES;
        collectionView.hidden = YES;
        collectionView.userInteractionEnabled = NO;
    }
}
#pragma mark - TableView Delegate and Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == TrackingEventTag) {
        return dataArray.count;
    } else {
        return eventArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == TrackingEventTag) {
        static NSString *identifier = @"Cell";
        
        ListTableViewCell *cell = (ListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        EventData *eventData = [dataArray objectAtIndex:indexPath.row];
        cell.title.text = eventData.title;
        cell.entryType.text = eventData.entryType;
        cell.eventPlace.text = eventData.place;
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.eventImage setImage:[self imageWithImage:[UIImage imageNamed:eventData.imageName] scaledToSize:CGSizeMake(80, 80)]];
        });

        return cell;
    } else {
        static NSString *identifier = @"CellIdentifier";
        
        ListTableViewCell *cell = (ListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        Event *event = [[Event alloc] initWithDictionary:[eventArray objectAtIndex:indexPath.row]];
        cell.title.text = event.title;
        cell.entryType.text = event.entryType;
        cell.eventPlace.text = event.place;
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.eventImage setImage:[self imageWithImage:[UIImage imageNamed:event.imageName] scaledToSize:CGSizeMake(80, 80)]];
        });

        return cell;
    }
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == TrackingEventTag) {
        TrackingViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TrackVC"];
        detailViewController.trackingEventArray = dataArray;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    } else {
        DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
        Event *event = [[Event alloc] initWithDictionary:[eventArray objectAtIndex:indexPath.row]];
        
        detailViewController.event = event;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

#pragma mark - CollectionView Cell

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return eventArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CollectionCell";
    GridCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Event *event = [[Event alloc] initWithDictionary:[eventArray objectAtIndex:indexPath.row]];

    collectionViewCell.titleLabel.text = event.title;
    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionViewCell.imageView setImage:[self imageWithImage:[UIImage imageNamed:event.imageName] scaledToSize:CGSizeMake(80, 80)]];
    });

    return collectionViewCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    Event *event = [[Event alloc] initWithDictionary:[eventArray objectAtIndex:indexPath.row]];
    detailViewController.event = event;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void )getRightView:(UISwipeGestureRecognizer *)recognizer {
    // init view if it doesn't already exist
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        sideView.frame = CGRectMake(self.view.frame.size.width - 200, 0, 200, self.view.frame.size.height);
        centerView.frame = CGRectMake(-200, 0, self.view.frame.size.width, self.view.frame.size.height);

    }
     
                     completion:^(BOOL finished) {
                         if (finished) {

                         }
                     }];
}

-(void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value) {
        [self.view.layer setCornerRadius:CORNER_RADIUS];
        [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.view.layer setShadowOpacity:0.8];
        [self.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    } else {
        [self.view.layer setCornerRadius:0.0f];
        [self.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

#pragma mark - Side Panel

- (void)movePanel:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self getRightView:sender];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self hidePanel];
    }
}


-(void)gettingData {
    NSArray *fetchedObjects;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"EventData"  inManagedObjectContext: context];
    [fetch setEntity:entityDescription];
    [fetch setPredicate:[NSPredicate predicateWithFormat:@"userId = %@",appdelegate.userName]];
    NSError * error = nil;
    fetchedObjects = [context executeFetchRequest:fetch error:&error];
    dataArray = [NSMutableArray arrayWithArray:fetchedObjects]; 
}

-(void)hidePanel {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        sideView.frame = CGRectMake(self.view.frame.size.width , 0, 200, self.view.frame.size.height );
        centerView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                         }
                     }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
