//
//  SemesterEditTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 Hannon Technology Inc. All rights reserved.
//

#import "SemesterEditTableView.h"
#import "SemesterDetails+Create.h"
#import "DataCollection.h"
#import "HomePageTabViewController.h"
#import "YearPicker.h"

@interface SemesterEditTableView ()
@property (strong, nonatomic) UIPickerView *pickerView;
@property CGRect pickerViewShownFrame;
@property CGRect pickerViewHiddenFrame;
@property (strong, nonatomic) NSMutableArray *semesterNameList;
@property (strong, nonatomic) NSMutableArray *semesterYearList;

- (IBAction)Accept:(UIBarButtonItem *)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end

@implementation SemesterEditTableView
@synthesize semesterNameField;
@synthesize semesterYearField;
@synthesize headerText;
@synthesize setEditStatus;
@synthesize schoolDetails = _schoolDetails;
@synthesize semesterDetails = _semesterDetails;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize userInfo = _userInfo;

//@synthesize pickerDismissView = _pickerDismissView;
@synthesize pickerView = _pickerView;
@synthesize pickerViewShownFrame = _pickerViewShownFrame;
@synthesize pickerViewHiddenFrame = _pickerViewHiddenFrame;

@synthesize semesterNameList = _semesterNameList;
@synthesize semesterYearList = _semesterYearList;

// Some Picker size values that will be handy later on.
static const CGFloat kPickerDefaultWidth = 320.f;
static const CGFloat kPickerDefaultHeight = 216.f;
static const NSTimeInterval kPickerAnimationTime = 0.333;

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    int selComp;

    if (textField == self.semesterNameField)
    {
        self.setInputType = @"Name";
    }
    else if (textField == self.semesterYearField)
    {
        self.setInputType = @"Year";
    }
    
    [self.pickerView reloadAllComponents];
    
    if (self.setInputType == @"Year")
    {
        NSString *yearValue;
        if (semesterYearField.text.length > 0)
        {
            yearValue = semesterYearField.text;
            selComp = [self.semesterYearList indexOfObject:yearValue];
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
    [self.pickerView selectRow:selComp inComponent:0 animated:YES];

    return true;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    int selComp;
    NSString *origName;
    origName = semesterNameField.text;
    NSString *origYear;
    origYear = semesterYearField.text;
    
    if (textField == self.semesterNameField)
    {
        self.setInputType = @"Name";
    }
    else if (textField == self.semesterYearField)
    {
        self.setInputType = @"Year";
    }
    
    if (self.setInputType == @"Year")
    {
        NSString *yearValue;
        if (semesterYearField.text.length > 0)
        {
            yearValue = semesterYearField.text;
            selComp = [self.semesterYearList indexOfObject:yearValue];
        }
        else
        {
            selComp =[self.semesterYearList indexOfObject:origYear];
            return false;
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
            selComp = [self.semesterNameList indexOfObject:origName];
            return false;
        }
    }
    [self.pickerView selectRow:selComp inComponent:0 animated:YES];
    
    return true;

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        if (self.setInputType == @"Name")
        {
            return [self.semesterNameList count];
        }
        else if (self.setInputType == @"Year")
        {
            return [self.semesterYearList count];
        }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.setInputType == @"Name")
    {
        return [self.semesterNameList objectAtIndex:row];
    }
    else if (self.setInputType == @"Year")
    {
        return [self.semesterYearList objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(self.setInputType == @"Name")
    {
        NSString *selectedName = [NSString stringWithFormat:@"%@", [self.semesterNameList objectAtIndex:[pickerView selectedRowInComponent:0]]];
        semesterNameField.text = selectedName;
    }
    else if (self.setInputType == @"Year")
    {
        NSString *selectedYear = [NSString stringWithFormat:@"%@", [self.semesterYearList objectAtIndex:[pickerView selectedRowInComponent:0]]];
        semesterYearField.text = selectedYear;
    }
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.semesterNameField.delegate = self;
    self.semesterYearField.delegate = self;    
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
    
    semesterNameField.inputView = self.pickerView;
    semesterNameField.inputAccessoryView = keyboardToolbar;
    semesterYearField.inputView = self.pickerView;
    semesterYearField.inputAccessoryView = keyboardToolbar;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void) doneKey:(id)sender
{
    if ([semesterNameField isFirstResponder])
        [semesterNameField resignFirstResponder];
    else if ([semesterYearField isFirstResponder])
        [semesterYearField resignFirstResponder];
}

- (void) prevField:(id)sender
{
    NSLog(@"Previous Field");
    if ([semesterNameField isFirstResponder])
    {
        [semesterNameField resignFirstResponder];
        [semesterYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[semesterYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([semesterYearField isFirstResponder])
    {
        [semesterYearField resignFirstResponder];
        [semesterNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[semesterNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void) nextField:(id)sender
{
    NSLog(@"Next Field");
    if ([semesterNameField isFirstResponder])
    {
        [semesterNameField resignFirstResponder];
        [semesterYearField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[semesterYearField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else if ([semesterYearField isFirstResponder])
    {
        [semesterYearField resignFirstResponder];
        [semesterNameField becomeFirstResponder];
        UITableViewCell *cell = (UITableViewCell*) [[semesterNameField superview] superview];
        [self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    //self.navigationItem.hidesBackButton = YES;
    [self.navigationItem setHidesBackButton:YES animated:NO];

    NSArray *yearList = [self.dataCollection retrieveYearPicker:self.managedObjectContext];
    self.semesterYearList = [[NSMutableArray alloc] init];
    for (YearPicker *item in yearList)
    {
        [self.semesterYearList addObject:item.year.stringValue];
    }
    
    self.semesterNameList = [[NSMutableArray alloc] init];
    [self.semesterNameList addObject:@""];
    [self.semesterNameList addObject:@"Fall"];
    [self.semesterNameList addObject:@"Spring"];
    [self.semesterNameList addObject:@"Summer"];
    
    // Set pickerView's shown and hidden position frames.
    self.pickerViewShownFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height - kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    self.pickerViewHiddenFrame = CGRectMake(0.f, self.navigationController.view.frame.size.height + kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    
    // Set up the initial state of the picker.
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = self.pickerViewShownFrame;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    if(self.semesterDetails == nil)
    {
        // TODO: put in Error checking
    }
    else 
    {
        NSLog(@"Loading Semester Edit Page");
        headerText.title = @"Edit Semester";
        semesterNameField.text = self.semesterDetails.semesterName;
        semesterYearField.text = [NSString stringWithFormat:@"%@", [self.semesterDetails semesterYear].stringValue];
  //      semesterCodeField.text = [NSString stringWithFormat:@"%@", [self.semesterDetails semesterCode].stringValue];
        
        NSLog(@"Semester Name: %@ Year: %@ Code: %@", self.semesterDetails.semesterName, self.semesterDetails.semesterYear, self.semesterDetails.semesterCode);
    }
    
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
    
    semesterNameField.inputView = self.pickerView;
    semesterNameField.inputAccessoryView = keyboardToolbar;
    semesterYearField.inputView = self.pickerView;
    semesterYearField.inputAccessoryView = keyboardToolbar;
}

- (void)viewDidUnload
{
    [self setSemesterNameField:nil];
    [self setSemesterNameField:nil];
    [self setSemesterYearField:nil];
//    [self setSemesterCodeField:nil];
    [self setHeaderText:nil];
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)Accept:(id)sender
{
    // TODO: add in check for repeat semesters
    
    if([semesterNameField.text length] == 0)
    {
        // TODO: Error message
    }
    else if([semesterYearField.text length] == 0)
    {
        // TODO: Error message
    }
    
    NSArray *results = [self.dataCollection retrieveSemester:semesterNameField.text semesterYear:semesterYearField.text schoolDetails:self.schoolDetails context:self.managedObjectContext];
    
    // TODO: add in logic for creating automated semester code
    
    if(self.setEditStatus == @"Edit")
    {
        if(self.semesterDetails == nil)
        {
            //TODO: Error message
        }
        else
        {
            NSLog(@"Save Semester Page");
            
            self.semesterDetails.semesterName = semesterNameField.text;
                    
            // Cast text to NSNumber:
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterNoStyle];
            NSNumber *s_year = [f numberFromString:semesterYearField.text];
            self.semesterDetails.semesterYear = s_year;
            
            NSNumber *s_code = [semesterNameField.text isEqualToString:@"Spring"] ? [NSNumber numberWithBool:NO] : [semesterNameField.text isEqualToString:@"Summer"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithInt:2];
            self.semesterDetails.semesterCode = s_code;
            
            NSError *err = nil;
            
            if ([self.managedObjectContext save:&err])
            {
                if (self.setEditStatus == @"Edit")
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueEditSemesterToHomePage" sender:self];
                }
                else
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //[self performSegueWithIdentifier:@"segueEditSemesterToHomePage" sender:self];
                }
            }
            else
            {
                NSLog(@"Save Semester Failed! :( %@", [err userInfo]);
            }
        }
    }
    else if ([results count] == 0)
    {
        NSString *entityName = @"SemesterDetails";
        self.semesterDetails = [NSEntityDescription
                                  insertNewObjectForEntityForName:entityName
                                  inManagedObjectContext:self.managedObjectContext];
        self.semesterDetails.semesterName = semesterNameField.text;
        
        // Cast text to NSNumber:
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterNoStyle];
        NSNumber *s_year = [f numberFromString:semesterYearField.text];
        self.semesterDetails.semesterYear = s_year;
        NSNumber *s_code = [semesterNameField.text isEqualToString:@"Spring"] ? [NSNumber numberWithBool:NO] : [semesterNameField.text isEqualToString:@"Summer"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithInt:2];
        self.semesterDetails.semesterCode = s_code;
        self.semesterDetails.schoolDetails = self.schoolDetails;
        
        NSError *err = nil;
        
        if ([self.managedObjectContext save:&err])
        {
            if (self.setEditStatus == @"Edit")
            {
                [self.navigationController popViewControllerAnimated:YES];
                //[self performSegueWithIdentifier:@"segueEditSemesterToHomePage" sender:self];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
                //[self performSegueWithIdentifier:@"segueEditSemesterToHomePage" sender:self];
            }
        }
        else
        {
            NSLog(@"Save Semester Failed! :( %@", [err userInfo]);
        }
    }
    else
    {
        NSLog(@"Save Semester Failed! Semester Already Exists!");
    }
}

- (IBAction)Cancel:(id)sender
{
    //[self.navigationController popViewControllerAnimated:YES];
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Discard Changes" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    [popup showInView:semesterNameField];
}


- (void)actionSheet: (UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //[self performSegueWithIdentifier:@"segueEditSemesterToHomePage" sender:self];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (buttonIndex == 1)
    {
        //[self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueEditSemesterToHomePage"])
    {
        //[self.navigationController popViewControllerAnimated:YES];
        HomePageTabViewController *HomePageTabViewController = [segue destinationViewController];

        HomePageTabViewController.displayType = @"Semesters";
        HomePageTabViewController.userInfo = self.userInfo;
        HomePageTabViewController.managedObjectContext = self.managedObjectContext;
        HomePageTabViewController.dataCollection = self.dataCollection;
        [HomePageTabViewController viewDidLoad];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

@end
