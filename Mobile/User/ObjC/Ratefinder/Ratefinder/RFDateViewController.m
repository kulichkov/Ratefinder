//
//  RFDateViewController.m
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 23/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import "RFDateViewController.h"
#import "RFRepository.h"

@implementation RFDateViewController
{
    NSDate *startDate;
    NSDate *finishDate;
    RFRepository *repository;
}

- (void)viewDidLoad
{
    repository = [RFRepository sharedRepository];
    self.navigationItem.title = repository.currentPerson.name;
    
    //установка вместо клавиатуры спиннера выбора даты
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.finishDateTextField setInputView:datePicker];
    [self.startDateTextField setInputView:datePicker];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)updateTextField:(UIDatePicker *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    if (self.startDateTextField.editing) {
        self.startDateTextField.text = [dateFormatter stringFromDate:sender.date];
    } else if (self.finishDateTextField.editing) {
        self.finishDateTextField.text = [dateFormatter stringFromDate:sender.date];
    }
    
}

@end
