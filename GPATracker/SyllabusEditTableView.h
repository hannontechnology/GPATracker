//
//  SyllabusEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@class SyllabusDetails;
@class CourseDetails;
@class DataCollection;
@class SemesterDetails;

@interface SyllabusEditTableView : UITableViewController <UIPickerViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *sectionNameField;
@property (weak, nonatomic) IBOutlet UITextField *sectionDesiredGradeField;
@property (weak, nonatomic) IBOutlet UITextField *sectionActualGradeField;
@property (weak, nonatomic) IBOutlet UISwitch *sectionPassFailField;
@property (weak, nonatomic) IBOutlet UISwitch *sectionIncludeInGPAField;
@property (weak, nonatomic) IBOutlet UITextField *sectionPercentageField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;
@property (weak, nonatomic) IBOutlet UITextField *sectionDescriptionField;

@property (strong, nonatomic) NSString *setGradeType;
@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) SyllabusDetails *syllabusDetails;
@property (strong, nonatomic) SemesterDetails *semesterDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

-(IBAction)switchPassFail:(id)sender;

@end
