//
//  ViewController.m
//  WebDrivenExample
//
//  Created by Yu Lo on 3/12/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
<UIWebViewDelegate, UIAlertViewDelegate>
@property (nonatomic, retain) UIWebView		*webView;
@property (nonatomic, retain) NSArray		*allPictures;
@property (nonatomic, assign) int	picIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.allPictures = @[@"'cat2.jpg',100,200", @"'cat3.jpg',300,200", @"'cat4.jpg',150,150", @"'cat5.jpg',200,300"];
	self.picIndex = 0;
	
	self.toolbarItems = @[[[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(actBack:)], [[UIBarButtonItem alloc] initWithTitle:@"forward" style:UIBarButtonItemStylePlain target:self action:@selector(actForward:)]];
	
	self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
	[self.view addSubview:self.webView];
	self.webView.delegate = self;
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(actBack:)];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	NSURL *url = [NSURL URLWithString:@"https://sites.google.com/site/crocodilemusher/scriptomatic"];
	NSString *htmlDir = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"html"];
	NSString *htmlIndex = [htmlDir stringByAppendingPathComponent:@"index.html"];
	url = [NSURL fileURLWithPath:htmlIndex];
	NSURLRequest *rq = [[NSURLRequest alloc] initWithURL:url];
	[self.webView loadRequest:rq];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	if ([[request.URL.absoluteString lowercaseString] hasPrefix:@"http://localhost/leitz"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"leitz request:" message:[request.URL absoluteString] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"do smth", nil];
		[alert show];
		return NO;
	}
	NSLog(@"yes, should: %@", [request.URL absoluteString]);
	NSString *strbody = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
	NSLog(@"HTTPBody:{%@}", strbody);
	NSLog(@"%@", request.allHTTPHeaderFields);
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	NSLog(@"start");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"finish");
	
	//	text func
	NSString *jsInject = @"var script = document.createElement('script');"
	@"script.type = 'text/javascript';"
	@"script.text = \"function myFunction(argument1) { "
	@"var field = document.getElementById('field_3');"
	@"field.value=argument1;"
	@"}\";"
	@"document.getElementsByTagName('head')[0].appendChild(script);";
	NSString *jsResult = [webView stringByEvaluatingJavaScriptFromString:jsInject];
	NSLog(@"JS result:\n%@", jsResult);
	
	//	image func
	jsInject = @"var script = document.createElement('script');"
	@"script.type = 'text/javascript';"
	@"script.text = \"function myImageFunction(argument1, w, h) { "
	@"var image = document.getElementById('local_picture');"
	@"image.src=argument1; image.width=w; image.height=h;"
	@"}\";"
	@"document.getElementsByTagName('head')[0].appendChild(script);";
	jsResult = [webView stringByEvaluatingJavaScriptFromString:jsInject];
	NSLog(@"JS result:\n%@", jsResult);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	NSLog(@"err:%@", error.localizedDescription);
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex != alertView.cancelButtonIndex) {
		NSString *txt = [alertView.message lastPathComponent];
		[self doSomething:txt];
	}
}

#pragma mark -

- (void)actBack:(id)sender {
	[self.webView goBack];
}

- (void)actForward:(id)sender {
	[self.webView goForward];
}

- (void)doSomething:(NSString *)text {
	NSString *script = [NSString stringWithFormat:@"myFunction('%@');", text];//@"document.title";

	NSString *scriptResult = [self.webView stringByEvaluatingJavaScriptFromString:script];
	NSLog(@"SCRIPT RESULT:{{\n%@\n}};", scriptResult);
	
	NSString *argumentStr = self.allPictures[self.picIndex];
	self.picIndex += 1;
	if (self.picIndex >= self.allPictures.count) {
		self.picIndex = 0;
	}
	script = [NSString stringWithFormat:@"myImageFunction(%@)", argumentStr];
	scriptResult = [self.webView stringByEvaluatingJavaScriptFromString:script];
	NSLog(@"SCRIPT {%@} RESULT:{{\n%@\n}};", script, scriptResult);
	
	script = @"document.getElementById('field_name').value;";
	scriptResult = [self.webView stringByEvaluatingJavaScriptFromString:script];
	NSLog(@"name:{{%@}};", scriptResult);

	script = @"document.getElementById('field_address').value;";
	scriptResult = [self.webView stringByEvaluatingJavaScriptFromString:script];
	NSLog(@"address:{{%@}};", scriptResult);
}

@end
