//
//  BasicAddressBook.m
//  WebDrivenExample
//
//  Created by Yu Lo on 3/17/15.
//  Copyright (c) 2015 Horns & Hoofs. All rights reserved.
//

#import "BasicAddressBook.h"

@implementation BasicAddressBook 

static BasicAddressBook *theBasicAddressBook = nil;
+ (BasicAddressBook *)addressBook {
	if (!theBasicAddressBook) {
		theBasicAddressBook = [self new];
	}
	return theBasicAddressBook;
}

- (NSString *)nameAtIndex:(int)index {
	return self.allEntries[index];
}


+ (NSString *) webScriptNameForSelector:(SEL)sel
{
	NSString *name = nil;
	if (sel == @selector(nameAtIndex:))
		name = @"nameAtIndex";
 
	return name;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
	if (sel == @selector(nameAtIndex:)) return NO;
	return YES;
}

- (NSNumber *)objectsCount {
	return @(self.allEntries.count);
}

@end
