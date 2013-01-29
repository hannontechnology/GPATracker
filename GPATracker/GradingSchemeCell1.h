//
//  GradingSchemeCell1.h
//  GPATracker
//
//  Created by David Stevens on 12-09-12.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradingSchemeCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabel1;
@property (weak, nonatomic) IBOutlet UITextField *cellField1;
@property (weak, nonatomic) IBOutlet UITextField *minGrade;
@property (weak, nonatomic) IBOutlet UIButton *btnInGPA;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
