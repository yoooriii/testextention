//
//  ZRootSelVC.m
//  WebDrivenExample
//
//  Created by Yu Lo on 3/17/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "ZRootSelVC.h"
#import "Test2WebVC.h"
#import "ViewController.h"

@interface ZRootSelVC ()

@end

@implementation ZRootSelVC

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Start";
}

- (IBAction)actRunWKWebView:(id)sender {
	Test2WebVC *ctr = [Test2WebVC new];
	[self.navigationController pushViewController:ctr animated:YES];
}

- (IBAction)actRunUIWebView:(id)sender {
	ViewController *ctr = [ViewController new];
	[self.navigationController pushViewController:ctr animated:YES];
}

@end
