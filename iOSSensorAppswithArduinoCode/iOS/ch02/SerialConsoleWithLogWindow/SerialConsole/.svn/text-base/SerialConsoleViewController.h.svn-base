//
//  SerialConsoleViewController.h
//  SerialConsole
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogController.h"
#import "RscMgr.h"

#define BUFFER_LEN 1024

@interface SerialConsoleViewController : UIViewController <RscMgrDelegate> {
    
    RscMgr *rscMgr;
	UInt8 rxBuffer[BUFFER_LEN];
	UInt8 txBuffer[BUFFER_LEN];
    
    UITextField *textEntry;
    UIButton *sendButton;
    UITextView *serialView;
    UIBarButtonItem *openLog;
    
    LogController *logWindow;
}


@property (nonatomic, retain) IBOutlet UITextField *textEntry;
@property (nonatomic, retain) IBOutlet UIButton *sendButton;
@property (nonatomic, retain) IBOutlet UITextView *serialView;

@property (nonatomic, retain) LogController *logWindow;


- (IBAction)sendString:(id)sender;
- (IBAction)openLog:(id)sender;

@end
