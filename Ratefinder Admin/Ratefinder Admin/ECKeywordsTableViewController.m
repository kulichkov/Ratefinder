//
//  ECKeyWordsTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 24.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECKeywordsTableViewController.h"
#import "ECKeywords.h"
#import "ECFakeRepository.h"

@interface ECKeywordsTableViewController ()

@property (strong, nonatomic) NSMutableArray *keywords;

@end

@implementation ECKeywordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keywords = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        [self.keywords addObject:[ECFakeRepository getRandomKeyword]];
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
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing) {
        item = UIBarButtonSystemItemDone;
    }
    
    UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item target:self action:@selector(actionEdit:)];
    
    [self.navigationItem setRightBarButtonItem:itemButton animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keywords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        static NSString *newKeywordIdentifier = @"newKeywordCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newKeywordIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:newKeywordIdentifier];
            
            cell.textLabel.text = @"Добавить ключевое слово";
            cell.textLabel.textColor = [UIColor blueColor];
        }
        
        cell.textLabel.text = @"Добавить ключевое слово";
        cell.textLabel.textColor = [UIColor blueColor];
        return cell;
        
    } else {
        
        static NSString *keywordIdentifier = @"keywordCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:keywordIdentifier forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:keywordIdentifier];
            
            ECKeywords *keywords = [self.keywords objectAtIndex:indexPath.row];
            
            cell.textLabel.text = keywords.name;
        }
        
        ECKeywords *keywords = [self.keywords objectAtIndex:indexPath.row];
        
        cell.textLabel.text = keywords.name;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        ECKeywords *keyword = [self.keywords objectAtIndex:indexPath.row];
        
        [self.keywords removeObject:keyword];
        
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
        
        NSInteger newKeywordIndex = 0;
        [self.keywords insertObject:[ECFakeRepository getRandomKeyword ] atIndex:newKeywordIndex];
        
        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newKeywordIndex + 1 inSection:indexPath.section];
        
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
    }
}

@end
