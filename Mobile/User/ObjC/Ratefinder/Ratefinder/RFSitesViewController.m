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
    NSArray *sitesData;
}

//имя перехода на сцену персон
static NSString *segueIDToPersons = @"ShowPersons";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Сайты";
    
    //очень плохой код для заглушки
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
    //строчка плохого кода. Исправить.
    cell.textLabel.text = [sitesData objectAtIndex:indexPath.row];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //при переходе изменяется титул контроллера назначения на имя нажатой ячейки в текущем контроллере
    if ([segue.identifier isEqual: segueIDToPersons]) {
        NSIndexPath *selectedCellIndexPath = [self.tableView indexPathForSelectedRow];
        [segue destinationViewController].title = [sitesData objectAtIndex:selectedCellIndexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:segueIDToPersons sender:self];
}

@end
