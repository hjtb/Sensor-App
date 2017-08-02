//
//  LogController.m
//  SerialConsole
//
//  Created by Alasdair Allan on 15/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "LogController.h"


@implementation LogController
@synthesize logWindow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent: @"ns.log"];	
        NSFileHandle *fh = [NSFileHandle fileHandleForReadingAtPath:log];
        
        //Read the existing logs, I opted not to do this.
        //[logWindowTextField readRTFDFromFile:logPath];
        
        //Seek to end of file so that logs from previous application launch are not visible
        [fh seekToEndOfFile];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getData:)
                                                     name:@"NSFileHandleReadCompletionNotification"
                                                   object:fh];
        [fh readInBackgroundAndNotify];
        firstOpen = YES;
    }
    return self;
}

- (void)dealloc
{
    [logWindow release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *log = [[paths objectAtIndex:0] stringByAppendingPathComponent: @"ns.log"];	
    //NSLog(@"Opened log window.");
    if ( firstOpen ) {
        NSString* content = [NSString stringWithContentsOfFile:log encoding:NSUTF8StringEncoding error:NULL];  
        logWindow.editable = TRUE;
		logWindow.text = [logWindow.text stringByAppendingString: content];
		logWindow.editable = FALSE;
        firstOpen = NO;
    } 
}

- (void)viewDidUnload
{
    [self setLogWindow:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - NSLog Redirection Methods

- (void) getData: (NSNotification *)aNotification {
    NSData *data = [[aNotification userInfo] objectForKey:NSFileHandleNotificationDataItem];
    if ([data length]) {
        NSString *aString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
		
		logWindow.editable = TRUE;
		logWindow.text = [logWindow.text stringByAppendingString: aString];
		logWindow.editable = FALSE;
        
		[self setWindowScrollToVisible];
		[[aNotification object] readInBackgroundAndNotify];
    } else {
		[self performSelector:@selector(refreshLog:) withObject:aNotification afterDelay:1.0];
	}
}
- (void) refreshLog: (NSNotification *)aNotification {
	[[aNotification object] readInBackgroundAndNotify];
}

-(void)setWindowScrollToVisible {
	NSRange txtOutputRange;
	txtOutputRange.location = [[logWindow text] length];
	txtOutputRange.length = 0;
    logWindow.editable = TRUE;
	[logWindow scrollRangeToVisible:txtOutputRange];
	[logWindow setSelectedRange:txtOutputRange];
    logWindow.editable = FALSE;
}

#pragma mark - UIBarButtonItem Callbacks

-(IBAction)done:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
