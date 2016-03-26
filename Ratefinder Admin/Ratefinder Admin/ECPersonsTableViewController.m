//
//  ECNamesTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECPersonsTableViewController.h"
#import "ECPerson.h"
#import "ECFakeRepository.h"
#import "ECKeywordsTableViewController.h"

@interface ECPersonsTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *persons;

@end

@implementation ECPersonsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.persons = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.persons addObject:[ECFakeRepository getRandomPerson]];
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    [self.navigationItem setRightBarButtonItem:itemButton animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.persons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        static NSString *newKeywordIdentifier = @"newPersonCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newKeywordIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newKeywordIdentifier];
            
            cell.textLabel.text = @"Добавить имя";
            cell.textLabel.textColor = [UIColor blueColor];
        }
        
        cell.textLabel.text = @"Добавить имя";
        cell.textLabel.textColor = [UIColor blueColor];
        return cell;
        
    } else {
        
        static NSString *keywordIdentifier = @"personCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keywordIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:keywordIdentifier];
            
            ECPerson *person = [self.persons objectAtIndex:indexPath.row];
            
            cell.textLabel.text = person.name;
        }
        
        ECPerson *person = [self.persons objectAtIndex:indexPath.row];
        
        cell.textLabel.text = person.name;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ECPerson *person = [self.persons objectAtIndex:indexPath.row];
        
        [self.persons removeObject:person];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Удалить";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        NSInteger newPersonIndex = 0;
        [self.persons insertObject:[ECFakeRepository getRandomKeyword ] atIndex:newPersonIndex];
        
        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newPersonIndex + 1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    } else {
        
        ECKeywordsTableViewController *keywordTableViewController = [[ECKeywordsTableViewController alloc] init];
        
//        [self.navigationController pushViewController:keywordTableViewController animated:YES];
    }
}

@end
