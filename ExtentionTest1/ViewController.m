//
//  ViewController.m
//  ExtentionTest1
//
//  Created by 100500 on 11/03/15.
//  Copyright (c) 2015 Leonid 100500. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, retain) IBOutlet UITextField *txtField;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)actDoSmth:(id)sender {
	self.txtField.text = [NSString stringWithFormat:@"%d", [self.txtField.text intValue]+1];
}

@end
