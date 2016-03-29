//
//  ECSitesTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECSitesTableViewController.h"
#import "ECSite.h"
#import "ECFakeRepository.h"

@interface ECSitesTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *sites;

@end

@implementation ECSitesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sites = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.sites addObject:[ECFakeRepository getRandomSite]];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

#pragma mark - Actions

- (IBAction)actionEdit:(id)sender {
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonItem *itemButton = nil;
    
    UIBarButtonItemStyle item = UIBarButtonItemStylePlain;
    
    if (self.tableView.editing) {
        itemButton = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:item target:self action:@selector(actionEdit:)];
    } else {
        itemButton = [[UIBarButtonItem alloc] initWithTitle:@"Изменить" style:item target:self action:@selector(actionEdit:)];
    }
    
    [self.navigationItem setLeftBarButtonItem:itemButton animated:YES];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sites count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"siteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
     ECSite *site = [self.sites objectAtIndex:indexPath.row];
    
    cell.textLabel.text = site.name;
    cell.detailTextLabel.text = site.url;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    ECDetailTableViewController *detailTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    ECSite *site = [self.sites objectAtIndex:indexPath.row];
    
    detailTableView.nameSite = site.name;
    detailTableView.urlSite = site.url;
    
    detailTableView.isDetail = YES;
    detailTableView.indexPath = indexPath;
    
    [detailTableView setDelegate:self];
    
    [self.navigationController pushViewController:detailTableView animated:YES];
}

- (IBAction)addSite:(id)sender {
     ECDetailTableViewController *detailTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    detailTableView.isDetail = NO;
    
    [detailTableView setDelegate:self];
    
    [self.navigationController pushViewController:detailTableView animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ECSite *site = [self.sites objectAtIndex:indexPath.row];
        
        [self.sites removeObject:site];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
    }
}

#pragma mark - UITableViewDelegate

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}

#pragma mark - ECPassDetailSite

-(void)addSiteName:(NSString *)name url:(NSString *)url {
    
    ECSite *site = [[ECSite alloc] init];
    site.name = name;
    site.url = url;
    
    [self.sites addObject:site];
}

-(void)editSiteName:(NSString *)name url:(NSString *)url indexPath:(NSIndexPath *)indexPath {
    
    ECSite *site = [[ECSite alloc] init];
    site.name = name;
    site.url = url;
    
    [self.sites setObject:site atIndexedSubscript:indexPath.row];
}
@end


