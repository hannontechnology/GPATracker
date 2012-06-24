//
//  SelectGradingSchemeView.h
//  GPATracker
//
//  Created by David Stevens on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataCollection;
@class GradingScheme;

@interface SelectGradingSchemeView : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    IBOutlet UILabel *mlabel;
    NSMutableArray *arrayNo;
    IBOutlet UIPickerView *pickerView;
}

@property (nonatomic, retain) UILabel *mlabel;
@property (weak, nonatomic) IBOutlet UIPickerView *GradingSchemePicker;



@end
