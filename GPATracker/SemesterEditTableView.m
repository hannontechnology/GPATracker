//
//  SemesterEditTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterEditTableView.h"
#import "SemesterDetails+Create.h"
#import "DataCollection.h"
#import "SemesterTableView.h"

@interface PickerDismissView : UIView
@property (nonatomic, strong) id parentViewController;
@end

@implementation PickerDismissView
@synthesize parentViewController = _parentViewController;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Got a touch? Tell parentViewController to dismiss the picker.
    [self.parentViewController performSelector:@selector(dismissPickerView)];
}
@end

@interface SemesterEditTableView ()
@property (strong, nonatomic) PickerDismissView *pickerDismissView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property CGRect pickerDismissViewShownFrame;
@property CGRect pickerDismissViewHiddenFrame;
@property CGRect pickerViewShownFrame;
@property CGRect pickerViewHiddenFrame;
@property (strong, nonatomic) NSMutableArray *semesterNameList;
@property (strong, nonatomic) NSArray *semesterYearList;

- (IBAction)Accept:(UIBarButtonItem *)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end

@implementation SemesterEditTableView
@synthesize semesterNameField;
@synthesize semesterYearField;
@synthesize headerText;
@synthesize setEditStatus;
//@synthesize userName = _userName;
//@synthesize schoolName = _schoolName;
//@synthesize semesterName = _semesterName;
@synthesize schoolDetails = _schoolDetails;
@synthesize semesterDetails = _semesterDetails;
@synthesize dataCollection = _dataCollection;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize pickerDismissView = _pickerDismissView;
@synthesize pickerView = _pickerView;
@synthesize pickerDismissViewShownFrame = _pickerDismissViewShownFrame;
@synthesize pickerDismissViewHiddenFrame = _pickerDismissViewHiddenFrame;
@synthesize pickerViewShownFrame = _pickerViewShownFrame;
@synthesize pickerViewHiddenFrame = _pickerViewHiddenFrame;

@synthesize semesterNameList = _semesterNameList;
@synthesize semesterYearList = _semesterYearList;

// Some Picker size values that will be handy later on.
static const CGFloat kPickerDefaultWidth = 320.f;
static const CGFloat kPickerDefaultHeight = 216.f;
static const CGFloat kPickerDismissViewShownOpacity = 0.333;
static const CGFloat kPickerDismissViewHiddenOpacity = 0.f;
static const NSTimeInterval kPickerAnimationTime = 0.333;

- (void)showPickerView
{
    // To show the picker, we animate the frame and alpha values for the pickerview and the picker dismiss view
    [UIView animateWithDuration:kPickerAnimationTime animations:^{
        self.pickerDismissView.frame = self.pickerDismissViewShownFrame;
        self.pickerDismissView.alpha = kPickerDismissViewShownOpacity;
        self.pickerView.frame = self.pickerViewShownFrame;
    }];
    
    // Choose default selection
    int selComp;
    
    if (self.setInputType == @"Year")
    {
        NSString *yearValue;
        if (semesterYearField.text.length > 0)
        {
            yearValue = [semesterYearField.text substringWithRange:NSMakeRange(0, 1)];
            selComp = [self.semesterYearList indexOfObject:yearValue];
        }
        else
        {
            selComp = 0;
        }
    }
    else if (self.setInputType == @"Name")
    {
        NSString *nameValue;
        if (semesterNameField.text.length > 0)
        {
            nameValue = [semesterNameField.text substringWithRange:NSMakeRange(0, 1)];
            selComp = [self.semesterNameList indexOfObject:nameValue];
        }
        else
        {
            selComp = 0;
        }
    }
    [self.pickerView selectRow:selComp inComponent:0 animated:YES];
}

- (void)dismissPickerView
{
    // Need animations to dismiss:
    [UIView animateWithDuration:kPickerAnimationTime animations:^{
        self.pickerDismissView.frame = self.pickerDismissViewHiddenFrame;
        self.pickerDismissView.alpha = kPickerDismissViewHiddenOpacity;
        self.pickerView.frame = self.pickerViewHiddenFrame;
    }];
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
    return nil;
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
            NSNumber *selectedYear = [NSString stringWithFormat:@"%@", [self.semesterYearList objectAtIndex:[pickerView selectedRowInComponent:0]]];
        semesterYearField.text = selectedYear;
    }
}

- (IBAction)showSemesterNamePicker:(id)sender
{
    self.setInputType = @"Name";
    [self showPickerView];
}

- (IBAction)showSemesterYearPicker:(id)sender
{
    self.setInputType = @"Year";
    [self showPickerView];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.semesterYearList = [self.dataCollection retrieveYearPicker:self.managedObjectContext];
    
    self.semesterNameList = [[NSMutableArray alloc] init];
    [self.semesterNameList addObject:@""];
    [self.semesterNameList addObject:@"Fall"];
    [self.semesterNameList addObject:@"Spring"];
    [self.semesterNameList addObject:@"Summer"];
    
    // Set pickerView's shown and hidden position frames
    self.pickerViewShownFrame = CGRectMake(0.f, self.view.frame.size.height - kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    self.pickerViewHiddenFrame = CGRectMake(0.f, self.view.frame.size.height + kPickerDefaultHeight, kPickerDefaultWidth, kPickerDefaultHeight);
    
    // Set up the initial state of the picker
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.frame = self.pickerViewHiddenFrame;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    // Add it as a subview of current view
    [self.view addSubview:self.pickerView];
    if (!self.pickerDismissView)
    {
        // Set picker dismiss view's shown and hidden position frames
        self.pickerDismissViewShownFrame = CGRectMake(0.f, 0.f, kPickerDefaultWidth, self.navigationController.view.frame.size.height - kPickerDefaultHeight);
        self.pickerDismissViewHiddenFrame = self.navigationController.view.frame;
        
        // Set up the initial state of the picker dismiss view
        self.pickerDismissView = [[PickerDismissView alloc] init];
        self. pickerDismissView.frame = self.pickerDismissViewHiddenFrame;
        self.pickerDismissView.parentViewController = self;
        self.pickerDismissView.backgroundColor = [UIColor blackColor];
        self.pickerDismissView.alpha = kPickerDismissViewHiddenOpacity;
        
        // Inserting dismiss view as a subvew of the navigation controller's view. We do this so that we can make it appear OVER the navigation bar
        [self.navigationController.view insertSubview:self.pickerDismissView aboveSubview:self.navigationController.navigationBar];
    }
    
    // Cancel Button
    
    if(self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    
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
}

- (void)viewDidUnload
{
    [self setSemesterNameField:nil];
    [self setSemesterNameField:nil];
    [self setSemesterYearField:nil];
//    [self setSemesterCodeField:nil];
    [self setHeaderText:nil];
    [self setPickerView:nil];
    [self setPickerDismissView:nil];
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
            
            NSNumber *s_code = [semesterNameField.text isEqualToString:@"Spring"] ? [NSNumber numberWithInt:0] : [semesterNameField.text isEqualToString:@"Summer"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2];
            self.semesterDetails.semesterCode = s_code;
            
            NSError *err = nil;
            
            if ([self.managedObjectContext save:&err])
            {
                [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
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
        NSNumber *s_code = [semesterNameField.text isEqualToString:@"Spring"] ? [NSNumber numberWithInt:0] : [semesterNameField.text isEqualToString:@"Summer"] ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:2];
        self.semesterDetails.semesterCode = s_code;
        self.semesterDetails.schoolDetails = self.schoolDetails;
        
        NSError *err = nil;
        
        if ([self.managedObjectContext save:&err])
        {
            [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
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
        [self performSegueWithIdentifier:@"segueEditSemesterToSemester" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueEditSemesterToSemester"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        SemesterTableView *SemesterTableView = [segue destinationViewController];
        SemesterTableView.schoolInfo = self.schoolDetails;
        SemesterTableView.managedObjectContext = self.managedObjectContext;
        SemesterTableView.dataCollection = self.dataCollection;
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
