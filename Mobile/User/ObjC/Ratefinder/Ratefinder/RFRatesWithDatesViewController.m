//
//  RFRatesWithDatesViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 23/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFRatesWithDatesViewController.h"

@implementation RFRatesWithDatesViewController
{
    RFRepository *repository;
}

- (void)personsDidUpdate{};
- (void)personsWithRatesDidUpdate{};
- (void)sitesDidUpdate{};

-(void)ratesWithDatesDidUpdate
{
    [self.tableView reloadData];
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
    [repository updateRatesOfCurrentPersonOnCurrentSite];
    self.navigationItem.title = repository.currentPerson.name;
}


- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return [repository.ratesOfCurrentPersonWithDatesOnCurrentSite count];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *sitesTableIdentifier = @"RatesTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: sitesTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: sitesTableIdentifier];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate: [[repository.ratesOfCurrentPersonWithDatesOnCurrentSite objectAtIndex:indexPath.row] date]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", [[repository.ratesOfCurrentPersonWithDatesOnCurrentSite objectAtIndex:indexPath.row] rate]];
    return cell;
}

@end
