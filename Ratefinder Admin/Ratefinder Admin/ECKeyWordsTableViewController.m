//
//  ECKeyWordsTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECKeyWordsTableViewController.h"
#import "ECKeywords.h"

@interface ECKeyWordsTableViewController ()

@property (strong, nonatomic) NSMutableArray *keywords;

@end

@implementation ECKeyWordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keywords = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.keywords addObject:[ECKeywords randomKeyword]];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keywords count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CellKeyWord";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
    ECKeywords *keywords = [self.keywords objectAtIndex:indexPath.row];
    
    cell.textLabel.text = keywords.name;
    return cell;
}

@end
