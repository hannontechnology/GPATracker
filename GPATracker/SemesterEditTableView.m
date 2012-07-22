//
//  SemesterEditTableView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-07-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SemesterEditTableView.h"
#import "SemesterDetails.h"
#import "DataCollection.h"
#import "SemesterTableView.h"

@interface SemesterEditTableView ()
- (IBAction)Accept:(UIBarButtonItem *)sender;
- (IBAction)Cancel:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
@end

@implementation SemesterEditTableView
@synthesize semesterNameField;
@synthesize semesterYearField;
@synthesize semesterCodeField;
@synthesize headerText;
@synthesize setEditStatus;
@synthesize userName;
@synthesize schoolName;
@synthesize semesterName;
@synthesize semester;
@synthesize dataCollection;

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
    
    // Cancel Button
    
    if(self.setEditStatus != @"Edit")
    {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(Cancel:)];
        
        self.navigationItem.leftBarButtonItem = cancelButton;
        self.navigationItem.hidesBackButton = YES;
        return;
    }
    
    DataCollection *data = [[DataCollection alloc] init];
    
    NSArray *results = [data retrieveSemester:semesterName schoolName:schoolName userName:userName];
    
    if(results == nil)
    {
        // TODO: put in Error checking
    }
    else 
    {
        if([results count] > 0)
        {
            NSLog(@"Loading Semester Edit Page");
            headerText.title = @"Edit Semester";
            
            for(SemesterDetails *item in results)
            {
                semesterNameField.text = item.semesterName;
                semesterYearField.text = [NSString stringWithFormat:@"%@", [item semesterYear].stringValue];
                semesterCodeField.text = [NSString stringWithFormat:@"%@", [item semesterCode].stringValue];
            }
        }
    }
}

- (void)viewDidUnload
{
    [self setSemesterNameField:nil];
    [self setSemesterNameField:nil];
    [self setSemesterYearField:nil];
    [self setSemesterCodeField:nil];
    [self setHeaderText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)Accept:(id)sender
{
    if(([semesterNameField.text length] == 0) || ([semesterYearField.text length] == 0))
    {
        // TODO: Error message
        return;
    }
    
    DataCollection *semesterData = [DataCollection alloc];
    
    NSArray *results = [semesterData retrieveSemester:semesterName schoolName:schoolName userName:userName];
    
    // TODO: add in logic for creating automated semester code
    
    if(self.setEditStatus == @"Edit")
    {
        if([semesterNameField.text length] == 0)
        {
            // TODO: Error message
        }
        else if([semesterYearField.text length] == 0)
        {
            // TODO: Error message
        }
        else 
        {
            // Find semester and edit it
            DataCollection *semesterData = [[DataCollection alloc] init];
            
            NSArray *results = [semesterData retrieveSemester:semesterName schoolName:schoolName userName:userName];
            
            if(results == nil)
            {
                //TODO: Error message
            }
            else if ([results count] > 0)
            {
                NSLog(@"Save Semester Page");
                for(SemesterDetails *item in results)
                {
                    item.semesterName = semesterNameField.text;
                    item.semesterYear = [[NSNumber alloc] initWithUnsignedChar:semesterYearField.text];
                    item.semesterCode = semesterYearField.text;
                }
            }
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

@end
