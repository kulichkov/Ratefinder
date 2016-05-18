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
    RFRepository *repository;
}

-(void)updateDidStart
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)updateDidFinish
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    repository = [RFRepository sharedRepository];
    repository.delegate = self;
    self.navigationItem.title = @"Сайты";
    [repository updateSites];
    [repository updatePersons];
}

- (void)personsDidUpdate{};
- (void)personsWithRatesDidUpdate{};
- (void)ratesWithDatesDidUpdate{};


- (void)sitesDidUpdate
{
    [self.tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [repository.sites count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sitesTableIdentifier = @"SitesTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sitesTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sitesTableIdentifier];
    }
    cell.textLabel.text = [[repository.sites objectAtIndex:indexPath.row] name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    repository.currentSite = [repository.sites objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowPersons" sender:self];
}
 

@end
