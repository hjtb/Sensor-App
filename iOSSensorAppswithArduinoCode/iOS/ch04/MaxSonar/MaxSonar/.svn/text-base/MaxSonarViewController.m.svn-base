//
//  MaxSonarViewController.m
//  MaxSonar
//
//  Created by Alasdair Allan on 19/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import "MaxSonarViewController.h"

@implementation MaxSonarViewController
@synthesize graph;
@synthesize distance;
@synthesize toggle;
@synthesize dataForPlot;

- (void)dealloc
{
    [graph release];
    [distance release];
    [toggle release];
    [dataForPlot release];
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
    
    // cable manager
    rscMgr = [[RscMgr alloc] init]; 
	[rscMgr setDelegate:self];
        
    // Create graph from theme
    plot = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
	CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainBlackTheme];
    [plot applyTheme:theme];
    graph.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    graph.hostedGraph = plot;
	
    plot.paddingLeft = 10.0;
	plot.paddingTop = 10.0;
	plot.paddingRight = 10.0;
	plot.paddingBottom = 10.0;
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)plot.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(MAX_POINTS)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(1.0) length:CPTDecimalFromFloat(MAX_POINTS)];
    
    // Axes
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *)plot.axisSet;
    
    CPTXYAxis *x = axisSet.xAxis;
    x.majorIntervalLength = CPTDecimalFromString(@"100");
    x.minorTicksPerInterval = 4;
    x.minorTickLength = 5.0f;
    x.majorTickLength = 7.0f;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength = CPTDecimalFromString(@"50");
    axisSet.yAxis.minorTicksPerInterval = 2;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    
	// Create a green plot area
	CPTScatterPlot *line = [[[CPTScatterPlot alloc] init] autorelease];
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit = 1.0f;
	lineStyle.lineWidth = 3.0f;
	lineStyle.lineColor = [CPTColor greenColor];
    line.dataLineStyle = lineStyle;
    line.identifier = @"Green Plot";
    line.dataSource = self;
	[plot addPlot:line];
    
	// Do a green gradient
	CPTColor *areaColor = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    areaGradient.angle = -90.0f;
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient];
    line.areaFill = areaGradientFill;
    line.areaBaseValue = [[NSDecimalNumber zero] decimalValue];    
    
	// Add plot symbols
	CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
	symbolLineStyle.lineColor = [CPTColor blackColor];
	CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	plotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
	plotSymbol.lineStyle = symbolLineStyle;
    plotSymbol.size = CGSizeMake(10.0, 10.0);
    line.plotSymbol = plotSymbol;
	
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.duration = 1.0f;
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode = kCAFillModeForwards;
	fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0];
	
    // Add some initial data
	NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:200];
	self.dataForPlot = contentArray;
}


- (void)viewDidUnload
{
    [self setGraph:nil];
    [self setDistance:nil];
    [self setToggle:nil];
    [self setDataForPlot:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)toggled:(id)sender {
    
    txBuffer[0] = 1;
	int bytesWritten = [rscMgr write:txBuffer Length:1];
    
}

#pragma mark - CPTPlotDataSource Methods

-(void)pointReceived:(NSNumber *)point{ 
    
    CPTPlot *thisPlot = [plot plotWithIdentifier:@"Green Plot"];
    [self.dataForPlot addObject:point];
    [thisPlot insertDataAtIndex:self.dataForPlot.count-1 numberOfRecords:1]; 
    self.distance.text = [NSString stringWithFormat:@"%@", point];
    
} 

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return [dataForPlot count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    
    if (fieldEnum == CPTScatterPlotFieldX) {
        return [NSNumber numberWithInteger:index];
    } else {
        return [self yValueForIndex:index];
    }
}

#pragma mark - Other Methodsx


- (NSNumber *) yValueForIndex:(NSUInteger)index {
    return [self.dataForPlot objectAtIndex:index];
}

#pragma mark - RscMgrDelegate methods

- (void) cableConnected:(NSString *)protocol {
    [rscMgr setBaud:9600];
	[rscMgr open];
    
}

- (void) cableDisconnected {
}


- (void) portStatusChanged {    
}

- (void) readBytesAvailable:(UInt32)numBytes {
    int bytesRead = [rscMgr read:rxBuffer Length:numBytes];
    
    NSString *string = nil;
    for(int i = 0;i < numBytes;++i) {
        if ( string ) { 
            string =  [NSString stringWithFormat:@"%@%c", string, rxBuffer[i]];
        } else {
            string =  [NSString stringWithFormat:@"%c", rxBuffer[i]];
        }
    }
    [self pointReceived:[NSNumber numberWithInt:[string intValue]]];
    
}

- (BOOL) rscMessageReceived:(UInt8 *)msg TotalLength:(int)len {
    return FALSE;    
}

- (void) didReceivePortConfig {
}


@end
