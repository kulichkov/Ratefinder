//
//  RFSitesViewController.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFSitesViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *sitesData;
}

@end
