//
//  RFPersonsViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFPersonsViewController.h"
#import "RFDateViewController.h"

@implementation RFPersonsViewController
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
    self.navigationItem.title = repository.currentSite.name;
    [repository updatePersonsWithRatesOnCurrentSite];

}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return [repository.persons count];
}

- (void)personsDidUpdate{};
- (void)ratesWithDatesDidUpdate{};
- (void)sitesDidUpdate{};
- (void)personsWithRatesDidUpdate
{
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *personsTableIdentifier = @"PersonsTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: personsTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: personsTableIdentifier];
    }
    
    cell.textLabel.text = [[[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] person] name];
    NSInteger rate = [[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] rate];
    cell.detailTextLabel.text = rate ? [NSString stringWithFormat:@"%d", rate] : @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    repository.currentPerson = [[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] person];
    [self performSegueWithIdentifier:@"ShowRatesPerDay" sender:self];
}

@end
