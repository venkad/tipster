//
//  ViewController.m
//  Tipster
//
//  Created by Venkadeshkumar Dhandapani on 11/14/13.
//  Copyright (c) 2013 Venkadeshkumar Dhandapani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL isTyping;
@property (nonatomic) BOOL isDecimalUsed;

-(void) updateValues;

@end

@implementation ViewController

- (IBAction)numPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle;
    NSLog(@"number pressed = %@", digit);
    
    if(self.isTyping)
    {
        if(!(self.isDecimalUsed && [digit isEqualToString:@"."]))
            self.billAmount.text = [self.billAmount.text stringByAppendingString:digit];
    }
    else{
        self.billAmount.text = [@"$" stringByAppendingString:digit];
        self.isTyping = YES;
    }
    if([digit isEqualToString:@"."])
        self.isDecimalUsed = YES;
    
    [self updateValues];
    
}

- (IBAction)clearPressed
{
    self.billAmount.text = [NSString stringWithFormat:@"$0.00"];
    self.tipAmount.text =  [NSString stringWithFormat:@"$0.00"];
    self.totalAmount.text = [NSString stringWithFormat:@"$0.00"];
    self.isTyping = NO;
    self.isDecimalUsed = NO;
}

- (IBAction)tipPressed:(id)sender
{
    NSString *tipPercentString = [_tipPercentage text];
    int tipPercentFloat = [tipPercentString intValue];
    int newTipAmount = 1 + tipPercentFloat;
    if(newTipAmount > 100)
        newTipAmount = 100;
    self.tipPercentage.text = [NSString stringWithFormat:@"%i%%", newTipAmount];
    
    [self updateValues];
}

- (IBAction)tipDecreasePressed:(id)sender
{
    NSString *tipPercentString = [_tipPercentage text];
    int tipPercentFloat = [tipPercentString intValue];
    int newTipAmount = -1 + tipPercentFloat;
    if(newTipAmount < 0)
        newTipAmount = 0;
    self.tipPercentage.text = [NSString stringWithFormat:@"%i%%", newTipAmount];
    
    [self updateValues];
}

-(void) updateValues
{
    float billAmountFloat = [[self.billAmount.text substringWithRange:NSMakeRange(1, [self.billAmount.text length]-1)] floatValue];
    NSString *tipPercentString = [_tipPercentage text];
    float tipPercentFloat = [tipPercentString floatValue];
    NSLog(@"tipPercentFloat = %.2f", tipPercentFloat);
    float tipAmount = billAmountFloat * tipPercentFloat/100;
    float totalAmount = tipAmount + billAmountFloat;
    self.tipAmount.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalAmount.text = [NSString stringWithFormat:@"$%.2f", totalAmount];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"tip on view will appear =%@",[defaults stringForKey:@"tipPercent"]);
    if ([defaults stringForKey:@"tipPercent"] == nil){
        NSLog(@"Tip not set");
        self.tipPercentage.text = @"15%";
    }
    BOOL tipchanged = [defaults boolForKey:@"tipPercentChanged"];
    NSLog(@"default tip changed = %d",tipchanged);
    if(tipchanged){
        NSString *tipValue = [defaults objectForKey:@"tipPercent"];
        NSLog(@"view will appear tip = %@",tipValue);
        self.tipPercentage.text = tipValue;
        [self updateValues];
        [defaults setBool:NO forKey:@"tipPercentChanged"];
    }
}

@end
