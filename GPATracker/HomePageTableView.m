//
//  HomePageTableView.m
//  GPATracker
//
//  Created by terryah on 12-07-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageTableView.h"
#import "DataCollection.h"
#import "SchoolDetails.h"
#import "LoginView.h"	
#import "ProfileEditTableView.h"
#import "SchoolEditTableView.h"
#import "HomePageTableCell1.h"

@interface HomePageTableView ()
@end

@implementation HomePageTableView
@synthesize userName = _userName;
@synthesize schoolList = _schoolList;
@synthesize selectedIndexPath = _selectedIndexPath;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        self.schoolList = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] 
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];

    DataCollection *data = [[DataCollection alloc] init];
    
    //NSError *error = nil;
    self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
    
    if (self.schoolList == nil)
    {
        return;
    }
    else
    {
        if ([self.schoolList count] > 0)
        {
            NSLog(@"School List:");
            for (SchoolDetails *item in self.schoolList)
            {
                NSLog(@"School Found: %@ - %@",item.schoolName, item.schoolDetails);
            }
        }
    }
    
    [super viewWillAppear:(BOOL)animated];
//    
//    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.schoolList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataCollection *data = [[DataCollection alloc] init];
    self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];

    static NSString *CellIdentifier = @"homePageCell1";
    HomePageTableCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[HomePageTableCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SchoolDetails *selectedObject = [self.schoolList objectAtIndex:indexPath.row];
    cell.cellLabel1.text = [selectedObject schoolName];
    cell.cellLabel2.text = [selectedObject schoolDetails];
    cell.cellLabel3.text = [NSString stringWithFormat:@"%@ - %@", [selectedObject schoolStartYear], [selectedObject schoolEndYear]];
    cell.cellLabelGPA.text = [NSString stringWithFormat:@"%@", [selectedObject schoolActualGPA].stringValue];
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DataCollection *data = [[DataCollection alloc] init];
    self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
    NSLog(@"prepareForSegue Event of HomePageTableView");
	if ([segue.identifier isEqualToString:@"segueLogout"])
	{
        LoginView *LoginView = [segue destinationViewController];
        
        LoginView.getData  = @"Logout";
        LoginView.userName = self.userName;
	}
    else if ([segue.identifier isEqualToString:@"segueEditProfile"])
    {
        ProfileEditTableView *ProfileEditTableView = [segue destinationViewController];
//        UINavigationController *navCon = [segue destinationViewController];
//        ProfileEditTableView *ProfileEditTableView = [navCon.viewControllers objectAtIndex:0];
        
        ProfileEditTableView.setStatus = @"Edit";
        ProfileEditTableView.userName = self.userName;
    }
    else if ([segue.identifier isEqualToString:@"segueEditSchool"])
    {
        SchoolDetails *selectedObject = [self.schoolList objectAtIndex:self.selectedIndexPath.row];
        SchoolEditTableView *SchoolEditTableView = [segue destinationViewController];
        
        SchoolEditTableView.setStatus  = @"Edit";
        SchoolEditTableView.userName   = self.userName;
        SchoolEditTableView.schoolName = [selectedObject schoolName];
    }
    else if ([segue.identifier isEqualToString:@"segueCreateSchool"])
    {
        NSLog(@"prepareForSegue Event of HomePageTableView for segueCreateSchool");
        UINavigationController *navCon = [segue destinationViewController];
        SchoolEditTableView *SchoolEditTableView = [navCon.viewControllers objectAtIndex:0];
        
        SchoolEditTableView.userName = self.userName;
        NSLog(@"prepareForSegue Event of HomePageTableView for segueCreateSchool - Data sent");
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataCollection *data = [[DataCollection alloc] init];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        NSManagedObject *schoolToDelete = [self.schoolList objectAtIndex:indexPath.row];
        [data deleteSchool:schoolToDelete];
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    SchoolDetails *movedSchool = [self.schoolList objectAtIndex:fromIndexPath.row];
    
}
*/
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer.state != UIGestureRecognizerStateBegan )
        return; // discard everything else

    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    self.selectedIndexPath = [self.tableView indexPathForRowAtPoint:p];
    if (self.selectedIndexPath == nil)
        NSLog(@"long press on table view but not on a row");
    else
        NSLog(@"long press on table view at row %d", self.selectedIndexPath.row);

    alert = [[UIAlertView alloc] initWithTitle:@"Edit/Delete" message:@"Please edit or delete item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Edit", @"Delete", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self performSegueWithIdentifier: @"segueEditSchool" sender: self];
    }
    else if (buttonIndex == 2)
    {
        DataCollection *data = [[DataCollection alloc] init];
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        NSManagedObject *schoolToDelete = [self.schoolList objectAtIndex:self.selectedIndexPath.row];
        [data deleteSchool:schoolToDelete];
        self.schoolList = [data retrieveSchoolList:(NSString *)self.userName];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
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

@end
