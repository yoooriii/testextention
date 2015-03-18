//
//  Test2WebVC.m
//  WebDrivenExample
//
//  Created by 100500 on 17/03/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "Test2WebVC.h"
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "BasicAddressBook.h"

//	read this:
//	https://github.com/ShingoFukuyama/WKWebViewTips
//	Objective-C WKWebView to JavaScript and Back:
//	https://tetontech.wordpress.com/2014/07/17/objective-c-wkwebview-to-javascript-and-back/
//	(iOS) UIWebView vs WKWebView
//	https://mail.mozilla.org/pipermail/mobile-firefox-dev/2014-December/000993.html
//	Using JavaScript with WKWebView in iOS 8:
//	http://joshuakehn.com/2014/10/29/using-javascript-with-wkwebview-in-ios-8.html

@interface Test2WebVC ()
<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>
@property (nonatomic, readonly) WKWebView		*webView;
@end

@implementation Test2WebVC

- (WKWebView *)webView {
	return (WKWebView *)self.view;
}

- (void)loadView {

	WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
	[configuration.userContentController addScriptMessageHandler:self name:@"interOp"];
	WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) configuration:configuration];
	self.view = webView;
	webView.navigationDelegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"WKWebView";

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(actPerformTest1:)];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	NSURL *url = [AppDlg() indexURL];
	NSURLRequest *rq = [[NSURLRequest alloc] initWithURL:url];
	WKNavigation *navigation = [self.webView loadRequest:rq];
	NSLog(@"nav: %@", navigation);
}

#pragma mark - WKNavigationDelegate

/*! @abstract Decides whether to allow or cancel a navigation.
 @param webView The web view invoking the delegate method.
 @param navigationAction Descriptive information about the action
 triggering the navigation request.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationActionPolicy.
 @discussion If you do not implement this method, the web view will load the request or, if appropriate, forward it to another application.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
	NSLog(@"%s", __PRETTY_FUNCTION__);

	if (decisionHandler) {
//		WKNavigationActionPolicyCancel,
//		WKNavigationActionPolicyAllow,

		decisionHandler(WKNavigationActionPolicyAllow);
	}
}

/*! @abstract Decides whether to allow or cancel a navigation after its
 response is known.
 @param webView The web view invoking the delegate method.
 @param navigationResponse Descriptive information about the navigation
 response.
 @param decisionHandler The decision handler to call to allow or cancel the
 navigation. The argument is one of the constants of the enumerated type WKNavigationResponsePolicy.
 @discussion If you do not implement this method, the web view will allow the response, if the web view can show it.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
//	WKNavigationResponsePolicyCancel,
//	WKNavigationResponsePolicyAllow,
	if (decisionHandler) {
		decisionHandler(WKNavigationResponsePolicyAllow);
	}
}

/*! @abstract Invoked when a main frame navigation starts.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

/*! @abstract Invoked when a server redirect is received for the main
 frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

/*! @abstract Invoked when an error occurs while starting to load data for
 the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
	NSLog(@"%s {ERR?:%@}; nav{%@}", __PRETTY_FUNCTION__, error?error.localizedDescription:@"OK", navigation);
}

/*! @abstract Invoked when content starts arriving for the main frame.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

/*! @abstract Invoked when the web view needs to respond to an authentication challenge.
 @param webView The web view that received the authentication challenge.
 @param challenge The authentication challenge.
 @param completionHandler The completion handler you must invoke to respond to the challenge. The
 disposition argument is one of the constants of the enumerated type
 NSURLSessionAuthChallengeDisposition. When disposition is NSURLSessionAuthChallengeUseCredential,
 the credential argument is the credential to use, or nil to indicate continuing without a
 credential.
 @discussion If you do not implement this method, the web view will respond to the authentication challenge with the NSURLSessionAuthChallengeRejectProtectionSpace disposition.
 */
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
	NSString *hostName = self.webView.URL.host;

	NSString *authenticationMethod = [[challenge protectionSpace] authenticationMethod];
	if ([authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault]
		|| [authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic]
		|| [authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPDigest]) {

		NSString *title = @"Authentication Challenge";
		NSString *message = [NSString stringWithFormat:@"%@ requires user name and password", hostName];
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
		[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
			textField.placeholder = @"User";
			//textField.secureTextEntry = YES;
		}];
		[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
			textField.placeholder = @"Password";
			textField.secureTextEntry = YES;
		}];
		[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

			NSString *userName = ((UITextField *)alertController.textFields[0]).text;
			NSString *password = ((UITextField *)alertController.textFields[1]).text;

			NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:userName password:password persistence:NSURLCredentialPersistenceNone];

			completionHandler(NSURLSessionAuthChallengeUseCredential, credential);

		}]];
		[alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
			completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
		}]];
		dispatch_async(dispatch_get_main_queue(), ^{
			[self presentViewController:alertController animated:YES completion:^{}];
		});

	} else {
		if (completionHandler) {
			completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
		}
	}
}

#pragma mark - WKUIDelegate

/*! @abstract Creates a new web view.
 @param webView The web view invoking the delegate method.
 @param configuration The configuration to use when creating the new web
 view.
 @param navigationAction The navigation action causing the new web view to
 be created.
 @param windowFeatures Window features requested by the webpage.
 @result A new web view or nil.
 @discussion The web view returned must be created with the specified configuration. WebKit will load the request in the returned web view.

 If you do not implement this method, the web view will cancel the navigation.
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
	return nil;
}


/*! @abstract Displays a JavaScript alert panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this
 call.
 @param completionHandler The completion handler to call after the alert
 panel has been dismissed.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have a single OK button.

 If you do not implement this method, the web view will behave as if the user selected the OK button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}


/*! @abstract Displays a JavaScript confirm panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the confirm
 panel has been dismissed. Pass YES if the user chose OK, NO if the user
 chose Cancel.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel.

 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}


/*! @abstract Displays a JavaScript text input panel.
 @param webView The web view invoking the delegate method.
 @param message The message to display.
 @param defaultText The initial text to display in the text entry field.
 @param frame Information about the frame whose JavaScript initiated this call.
 @param completionHandler The completion handler to call after the text
 input panel has been dismissed. Pass the entered text if the user chose
 OK, otherwise nil.
 @discussion For user security, your app should call attention to the fact
 that a specific website controls the content in this panel. A simple forumla
 for identifying the controlling website is frame.request.URL.host.
 The panel should have two buttons, such as OK and Cancel, and a field in
 which to enter text.

 If you do not implement this method, the web view will behave as if the user selected the Cancel button.
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *result))completionHandler
{
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark -

- (IBAction)actPerformTest1:(id)sender {
	NSString *script = @" document.getElementById('field_3').value='QWERTYU';";
	[self.webView evaluateJavaScript:script completionHandler:^(id obj, NSError *error) {
		if (error) {
			NSLog(@"ERR:%@", error.localizedDescription);
		}
		else {
			NSLog(@"RESULT-OBJ:{%@}", obj);
		}
	}];
}


#pragma mark - WKScriptMessageHandler

/*! @abstract Invoked when a script message is received from a webpage.
 @param userContentController The user content controller invoking the
 delegate method.
 @param message The script message received.
 */

//	Since ViewController is a WKScriptMessageHandler, as declared in the ViewController interface, it must implement the userContentController:didReceiveScriptMessage method. This is the method that is triggered each time 'interOp' is sent a message from the JavaScript code.

- (void)userContentController:(WKUserContentController *)userContentController
	  didReceiveScriptMessage:(WKScriptMessage *)message{
	NSDictionary *sentData = (NSDictionary*)message.body;
	long aCount = [sentData[@"count"] integerValue];
	aCount++;
	[self.webView evaluateJavaScript:[NSString stringWithFormat:@"storeAndShow(%ld)", aCount] completionHandler:nil];

	//	In the example code above you can see a WKScriptMessage is received from JavaScript. Since WKWebKit defines JSON as the data transport protocol, the JavaScript associative array sent as the message's body has already been converted into an NSDictionary before we have access to the message. We can then use this NSDictionary to retrieve an int that is the value associated with the 'count' label. The JSON conversation creates NSNumbers for numeric type values so the code example retrieves the NSNumber's intValue, modifies it, and then sends the modified value back to JavaScript.

	//	One of the very nice features of WKWebKit framework is that the WKWebView runs independently of the main, or User Interface, thread. This keeps our apps responsive to user input. The storeAndShow method will not execute in the app's main thread.


}


@end
