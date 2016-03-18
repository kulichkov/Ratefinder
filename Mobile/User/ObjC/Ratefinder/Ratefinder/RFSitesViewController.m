//
//  RFSitesViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFSitesViewController.h"

@implementation RFSitesViewController
{
    NSString *selectedSite;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Сайты";
    sitesData = [NSArray arrayWithObjects:
                 @"lenta.ru",
                 @"gazeta.ru",
                 @"vesti.ru",
                 @"aif.ru",
                 nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sitesData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sitesTableIdentifier = @"SitesTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sitesTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sitesTableIdentifier];
    }
    
    cell.textLabel.text = [sitesData objectAtIndex:indexPath.row];
    
    return cell;
}

@end
