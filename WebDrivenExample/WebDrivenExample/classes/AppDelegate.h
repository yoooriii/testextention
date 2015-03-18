//
//  AppDelegate.h
//  WebDrivenExample
//
//  Created by Yu Lo on 3/12/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

AppDelegate * AppDlg();

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readonly) NSURL	*indexURL;


@end

