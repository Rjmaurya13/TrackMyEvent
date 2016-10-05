//
//  Event.m
//  TrackMyEvent
//
//  Created by Rajesh Maurya on 10/2/16.
//  Copyright © 2016 Rajesh Maurya. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize title,imageName,place,entryType;

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        if (dic!= nil) {
            self.title = [dic valueForKey:@"title"];
            self.place = [dic valueForKey:@"place"];
            self.entryType = [dic valueForKey:@"entryType"];
            self.imageName = [dic valueForKey:@"image"];            
        }
    }
    return self;
}

-(id)initWithObject:(EventData *)dic {
    self = [super init];
    if (self) {
        if (dic!= nil) {
            self.title = dic.title;
            self.place = dic.place;
            self.entryType =dic.entryType;
            self.imageName = dic.imageName;
        }
    }
    return self;
}
@end
