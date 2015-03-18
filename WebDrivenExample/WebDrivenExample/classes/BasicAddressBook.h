//
//  BasicAddressBook.h
//  WebDrivenExample
//
//  Created by Yu Lo on 3/17/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicAddressBook : NSObject
@property (nonatomic, retain) NSArray	*allEntries;
+ (BasicAddressBook *)addressBook;
- (NSString *)nameAtIndex:(int)index;
- (NSNumber *)objectsCount;
@end
