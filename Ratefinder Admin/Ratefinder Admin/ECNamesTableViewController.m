//
//  ECNamesTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECNamesTableViewController.h"
#import "ECPerson.h"
#import "ECFakeRepository.h"

@interface ECNamesTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *persons;

@end

@implementation ECNamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.persons = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.persons addObject:[ECFakeRepository getRandomSite]];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellName";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
    ECPerson *person = [self.persons objectAtIndex:indexPath.row];
    
    cell.textLabel.text = person.name;
    return cell;
}

@end
