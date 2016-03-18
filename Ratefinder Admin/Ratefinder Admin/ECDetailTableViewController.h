//
//  ECAddSiteTableViewController.h
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ECDetailTableViewController;

@protocol ECDetailTableViewControllerDelegate <NSObject>

- (void)setSomeLabelText:(ECDetailTableViewController *)controller enteringItem:(NSString *)item;

@end

@interface ECDetailTableViewController : UITableViewController

@property (nonatomic, readwrite) NSString *nameSite;
@property (nonatomic, readwrite) NSString *urlSite;
@property (nonatomic, readwrite) BOOL isDetail;
@property (nonatomic, readwrite) NSIndexPath *indexPath;

@property (nonatomic, weak) id <ECDetailTableViewControllerDelegate> delegate;

@end
