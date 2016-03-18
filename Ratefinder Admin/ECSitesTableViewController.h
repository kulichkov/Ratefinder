//
//  ECSitesTableViewController.h
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECDetailTableViewController.h"

@interface ECSitesTableViewController : UITableViewController <ECDetailTableViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *arraySites;
@property (nonatomic, strong) NSMutableArray *arraySitesUrl;

@end
