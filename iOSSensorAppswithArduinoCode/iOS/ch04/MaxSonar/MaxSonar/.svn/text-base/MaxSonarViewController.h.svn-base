//
//  MaxSonarViewController.h
//  MaxSonar
//
//  Created by Alasdair Allan on 19/07/2011.
//  Copyright 2011 University of Exeter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "RscMgr.h"

#define BUFFER_LEN 1024
#define MAX_POINTS 200

@interface MaxSonarViewController : UIViewController  <CPTPlotDataSource, RscMgrDelegate> {
    
    CPTGraphHostingView *graph;
    
    CPTXYGraph *plot;
    NSMutableArray *dataForPlot;

    UILabel *distance;
    UISwitch *toggle;
    
    
    RscMgr *rscMgr;
    UInt8 rxBuffer[BUFFER_LEN];
	UInt8 txBuffer[BUFFER_LEN];
}

@property (nonatomic, retain) IBOutlet CPTGraphHostingView *graph;
@property (nonatomic, retain) IBOutlet UILabel *distance;
@property (nonatomic, retain) IBOutlet UISwitch *toggle;
@property (nonatomic, retain) NSMutableArray *dataForPlot;

- (IBAction)toggled:(id)sender;

- (NSNumber *) yValueForIndex:(NSUInteger)index;

@end
