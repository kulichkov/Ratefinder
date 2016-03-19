//
//  ECAddSiteTableViewController.h
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECPassDetailSite <NSObject>

- (void)setNameSite:(NSString *)name;
- (void)setUrlSite:(NSString *)url;

@end

@interface ECDetailTableViewController : UITableViewController

@property (nonatomic, strong) NSString *nameSite;
@property (nonatomic, strong) NSString *urlSite;
@property (nonatomic, readwrite) BOOL isDetail;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *passMessage;

@property (nonatomic, weak) id <ECPassDetailSite> delegate;

@property (weak, nonatomic) IBOutlet UITextField *siteNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *siteUrlTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
