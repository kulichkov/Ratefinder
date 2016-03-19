//
//  ECAddSiteTableViewController.m
//  Ratefinder Admin
//
//  Created by Александр on 18.03.16.
//  Copyright © 2016 Epic-Creators. All rights reserved.
//

#import "ECDetailTableViewController.h"
#import "ECSitesTableViewController.h"

@interface ECDetailTableViewController () <UITextFieldDelegate>

@end

@implementation ECDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleEditing)];
    
    [self.view addGestureRecognizer:handleTap];
    
    if (self.isDetail) {
        
        self.siteNameTextField.text = self.nameSite;
        self.siteUrlTextField.text = self.urlSite;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navagation

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    
    self.nameSite = self.siteNameTextField.text;
    self.urlSite = self.siteUrlTextField.text;
    
    [[self delegate] setNameSite:self.nameSite];
    [[self delegate] setUrlSite:self.urlSite];
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    if ([self.siteNameTextField.text length] > 0 && [self.siteUrlTextField.text length] > 0) {
        if ([textField.text isEqual:self.nameSite] || [textField.text isEqual:self.urlSite]) {

            self.saveButton.enabled = NO;
            
        } else {
            self.saveButton.enabled = YES;
        }
        
    } else {
        self.saveButton.enabled = NO;
    }
}


- (void) handleEditing {
    
    [self.view endEditing:YES];
}

@end
