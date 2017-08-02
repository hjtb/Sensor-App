//
//  SerialConsoleViewController.m
//  SerialConsole
//
//  Created by Alasdair Allan on 14/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "SerialConsoleViewController.h"

@implementation SerialConsoleViewController
@synthesize textEntry;
@synthesize sendButton;
@synthesize serialView;
@synthesize logWindow;

- (void)dealloc
{
    [textEntry release];
    [sendButton release];
    [serialView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	rscMgr = [[RscMgr alloc] init]; 
	[rscMgr setDelegate:self];
    
    self.logWindow = [[LogController alloc] initWithNibName:@"LogController" bundle:nil];
}

- (void)viewDidUnload
{
    [self setTextEntry:nil];
    [self setSendButton:nil];
    [self setSerialView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sendString:(id)sender {
    NSLog(@"sendString:");
    [self.textEntry resignFirstResponder];
    
    NSString *text = self.textEntry.text;
    int bytesToWrite = text.length;
    for ( int i = 0; i < bytesToWrite; i++ ) {
        txBuffer[i] = (int)[text characterAtIndex:i];
    }
	int bytesWritten = [rscMgr write:txBuffer Length:bytesToWrite];
    NSLog( @"Wrote %d bytes to serial cable.", bytesWritten);
}

- (IBAction)openLog:(id)sender {
    [self presentModalViewController:self.logWindow animated:YES];

}

#pragma mark - RscMgrDelegate methods


- (void) cableConnected:(NSString *)protocol {
    NSLog(@"Cable Connected: %@", protocol);
    [rscMgr setBaud:9600];
	[rscMgr open];
    
    
}


- (void) cableDisconnected {
    NSLog(@"Cable disconnected");
	
}


- (void) portStatusChanged {
    NSLog(@"portStatusChanged");
    
}

- (void) readBytesAvailable:(UInt32)numBytes {
    NSLog(@"readBytesAvailable:");
    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
    NSLog( @"Read %d bytes from serial cable.", bytesRead );
    for(int i = 0;i < numBytes;++i) {
        self.serialView.text =  [NSString stringWithFormat:@"%@%c", self.serialView.text, ((char *)rxBuffer)[i]];
    }
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    NSLog(@"rscMessageRecieved:TotalLength:");
    return FALSE;    
}

- (void) didReceivePortConfig {
    NSLog(@"didRecievePortConfig");
}

@end
