//
//  ActionViewController.m
//  LLExtAction
//
//  Created by 100500 on 12/03/15.
//  Copyright (c) 2015 Leonid 100500. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel	*label;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"3.%s", __PRETTY_FUNCTION__);
	NSLog(@"ext context: %@\n\n", self.extensionContext);

    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    BOOL imageFound = NO;
	int indx=0;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
		NSLog(@"ITEM#%02d:<%@><%@> %@", ++indx, item.attributedTitle.string, item.attributedContentText.string, item.userInfo.allKeys);
        for (NSItemProvider *itemProvider in item.attachments) {
			NSLog(@"\t%@", itemProvider.registeredTypeIdentifiers);
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imageView = self.imageView;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                    if(image) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imageView setImage:image];
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
			else if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
				[itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(id<NSSecureCoding, NSObject> item, NSError *error) {
					dispatch_async(dispatch_get_main_queue(), ^{
						self.label.text = [item description];
					});
					NSLog(@"kUTTypeURL>>: %@", item);
				}];
			}
			else {
				NSLog(@"undefined item {{{%@}}}", itemProvider.registeredTypeIdentifiers);
			}

        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
			NSLog(@"image found, break");
            break;
        }
    }
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
	NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
