//
//  AppDelegate.m
//  WebDrivenExample
//
//  Created by Yu Lo on 3/12/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Test2WebVC.h"
#import "ZRootSelVC.h"

@interface AppDelegate ()

@end


@implementation AppDelegate

AppDelegate * AppDlg() {
	return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIViewController *viewCtr = [ZRootSelVC new];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:viewCtr];
	[self.window makeKeyAndVisible];
	return YES;
}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation
{
	NSLog(@"URL:%@ : %@; (%@)", url.absoluteString, url.port, url.host);
	NSLog(@"src-app:%@", sourceApplication);
	NSLog(@"url-query:{%@}", [url query]);
	if (annotation) {
		NSLog(@"ann: %@", annotation);
	}
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

- (NSURL *)indexURL {
	NSURL *url = [NSURL URLWithString:@"https://sites.google.com/site/crocodilemusher/scriptomatic"];
	NSString *htmlDir = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"html"];
	NSString *htmlIndex = [htmlDir stringByAppendingPathComponent:@"page5.html"];
	url = [NSURL fileURLWithPath:htmlIndex];
	return url;
}

@end
