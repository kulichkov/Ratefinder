//
//  ECAddSiteTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECAddSiteTableViewController.h"

@interface ECAddSiteTableViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *siteNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *siteUrlTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation ECAddSiteTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UITapGestureRecognizer *handlerTap = 

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navagation

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)add:(id)sender {
    
    
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.siteNameTextField]) {
        [self.siteNameTextField resignFirstResponder];
    }
    
    if ([textField isEqual:self.siteUrlTextField]) {
        [self.siteUrlTextField resignFirstResponder];
    }
    
    return YES;
}

- (IBAction)textFieldDidChange:(UITextField *)textField {
    
    if ([self.siteNameTextField.text length] > 0 && [self.siteUrlTextField.text length] > 0 ) {
        self.saveButton.enabled = YES;
        
    } else {
        self.saveButton.enabled = NO;
    }
}


- (void) handleEditing {
    
    [self.siteNameTextField resignFirstResponder];
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
