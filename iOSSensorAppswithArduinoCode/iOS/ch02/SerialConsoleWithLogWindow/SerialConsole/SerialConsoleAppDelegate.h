//
//  SerialConsoleAppDelegate.h
//  SerialConsole
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SerialConsoleViewController;

@interface SerialConsoleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SerialConsoleViewController *viewController;

@end
