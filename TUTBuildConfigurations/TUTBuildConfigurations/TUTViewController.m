//
//  TUTViewController.m
//  TUTBuildConfigurations
//
//  Created by Brad Woodard on 12/12/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "TUTViewController.h"
#import "TUTConfiguration.h"

@interface TUTViewController ()
{
    __weak IBOutlet UILabel *mConfigurationBuildLabel;
    __weak IBOutlet UILabel *mGACodeLabel;
    __weak IBOutlet UILabel *mFlurryCodeLabel;
    __weak IBOutlet UILabel *mAPIURLLabel;
    
}

@end

@implementation TUTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // UI Elements
    mConfigurationBuildLabel.text = [TUTConfiguration configuration];
    mGACodeLabel.text = [TUTConfiguration CAMGoogleAnalyticsCode];
    mFlurryCodeLabel.text = [TUTConfiguration CAMFlurryCode];
    mAPIURLLabel.text = [TUTConfiguration CAMurl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
