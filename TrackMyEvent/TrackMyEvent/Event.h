//
//  Event.h
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EventData.h"

@interface Event : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *entryType;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *place;

-(id)initWithDictionary:(NSDictionary *)dic;
-(id)initWithObject:(EventData *)dic;
@end
