//
//  SRKDateText.m
//  SRKCustomControls
//
//  Created by Sagar R. Kothari on 06-Mar-2015.
//  Copyright 2015 http://sagarrkothari.com. All rights reserved.
//

#import "SRKDateText.h"

@interface SRKDateText () <UIActionSheetDelegate>  {
	UIActionSheet *action;
}
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *viewOfPicker;
@property (nonatomic, strong) UIToolbar *tBar;
@property (nonatomic, strong) UIView *v;
@end


@implementation SRKDateText

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
	[self.delegateVCtr srkDateText:self dateChangedTo:date];
	[self.datePicker setDate:date animated:animated];
}

#define kTagToolBar		1
#define kTagDatePicker	2

- (void)showDatePicker {
	if(!self.viewOfPicker) {
		self.viewOfPicker=[[UIView alloc] init]; 
		self.datePicker=[[UIDatePicker alloc] init]; 
		self.datePicker.tag=kTagDatePicker;
		
		[self.viewOfPicker addSubview:self.datePicker];
		
		self.tBar=[[UIToolbar alloc] init ];
		UIBarButtonItem *itemCancel=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(clear)];
		UIBarButtonItem *itemFlex=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *itemDone=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
		[self.tBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin];
		[self.tBar setItems:[NSArray arrayWithObjects:itemCancel,itemFlex,itemDone, nil] animated:YES];
		self.tBar.tag=kTagToolBar;
		[self.viewOfPicker addSubview:self.tBar];
		[self.datePicker addTarget:self action:@selector(datechanged:) forControlEvents:UIControlEventValueChanged];
	}
	
    BOOL isLandscape = UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation]);
    CGFloat height = (isLandscape)?[[UIScreen mainScreen] bounds].size.width:[[UIScreen mainScreen] bounds].size.height;
    CGFloat width = (isLandscape)?[[UIScreen mainScreen] bounds].size.height:[[UIScreen mainScreen] bounds].size.width;
    self.viewOfPicker.frame=CGRectMake(0, height-230, width, 230);
    self.datePicker.frame=CGRectMake(0, 44, width, 216);
    self.tBar.frame=CGRectMake(0, 0, width, 44);
	
	self.datePicker.minimumDate=self.minimumDate;
	self.datePicker.maximumDate=self.maximumDate;
	self.datePicker.countDownDuration=self.countDownDuration;
	self.datePicker.minuteInterval=self.minuteInterval;
	self.datePicker.datePickerMode=(unsigned int)self.datePickerMode;
	
	if(self.date) {
		self.datePicker.date=self.date;
	}
	
    self.v = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.v.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:0.45];
    self.v.clipsToBounds = YES;
    self.v.opaque = YES;
    self.v.autoresizesSubviews = NO;
    self.datePicker.backgroundColor = [UIColor lightGrayColor];
    [self.v addSubview:self.viewOfPicker];
    [[[UIApplication sharedApplication] keyWindow].rootViewController.view addSubview:self.v];
}

- (void)clear {
	[self setText:@""];
	[action dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)done {
	[action dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)changeToolBarColor:(UIColor*)color
{
	[self.tBar setTintColor:color];
}

- (void)datechanged:(UIDatePicker*)datePicker 
{
	[self.delegateVCtr srkDateText:self dateChangedTo:[datePicker date]];
}

@end
