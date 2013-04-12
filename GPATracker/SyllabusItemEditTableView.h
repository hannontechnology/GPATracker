//
//  SyllabusEditTableView.h
//  GPATracker
//
//  Created by David Stevens on 13-03-13.
//
//

#import <UIKit/UIKit.h>

@class SyllabusDetails;
@class CourseDetails;
@class DataCollection;
@class SemesterDetails;

@interface SyllabusItemEditTableView : UITableViewController <UITextFieldDelegate,UIActionSheetDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar;
}
@property (weak, nonatomic) IBOutlet UITextField *sectionNameField;
@property (weak, nonatomic) IBOutlet UITextField *sectionPercentageField;
@property (weak, nonatomic) IBOutlet UINavigationItem *headerText;

@property (strong, nonatomic) NSString *setEditStatus;
@property (strong, nonatomic) SyllabusDetails *syllabusDetails;
@property (strong, nonatomic) CourseDetails *courseDetails;
@property (strong, nonatomic) DataCollection *dataCollection;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UIToolbar *keyboardToolbar;

-(IBAction)switchPassFail:(id)sender;

@end
