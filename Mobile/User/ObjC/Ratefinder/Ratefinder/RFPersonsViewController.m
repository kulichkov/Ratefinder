//
//  RFPersonsViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 18/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFPersonsViewController.h"

@implementation RFPersonsViewController
{
    NSArray *personsData;
    NSArray *ratesData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //очень плохой код для заглушки
    personsData = [NSArray arrayWithObjects:
                  @"Путин",
                  @"Медведев",
                  @"Навальный",
                  @"Жириновский",
                  nil];
    ratesData = [NSArray arrayWithObjects:
                 [NSNumber numberWithInt:100500],
                 [NSNumber numberWithInt:2334],
                 [NSNumber numberWithInt:120],
                 [NSNumber numberWithInt:5],
                 nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personsData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sitesTableIdentifier = @"PersonsTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sitesTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sitesTableIdentifier];
    }
    
    //тут 2 строки плохого кода. Исправлю.
    cell.textLabel.text = [personsData objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[ratesData objectAtIndex:indexPath.row] stringValue];
    
    return cell;
}


@end
