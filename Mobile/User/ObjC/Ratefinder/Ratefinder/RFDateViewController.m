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

    [self.finishDateTextField setInputView:datePicker];
    [self.startDateTextField setInputView:datePicker];
}

@end
