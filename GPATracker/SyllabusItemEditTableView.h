//
//  SyllabusEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import <UIKit/UIKit.h>

@class SyllabusDetails;
@class SyllabusItemDetails;
@class DataCollection;
@class SemesterDetails;

@interface SyllabusItemEditTableView : UITableViewController <UIPickerViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *itemNameField;
@property (weak, nonatomic) IBOutlet UITextField *itemDueDateField;
@property (weak, nonatomic) IBOutlet UITextField *itemGradeField;
@property (weak, nonatomic) IBOutlet UITextField *itemOutOfField;
@property (weak, nonatomic) IBOutlet UISwitch *itemIncludeSwitch;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) SyllabusDetails *syllabusDetails;
@property (strong, nonatomic) SyllabusItemDetails *syllabusItemDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

- (IBAction)Save:(id)sender;
-(IBAction)switchPassFail:(id)sender;

@end
