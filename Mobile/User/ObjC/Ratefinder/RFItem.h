//
//  RFItem.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 11/05/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFItem : NSObject
@property NSString *name;
@property int identificator;
@end
typedef RFItem RFSite;
typedef RFItem RFPerson;
typedef enum : NSUInteger {
    RFSiteItem,
    RFPersonItem,
} RFItemType;