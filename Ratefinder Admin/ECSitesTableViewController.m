//
//  ECSitesTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECSitesTableViewController.h"
#import "ECPersonsTableViewController.h"

static NSString *kCellID = @"Cell";

@interface ECSitesTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ECSitesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arraySitesName = [NSMutableArray arrayWithObjects: @"Lenta.ru", @"Взгляд", @"Аргументы и факты", nil];
    self.arraySitesUrl = [NSMutableArray arrayWithObjects:@"http://www.lenta.ru", @"http://www.vz.ru", @"http://www.aif.ru", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
   }

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arraySitesName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    cell.textLabel.text = [self.arraySitesName objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.arraySitesUrl objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ECPersonsTableViewController *personsTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"personsView"];
    
    [self.navigationController pushViewController:personsTableView animated:YES];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    ECDetailTableViewController *detailTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    detailTableView.nameSite = [self.arraySitesName objectAtIndex:indexPath.row];
    detailTableView.urlSite = [self.arraySitesUrl objectAtIndex:indexPath.row];
    
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


#pragma mark - Protocol Methods

-(void)addSiteName:(NSString *)name url:(NSString *)url {
    [self.arraySitesName addObject:name];
    [self.arraySitesUrl addObject:url];
}

-(void)editSiteName:(NSString *)name url:(NSString *)url indexPath:(NSIndexPath *)indexPath {
    [self.arraySitesName setObject:name atIndexedSubscript:indexPath.row];
    [self.arraySitesUrl setObject:url atIndexedSubscript:indexPath.row];
}
@end


