//
//  ECSitesTableViewController.h
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDetailTableViewController.h"

@interface ECSitesTableViewController : UITableViewController <ECPassDetailSite>

@property (nonatomic, strong) NSMutableArray *arraySitesName;
@property (nonatomic, strong) NSMutableArray *arraySitesUrl;

@end
