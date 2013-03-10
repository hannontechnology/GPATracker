//
//  SchoolEditTableView.m
//  GPATracker
//
//  Created by David Stevens on 12-07-16.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SchoolEditTableView.h"
#import "SchoolDetails.h"
#import "DataCollection.h"
#import "HomePageTabViewController.h"
#import "User+Create.h"
#import "SchoolDetails+Create.h"
#import "GradingSchemeSelectTableView.h"
#import "GradingSchemeTableView.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "CustomFooter.h"

@interface SchoolEditTableView ()
- (IBAction)Cancel:(id)sender;
- (IBAction)Save:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

@implementation SchoolEditTableView
@synthesize schoolNameField;
@synthesize schoolDetailsField;
@synthesize schoolStartYearField;
@synthesize schoolEndYearField;
@synthesize headerText;

//@synthesize keyboardToolbar;

@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize setEditStatus = _setEditStatus;
@synthesize gradingScheme = _gradingScheme;
@synthesize gradingInfo = _gradingInfo;
@synthesize userInfo = _userInfo;
@synthesize schoolInfo = _schoolInfo;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CustomHeader *header = [[CustomHeader alloc] init];
    header.titleLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    if (section == 1)
    {
        header.lightColor = [UIColor colorWithRed:147.0/255.0 green:105.0/255.0 blue:216.0/255.0 alpha:1.0];
        header.darkColor = [UIColor colorWithRed:72.0/255.0 green:22.0/255.0 blue:137.0/255.0 alpha:1.0];
    }
    return header;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[CustomFooter alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.backgroundView = [[CustomCellBackground alloc] init];
    cell.selectedBackgroundView = [[CustomCellBackground alloc] init];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (keyboardToolbar == nil)
    {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 44.0)];
        keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        keyboardToolbar.alpha = 0.2;
        UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStyleBordered target:self action:@selector(prevField:)];
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:@selector(nextField:)];
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneKey:)];
        
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:prevButton, nextButton, extraSpace, doneButton, nil]];
    }

    schoolNameField.inputAccessoryView = keyboardToolbar;
    schoolDetailsField.inputAccessoryView = keyboardToolbar;
    schoolStartYearField.inputAccessoryView = keyboardToolbar;
    schoolEndYearField.inputAccessoryView = keyboardToolbar;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) doneKey:(id)sender
{
    if ([schoolNameField isFirstResponder])
        [schoolNameField resignFirstResponder];
    else if ([schoolDetailsField isFirstResponder])
        [schoolDetailsField resignFirstResponder];
    else if ([schoolStartYearField isFirstResponder])
        [schoolStartYearField resignFirstResponder];
    else if ([schoolEndYearField isFirstResponder])
        [schoolEndYearField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([schoolNameField isFirstResponder])
    {
        [schoolNameField resignFirstResponder];
        [schoolEndYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolEndYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolDetailsField isFirstResponder])
    {
        [schoolDetailsField resignFirstResponder];
        [schoolNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolStartYearField isFirstResponder])
    {
        [schoolStartYearField resignFirstResponder];
        [schoolDetailsField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolDetailsField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolEndYearField isFirstResponder])
    {
        [schoolEndYearField resignFirstResponder];
        [schoolStartYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolStartYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([schoolNameField isFirstResponder])
    {
        [schoolNameField resignFirstResponder];
        [schoolDetailsField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolDetailsField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolDetailsField isFirstResponder])
    {
        [schoolDetailsField resignFirstResponder];
        [schoolStartYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolStartYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolStartYearField isFirstResponder])
    {
        [schoolStartYearField resignFirstResponder];
        [schoolEndYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolEndYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([schoolEndYearField isFirstResponder])
    {
        [schoolEndYearField resignFirstResponder];
        [schoolNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[schoolNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)viewDidUnload
{
    [self setSchoolNameField:nil];
    [self setSchoolDetailsField:nil];
    [self setSchoolStartYearField:nil];
    [self setSchoolEndYearField:nil];
    [self setGradingScheme:nil];
    [self setGradingScheme:nil];
    [self setKeyboardToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear Event of SchoolEditTableView - EditStatus=%@",self.setEditStatus);

    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    //UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Title"];
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.hidesBackButton = YES;

    if (self.setEditStatus != (NSString *)@"Edit")
    {
        self.gradingScheme.enabled = NO;
        self.gradingScheme.userInteractionEnabled = NO;

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView cellForRowAtIndexPath:indexPath].hidden = YES;
        return;
    }
    //else
    //{
    //    self.navigationItem.hidesBackButton = NO;
    //}
    if (self.schoolInfo == nil)
    {
        NSLog(@"Database Error: Could not connect to Database");
    }
    else
    {
        NSLog(@"Load School Page");
        headerText.title = @"Edit School";
        schoolNameField.text  = self.schoolInfo.schoolName;
        schoolDetailsField.text = self.schoolInfo.schoolDetails;
        schoolStartYearField.text = self.schoolInfo.schoolStartYear.stringValue;
        schoolEndYearField.text = self.schoolInfo.schoolEndYear.stringValue;
    }

}

- (IBAction)Save:(id)sender{
    if ([schoolNameField.text length] == 0)
    {
        NSLog(@"School name field is Required.");
        return;
    }
    else if ([schoolStartYearField.text length] == 0)
    {
        NSLog(@"School start year field is Required.");
        return;
    }
    NSError *error = nil;
    NSArray *results = [self.dataCollection retrieveSchools:schoolNameField.text user:(User *)self.userInfo context:(NSManagedObjectContext *)self.managedObjectContext];

    if (self.setEditStatus == (NSString *)@"Edit")
    {
        if (self.schoolInfo == nil)
        {
            NSLog(@"Database Error: Could not connect to Database.");
        }
        else
        {
            NSLog(@"Save School Page");
            self.schoolInfo.schoolName = schoolNameField.text;
            self.schoolInfo.schoolDetails = schoolDetailsField.text;
            // Cast text to NSNumber:
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterNoStyle];
            NSNumber *s_year = [f numberFromString:schoolStartYearField.text];
            NSNumber *e_year = [f numberFromString:schoolEndYearField.text];
            self.schoolInfo.schoolStartYear = s_year;
            self.schoolInfo.schoolEndYear   = e_year;
            if ([[self managedObjectContext] save:&error])
            {
                NSLog(@"Save was successful");
                if (self.setEditStatus == (NSString *)@"Edit")
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
            }
            else
            {
                NSLog(@"Save Failed!");
            }
        }
        
    }
    else if ([results count] == 0)
    {
        NSString *entityName = @"SchoolDetails";
        self.schoolInfo = [NSEntityDescription
                         insertNewObjectForEntityForName:entityName
                         inManagedObjectContext:self.managedObjectContext];
        self.schoolInfo.user            = self.userInfo;
        self.schoolInfo.schoolName      = schoolNameField.text;
        self.schoolInfo.schoolDetails   = schoolDetailsField.text;
        // Cast text to NSNumber:
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *s_year = [f numberFromString:schoolStartYearField.text];
        NSNumber *e_year = [f numberFromString:schoolEndYearField.text];
        self.schoolInfo.schoolStartYear = s_year;
        self.schoolInfo.schoolEndYear   = e_year;
        
        if ([self.managedObjectContext save:&error])
        {
            NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.schoolInfo context:self.managedObjectContext];
            if ([results count] == 0)
            {
                [self performSegueWithIdentifier:@"segueSchool2SchemeSelect" sender:self];
            }
            else
            {
                if (self.setEditStatus == (NSString *)@"Edit")
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueSchool2HomePage" sender:self];
                }
            }
        }
        else 
        {
            NSLog(@"Create school failed!");
        }
    }
    else
    {
        NSLog(@"School Name already taken!");
    } 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    int selComp;
    
    if (textField == self.schoolNameField)
    {
        self.setInputType = @"Name";
    }
    else if (textField == self.schoolDetailsField)
    {
        self.setInputType = @"Details";
    }
    else if (textField == self.schoolStartYearField)
    {
        self.setInputType = @"StartYear";
    }
    else if (textField == self.schoolEndYearField)
    {
        self.setInputType = @"EndYear";
    }
    
    if (self.setInputType == @"StartYear")
    {
        NSString *yearValue;
        if (schoolStartYearField.text.length > 0)
        {
            yearValue = schoolStartYearField.text;
            //selComp = [self.schoolStartYearField indexOfObject:yearValue];
        }
        else
        {
            NSDate *now = [NSDate date];
            NSString *strDate = [[NSString alloc] initWithFormat:@"%@",now];
            NSArray *arr = [strDate componentsSeparatedByString:@" "];
            NSString *str;
            str = [arr objectAtIndex:0];
            NSArray *arr_my = [str componentsSeparatedByString:@"-"];
            NSInteger date = [[arr_my objectAtIndex:2] intValue];
            NSInteger month = [[arr_my objectAtIndex:1] intValue];
            NSInteger year = [[arr_my objectAtIndex:0] intValue];
            yearValue = [NSString stringWithFormat:@"%d",year];
            semesterYearField.text = yearValue;
            selComp = [self.semesterYearList indexOfObject:yearValue];
        }
    }
    else if (self.setInputType == @"Name")
    {
        NSString *nameValue;
        if (semesterNameField.text.length > 0)
        {
            nameValue = semesterNameField.text;
            selComp = [self.semesterNameList indexOfObject:nameValue];
        }
        else
        {
            selComp = 0;
        }
    }
    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    UIView *tmpCell = textField.superview.superview;
    //GradingSchemeCell1 *cell = (GradingSchemeCell1 *)tmpCell;
    
    if (cell == nil)
        return true;
    
    sch *selectedObject = [self.fetchedResultsController objectAtIndexPath:cell.indexPath];
    NSLog(@"Letter Grade: %@, GPA: %@",[selectedObject letterGrade], cell.cellField1.text);
    
    selectedObject.gPA = [[NSDecimalNumber alloc] initWithString:cell.cellField1.text];
    selectedObject.minGrade = [[NSDecimalNumber alloc] initWithString:cell.minGrade.text];
    selectedObject.maxGrade = [[NSDecimalNumber alloc] initWithString:cell.maxGrade.text];
    if (cell.btnInGPA.currentImage == [UIImage imageNamed:@"Checkbox_checked.png"])
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:1];
    }
    else
    {
        selectedObject.includeInGPA = [NSNumber numberWithInt:0];
    }
    
    return true;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && self.setEditStatus == (NSString *)@"Edit")
    {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

        if ([schoolNameField.text length] == 0)
        {
            NSLog(@"School name field is Required.");
            return;
        }
        else if ([schoolStartYearField.text length] == 0)
        {
            NSLog(@"School start year field is Required.");
            return;
        }
        NSError *error = nil;
        NSArray *results = [self.dataCollection retrieveSchools:schoolNameField.text user:(User *)self.userInfo context:(NSManagedObjectContext *)self.managedObjectContext];
        
        if (self.setEditStatus == (NSString *)@"Edit")
        {
            if (self.schoolInfo == nil)
            {
                NSLog(@"Database Error: Could not connect to Database.");
            }
            else
            {
                NSLog(@"Save School Page");
                self.schoolInfo.schoolName = schoolNameField.text;
                self.schoolInfo.schoolDetails = schoolDetailsField.text;
                // Cast text to NSNumber:
                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterNoStyle];
                NSNumber *s_year = [f numberFromString:schoolStartYearField.text];
                NSNumber *e_year = [f numberFromString:schoolEndYearField.text];
                self.schoolInfo.schoolStartYear = s_year;
                self.schoolInfo.schoolEndYear   = e_year;
                if ([[self managedObjectContext] save:&error])
                {
                    NSLog(@"Save was successful");
                    NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.schoolInfo context:self.managedObjectContext];
                    if ([results count] == 0)
                    {
                        [self performSegueWithIdentifier:@"segueSchool2SchemeSelect" sender:self];
                    }
                    else
                    {
                        [self performSegueWithIdentifier:@"segue2GradingConfirmEdit" sender:self];
                    }
                }
                else
                {
                    NSLog(@"Save Failed!");
                }
            }
            
        }
        else if ([results count] == 0)
        {
            NSString *entityName = @"SchoolDetails";
            self.schoolInfo = [NSEntityDescription
                               insertNewObjectForEntityForName:entityName
                               inManagedObjectContext:self.managedObjectContext];
            self.schoolInfo.user            = self.userInfo;
            self.schoolInfo.schoolName      = schoolNameField.text;
            self.schoolInfo.schoolDetails   = schoolDetailsField.text;
            // Cast text to NSNumber:
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterNoStyle];
            NSNumber *s_year = [f numberFromString:schoolStartYearField.text];
            NSNumber *e_year = [f numberFromString:schoolEndYearField.text];
            self.schoolInfo.schoolStartYear = s_year;
            self.schoolInfo.schoolEndYear   = e_year;
            
            if ([self.managedObjectContext save:&error])
            {
                NSArray *results = [self.dataCollection retrieveGradingScheme:(SchoolDetails *)self.schoolInfo context:self.managedObjectContext];
                if ([results count] == 0)
                {
                    [self performSegueWithIdentifier:@"segueSchool2SchemeSelect" sender:self];
                }
                else
                {
                    [self performSegueWithIdentifier:@"segue2GradingConfirmEdit" sender:self];
                }
            }
            else
            {
                NSLog(@"Create school failed!");
            }
        }
        else
        {
            NSLog(@"School Name already taken!");
        } 

       //Control visiability of button later
    }

    if (indexPath.section == 2 && self.setEditStatus == (NSString *)@"Edit")
    {
        NSLog(@"Delete School");
        UIActionSheet *popUp = [[UIActionSheet alloc] initWithTitle:@"Delete School" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
        popUp.tag = 0;
        
        [popUp showInView:self.view];
    }
}

- (IBAction)Cancel:(id)sender
{
    UIActionSheet *popUp = [[UIActionSheet alloc] initWithTitle:@"Discard Changes" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    popUp.tag = 1;
    
    [popUp showFromTabBar:self.view];
}

- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"actionSheet.title = %@", actionSheet.title);
    NSLog(@"actionSheet.tag = %d", actionSheet.tag);
    //if (actionSheet.title == (NSString *)@"Discard Changes")
    NSInteger *iTag = actionSheet.tag;
    if (iTag == 1)
    {
        if (buttonIndex == 0)
        {
            NSLog(@"User Click the Yes button");
            // This does not work as intended.
            [self.navigationController popViewControllerAnimated:YES];
            //[self.parentViewController.navigationController popViewControllerAnimated:YES];
        }
        else if (buttonIndex == 1)
        {
            NSLog(@"User Click the No button");
            // Maybe do something else
            [self.navigationController popViewControllerAnimated:YES];
        }
 
    }
    //else if (actionSheet.title == (NSString *)@"Delete School")
    else if (iTag == 0)
    {
        switch (buttonIndex)
        {
            case 0:
                NSLog(@"User Clicked the Yes button");
                [self.managedObjectContext deleteObject:self.schoolInfo];
                [self.managedObjectContext save:nil];
                [self.navigationController popViewControllerAnimated:YES];
                break;
            default:
                break;
        }

    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    UITableViewCell *cell = (UITableViewCell*) [[textView superview] superview];
    [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"segueSchool2HomePage"])
    {
        HomePageTabViewController *HomePageTabViewController = [segue destinationViewController];
        
        HomePageTabViewController.displayType = @"Schools";
        HomePageTabViewController.userInfo = self.userInfo;
        HomePageTabViewController.dataCollection = self.dataCollection;
        HomePageTabViewController.managedObjectContext = self.managedObjectContext;
        [HomePageTabViewController viewDidLoad];
    }
    else if ([segue.identifier isEqualToString:@"segueSchool2SchemeSelect"])
    {
        GradingSchemeSelectTableView *GradingSchemeSelectTableView = [segue destinationViewController];
        
        GradingSchemeSelectTableView.userInfo = self.userInfo;
        GradingSchemeSelectTableView.schoolInfo = self.schoolInfo;
        GradingSchemeSelectTableView.gradingInfo = self.gradingInfo;
        GradingSchemeSelectTableView.dataCollection = self.dataCollection;
        GradingSchemeSelectTableView.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"segue2GradingConfirmEdit"])
    {
        GradingSchemeTableView *GradingSchemeTableView = [segue destinationViewController];

        GradingSchemeTableView.userInfo = self.userInfo;
        GradingSchemeTableView.schoolInfo = self.schoolInfo;
        GradingSchemeTableView.gradingInfo =  self.schoolInfo.gradingScheme;
        GradingSchemeTableView.dataCollection = self.dataCollection;
        GradingSchemeTableView.managedObjectContext = self.managedObjectContext;
        
    }
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
    
} @end
