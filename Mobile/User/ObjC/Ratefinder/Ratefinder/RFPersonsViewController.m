//
//  RFPersonsViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFPersonsViewController.h"
#import "RFDateViewController.h"
#import "RFRepository.h"

@implementation RFPersonsViewController
{
    RFRepository *repository;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    repository = [RFRepository sharedRepository];
    self.navigationItem.title = repository.currentSite.name;
}

- (NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return [repository.persons count];
}


- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSString *sitesTableIdentifier = @"PersonsTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: sitesTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: sitesTableIdentifier];
    }
    
    cell.textLabel.text = [[[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] person] name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] rate]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    repository.currentPerson = [[repository.personsWithRatesOnCurrentSite objectAtIndex:indexPath.row] person];
    [self performSegueWithIdentifier:@"ShowRatesPerDay" sender:self];
}

@end
