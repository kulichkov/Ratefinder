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


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([segue.identifier isEqualToString:@"detailView"]) {
//        
//        ECDetailTableViewController *detailViewController = [segue destinationViewController];
//        
//        detailViewController.nameSite = self.nameSite;
//        detailViewController.urlSite = self.urlSite;
//        detailViewController.isDetail = YES;
//        
//        [detailViewController setDelegate:self];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arraySites = [NSMutableArray arrayWithObjects: @"Lenta.ru", @"Взгляд", @"Аргументы и факты", nil];
    self.arraySitesUrl = [NSMutableArray arrayWithObjects:@"http://www.lenta.ru", @"http://www.vz.ru", @"http://www.aif.ru", nil];
    
    self.nameSite = @"test";
    self.urlSite = @"https://test.ru";
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
//    return [self.arraySites count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
//    cell.textLabel.text = [self.arraySites objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text = [self.arraySitesUrl objectAtIndex:indexPath.row];
    
    cell.textLabel.text = self.nameSite;
    cell.detailTextLabel.text = self.urlSite;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ECPersonsTableViewController *personsTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"personsView"];
    
    [self.navigationController pushViewController:personsTableView animated:YES];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    ECDetailTableViewController *detailTableView = [self.storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    detailTableView.nameSite = [self.arraySites objectAtIndex:indexPath.row];
    detailTableView.urlSite = [self.arraySitesUrl objectAtIndex:indexPath.row];
    
    detailTableView.nameSite = self.nameSite;
    detailTableView.urlSite = self.urlSite;
    detailTableView.isDetail = YES;
    detailTableView.indexPath = indexPath;
    
    [detailTableView setDelegate:self];
    
    [self.navigationController pushViewController:detailTableView animated:YES];
}

#pragma mark - Protocol Methods

//-(void)setNameSite:(NSString *)nameSite {
//    self.nameSite = nameSite;
//}
//
//-(void)setUrlSite:(NSString *)urlSite {
//    self.urlSite = urlSite;
//}

@end


