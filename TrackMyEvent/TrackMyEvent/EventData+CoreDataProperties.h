//
//  EventData+CoreDataProperties.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/5/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EventData.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSString *place;
@property (nullable, nonatomic, retain) NSString *entryType;
@property (nullable, nonatomic, retain) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
