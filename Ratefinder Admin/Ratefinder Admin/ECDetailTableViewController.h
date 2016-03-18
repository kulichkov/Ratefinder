//
//  ECAddSiteTableViewController.h
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECDetailTableViewController : UITableViewController

@property (nonatomic, readwrite) NSString *nameSite;
@property (nonatomic, readwrite) NSString *urlSite;
@property (nonatomic, readwrite) BOOL isDetail;

@end
