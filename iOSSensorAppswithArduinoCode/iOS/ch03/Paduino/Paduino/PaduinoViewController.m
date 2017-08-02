//
//  PaduinoViewController.m
//  Paduino
//
//  Created by Alasdair Allan on 16/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "PaduinoViewController.h"

@implementation PaduinoViewController
@synthesize pin13;
@synthesize pin12;
@synthesize pin11;
@synthesize pin10;
@synthesize pin9;
@synthesize pin8;
@synthesize pin7;
@synthesize pin6;
@synthesize pin5;
@synthesize pin4;
@synthesize pin3;
@synthesize pin2;
@synthesize statusLabel;
@synthesize logWindow;


- (void)dealloc
{
    [pin13 release];
    [pin12 release];
    [pin11 release];
    [pin10 release];
    [pin9 release];
    [pin8 release];
    [pin7 release];
    [pin6 release];
    [pin5 release];
    [pin4 release];
    [pin3 release];
    [pin2 release];
    [statusLabel release];
    [logWindow release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    [self setPin13:nil];
    [self setPin12:nil];
    [self setPin11:nil];
    [self setPin10:nil];
    [self setPin9:nil];
    [self setPin8:nil];
    [self setPin7:nil];
    [self setPin6:nil];
    [self setPin5:nil];
    [self setPin4:nil];
    [self setPin3:nil];
    [self setPin2:nil];
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)toggle:(id)sender {
    
    NSLog(@"Toggled output pin %i to %i", [sender tag], [(UISwitch *)sender isOn] );
    txBuffer[0] = [sender tag];
    txBuffer[1] = [(UISwitch *)sender isOn];
	int bytesWritten = [rscMgr write:txBuffer Length:2];
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
    self.statusLabel.text = @"CONNECTED";
    self.statusLabel.textColor = [UIColor greenColor];
    
}

- (void) cableDisconnected {
    NSLog(@"Cable disconnected");
    self.statusLabel.text = @"DISCONNECTED";
    self.statusLabel.textColor = [UIColor redColor];

}


- (void) portStatusChanged {
    NSLog(@"portStatusChanged");
   
}

- (void) readBytesAvailable:(UInt32)numBytes {
    NSLog(@"readBytesAvailable:");
    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
    NSLog( @"Read %d bytes from serial cable.", bytesRead );
    
    NSString *string = nil;
    for(int i = 0;i < numBytes;++i) {
        if ( string ) { 
            string =  [NSString stringWithFormat:@"%@%c", string, rxBuffer[i]];
        } else {
            string =  [NSString stringWithFormat:@"%c", rxBuffer[i]];
        }
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
