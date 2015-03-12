//
//  ViewController.m
//  WebDrivenExample
//
//  Created by Yu Lo on 3/12/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIWebViewDelegate>
@property (nonatomic, retain) UIWebView		*webView;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.toolbarItems = @[[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(actBack:)], [[UIBarButtonItem alloc] initWithTitle:@"forward" style:UIBarButtonItemStylePlain target:self action:@selector(actForward:)]];
	
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.webView];
	self.webView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	NSURLRequest *rq = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://sites.google.com/site/crocodilemusher/scriptomatic"]];
	[self.webView loadRequest:rq];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSLog(@"should?: %@", [request.URL absoluteString]);
	if ([[request.URL.absoluteString lowercaseString] hasPrefix:@"http://localhost/leitz"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"leitz request:" message:[request.URL absoluteString] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
		return NO;
	}
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"finish");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"err:%@", error.localizedDescription);
}

#pragma mark -

- (void)actBack:(id)sender {
	[self.webView goBack];
}

- (void)actForward:(id)sender {
	[self.webView goForward];
}

@end
