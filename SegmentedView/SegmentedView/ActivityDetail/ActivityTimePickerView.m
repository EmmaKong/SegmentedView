//
//  ActivityTimePickerView.m
//  Calendar
//
//  Created by emma on 15/6/9.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityTimePickerView.h"
#define kDuration 0.3

@implementation ActivityTimePickerView

@synthesize titleLabel;
@synthesize timePicker;
@synthesize activity;

- (id)initWithTitle:(NSString *)title delegate:(id <UIActionSheetDelegate>)delegate
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"ActivityTimePickerView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.delegate = delegate;
        self.titleLabel.text = title;
        self.timePicker.dataSource = self;
        self.timePicker.delegate = self;
        
        begins = @[@"06:00",@"06:05",@"06:10",@"06:15",@"06:20",@"06:25",@"06:30",@"06:35",@"06:40",@"06:45",@"06:50",@"06:55",
            @"07:00",@"07:05",@"07:10",@"07:15",@"07:20",@"07:25",@"07:30",@"07:35",@"07:40",@"07:45",@"07:50",@"07:55",
            @"08:00",@"08:05",@"08:10",@"08:15",@"08:20",@"08:25",@"08:30",@"08:35",@"08:40",@"08:45",@"08:50",@"08:55",
            @"09:00",@"09:05",@"09:10",@"09:15",@"09:20",@"09:25",@"09:30",@"09:35",@"09:40",@"09:45",@"09:50",@"09:55",
            @"10:00",@"10:05",@"10:10",@"10:15",@"10:20",@"10:25",@"10:30",@"10:35",@"10:40",@"10:45",@"10:50",@"10:55",
            @"11:00",@"11:05",@"11:10",@"11:15",@"11:20",@"11:25",@"11:30",@"11:35",@"11:40",@"11:45",@"11:50",@"11:55",
            @"12:00",@"12:05",@"12:10",@"12:15",@"12:20",@"12:25",@"12:30",@"12:35",@"12:40",@"12:45",@"12:50",@"12:55",
            @"13:00",@"13:05",@"13:10",@"13:15",@"13:20",@"13:25",@"13:30",@"13:35",@"13:40",@"13:45",@"13:50",@"13:55",
            @"14:00",@"14:05",@"14:10",@"14:15",@"14:20",@"14:25",@"14:30",@"14:35",@"14:40",@"14:45",@"14:50",@"14:55",
            @"15:00",@"15:05",@"15:10",@"15:15",@"15:20",@"15:25",@"15:30",@"15:35",@"15:40",@"15:45",@"15:50",@"15:55",
            @"16:00",@"16:05",@"16:10",@"16:15",@"16:20",@"16:25",@"16:30",@"16:35",@"16:40",@"16:45",@"16:50",@"16:55",
            @"17:00",@"17:05",@"17:10",@"17:15",@"17:20",@"17:25",@"17:30",@"17:35",@"17:40",@"17:45",@"17:50",@"17:55",
            @"18:00",@"18:05",@"18:10",@"18:15",@"18:20",@"18:25",@"18:30",@"18:35",@"18:40",@"18:45",@"18:50",@"18:55",
            @"19:00",@"19:05",@"19:10",@"19:15",@"19:20",@"19:25",@"19:30",@"19:35",@"19:40",@"19:45",@"19:50",@"19:55",
            @"20:00",@"20:05",@"20:10",@"20:15",@"20:20",@"20:25",@"20:30",@"20:35",@"20:40",@"20:45",@"20:50",@"20:55",
            @"21:00",@"21:05",@"21:10",@"21:15",@"21:20",@"21:25",@"21:30",@"21:35",@"21:40",@"21:45",@"21:50",@"21:55",
            @"22:00",@"22:05",@"22:10",@"22:15",@"22:20",@"22:25",@"22:30",@"22:35",@"22:40",@"22:45",@"22:50",@"22:55",
            @"23:00",@"23:05",@"23:10",@"23:15",@"23:20",@"23:25",@"23:30",@"23:35",@"23:40",@"23:45",@"23:50",@"23:55",
            @"24:00"];
        ends =
            @[@"06:00",@"06:05",@"06:10",@"06:15",@"06:20",@"06:25",@"06:30",@"06:35",@"06:40",@"06:45",@"06:50",@"06:55",
            @"07:00",@"07:05",@"07:10",@"07:15",@"07:20",@"07:25",@"07:30",@"07:35",@"07:40",@"07:45",@"07:50",@"07:55",
            @"08:00",@"08:05",@"08:10",@"08:15",@"08:20",@"08:25",@"08:30",@"08:35",@"08:40",@"08:45",@"08:50",@"08:55",
            @"09:00",@"09:05",@"09:10",@"09:15",@"09:20",@"09:25",@"09:30",@"09:35",@"09:40",@"09:45",@"09:50",@"09:55",
            @"10:00",@"10:05",@"10:10",@"10:15",@"10:20",@"10:25",@"10:30",@"10:35",@"10:40",@"10:45",@"10:50",@"10:55",
            @"11:00",@"11:05",@"11:10",@"11:15",@"11:20",@"11:25",@"11:30",@"11:35",@"11:40",@"11:45",@"11:50",@"11:55",
            @"12:00",@"12:05",@"12:10",@"12:15",@"12:20",@"12:25",@"12:30",@"12:35",@"12:40",@"12:45",@"12:50",@"12:55",
            @"13:00",@"13:05",@"13:10",@"13:15",@"13:20",@"13:25",@"13:30",@"13:35",@"13:40",@"13:45",@"13:50",@"13:55",
            @"14:00",@"14:05",@"14:10",@"14:15",@"14:20",@"14:25",@"14:30",@"14:35",@"14:40",@"14:45",@"14:50",@"14:55",
            @"15:00",@"15:05",@"15:10",@"15:15",@"15:20",@"15:25",@"15:30",@"15:35",@"15:40",@"15:45",@"15:50",@"15:55",
            @"16:00",@"16:05",@"16:10",@"16:15",@"16:20",@"16:25",@"16:30",@"16:35",@"16:40",@"16:45",@"16:50",@"16:55",
            @"17:00",@"17:05",@"17:10",@"17:15",@"17:20",@"17:25",@"17:30",@"17:35",@"17:40",@"17:45",@"17:50",@"17:55",
            @"18:00",@"18:05",@"18:10",@"18:15",@"18:20",@"18:25",@"18:30",@"18:35",@"18:40",@"18:45",@"18:50",@"18:55",
            @"19:00",@"19:05",@"19:10",@"19:15",@"19:20",@"19:25",@"19:30",@"19:35",@"19:40",@"19:45",@"19:50",@"19:55",
            @"20:00",@"20:05",@"20:10",@"20:15",@"20:20",@"20:25",@"20:30",@"20:35",@"20:40",@"20:45",@"20:50",@"20:55",
            @"21:00",@"21:05",@"21:10",@"21:15",@"21:20",@"21:25",@"21:30",@"21:35",@"21:40",@"21:45",@"21:50",@"21:55",
            @"22:00",@"22:05",@"22:10",@"22:15",@"22:20",@"22:25",@"22:30",@"22:35",@"22:40",@"22:45",@"22:50",@"22:55",
            @"23:00",@"23:05",@"23:10",@"23:15",@"23:20",@"23:25",@"23:30",@"23:35",@"23:40",@"23:45",@"23:50",@"23:55",
            @"24:00"];
       // self.activity = [[Activity alloc] init];
       // self.activity.begintime = [begins objectAtIndex:0];
       // self.activity.endtime = [ends objectAtIndex:0];

    
    }
    return self;
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DD"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height-64, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [begins count];
            break;
        case 1:
            return [ends count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [begins objectAtIndex:row] ;
            break;
        case 1:
            return [ends objectAtIndex:row] ;
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
           // [self.timePicker selectRow:0 inComponent:1 animated:NO];
           // [self.timePicker reloadComponent:1];
            self.activity.begintime = [begins objectAtIndex:row];
            
            break;
        case 1:
            self.activity.endtime = [ends objectAtIndex:row];
            
            break;
        default:
            break;
    }
}


#pragma mark - Button lifecycle

- (IBAction)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"ActivityTimePickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (IBAction)done:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"ActivityTimePickerView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}



@end
