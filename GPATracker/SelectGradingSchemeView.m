//
//  SelectGradingSchemeView.m
//  GPATracker
//
//  Created by Aiste Guden on 12-06-23.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectGradingSchemeView.h"

@implementation SelectGradingSchemeView
@synthesize GradingSchemePicker;
@synthesize mlabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    arrayNo = [[NSMutableArray alloc] init];
    [arrayNo addObject:@"A+ - 4.33"];
    [arrayNo addObject:@"A+ - 4.0"];
    [arrayNo addObject:@"A, B, C, D"];
    [arrayNo addObject:@"Customize.."];
    [pickerView selectRow:1 inComponent:0 animated:NO];
    mlabel.text = [arrayNo objectAtIndex:[pickerView selectedRowInComponent:0]];
}

- (void)viewDidUnload
{
    [self setGradingSchemePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    mlabel.text = [arrayNo objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [arrayNo count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [arrayNo objectAtIndex:row];
}

@end
