//
//  RFSitesViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFSitesViewController.h"
#import "RFRepository.h"

@implementation RFSitesViewController
{
    RFRepository *repository;
}

//имя перехода на сцену персон
static NSString *segueIDToPersons = @"ShowPersons";

- (void)viewDidLoad
{
    [super viewDidLoad];
    repository = [[RFRepository alloc] init];
    
    self.navigationItem.title = @"Сайты";
    
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
    RFSite *site = [repository.sites objectAtIndex:indexPath.row];
    cell.textLabel.text = site.name;
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //при переходе изменяется титул контроллера назначения на имя нажатой ячейки в текущем контроллере
    if ([segue.identifier isEqual: segueIDToPersons]) {
        NSIndexPath *selectedCellIndexPath = [self.tableView indexPathForSelectedRow];
        RFSite *site = [repository.sites objectAtIndex:selectedCellIndexPath.row];
        [segue destinationViewController].title = site.name;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:segueIDToPersons sender:self];
}
 

@end
