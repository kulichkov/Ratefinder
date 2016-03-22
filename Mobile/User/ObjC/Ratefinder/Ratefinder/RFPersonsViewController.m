//
//  RFPersonsViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFPersonsViewController.h"
#import "RFRepository.h"

@implementation RFPersonsViewController
{
    RFRepository *repository;
    NSArray *personsWithRates;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    repository = [RFRepository sharedRepository];
    personsWithRates = [repository getRatesOnSite: self.site];
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
    
    RFPersonWithRate *personWithRate = [personsWithRates objectAtIndex: indexPath.row];
    cell.textLabel.text = personWithRate.person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",personWithRate.rate];
    return cell;
}


@end
