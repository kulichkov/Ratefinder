//
//  RFDateViewController.h
//  Ratefinder
//
//  Created by Mikhail Kulichkov on 23/03/16.
//  Copyright © 2016 Epic Creators. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RFRepository.h"

@interface RFDateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *PersonNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *finishDateTextField;
@property (strong, nonatomic) RFPerson *person;
@property (strong, nonatomic) RFSite *site;
@end
