//
//  MaxSonarAppDelegate.h
//  MaxSonar
//
//  Created by Alasdair Allan on 19/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MaxSonarViewController;

@interface MaxSonarAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet MaxSonarViewController *viewController;

@end
