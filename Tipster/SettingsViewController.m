//
//  SettingsViewController.m
//  Tipster
//
//  Created by Venkadeshkumar Dhandapani on 12/14/13.
//  Copyright (c) 2013 Venkadeshkumar Dhandapani. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

- (IBAction)tipPercentChanged:(id)sender;
-(void)updateTipValue;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tipPercentInt = (int)[defaults integerForKey:@"tipPercentInt"];
    NSLog(@"tip percent passed = %i",tipPercentInt);
    [self.tipPercent setSelectedSegmentIndex:tipPercentInt];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)tipPercentChanged:(id)sender {
    NSLog(@"tip percent changed");
    [self updateTipValue];
}

-(void)updateTipValue{
    int tipPercentInt = (int)self.tipPercent.selectedSegmentIndex;
    NSString *tipPercentStr = [self.tipPercent titleForSegmentAtIndex:tipPercentInt];
    NSLog(@"tip percent str selected = %@",tipPercentStr);
    NSLog(@"tip percent int selected = %i",tipPercentInt);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tipPercentStr forKey:@"tipPercent"];
    [defaults setInteger:tipPercentInt forKey:@"tipPercentInt"];
    [defaults setBool:YES forKey:@"tipPercentChanged"];
    [defaults synchronize];
}

@end
