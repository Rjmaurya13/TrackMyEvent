//
//  ListTableViewCell.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UILabel *title;
@property (nonatomic,strong) IBOutlet UILabel *entryType;
@property (nonatomic,strong) IBOutlet UIImageView *eventImage;
@property (nonatomic,strong) IBOutlet UILabel *eventPlace;
@end
