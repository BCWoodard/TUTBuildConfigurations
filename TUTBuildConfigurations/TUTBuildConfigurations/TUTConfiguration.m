//
//  TUTConfiguration.m
//  TUTBuildConfigurations
//
//  Created by Brad Woodard on 12/12/13.
//  Copyright (c) 2013 Brad Woodard. All rights reserved.
//

#import "TUTConfiguration.h"
#define TUTConfigurationCAMFlurryCode @"CAMFlurryCode"
#define TUTConfigurationCAMGoogleAnalyticsCode @"CAMGoogleAnalyticsCode"
#define TUTConfigurationCAMurl @"CAMurl"

@interface TUTConfiguration ()

@property (copy, nonatomic) NSString        *configuration;
@property (strong, nonatomic) NSDictionary  *variables;

@end

@implementation TUTConfiguration

#pragma mark - Shared Configuration
+ (TUTConfiguration *)sharedConfiguration
{
    static TUTConfiguration *_sharedConfiguration = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConfiguration = [[self alloc] init];
    });
    
    return _sharedConfiguration;
}

#pragma mark - Private Initialization
- (id)init
{
    self = [super init];
    
    if (self) {
        // FETCH the current configuration
        NSBundle *mainBundle = [NSBundle mainBundle];
        self.configuration = [[mainBundle infoDictionary] objectForKey:@"Configuration"];
        
        // LOAD the configurations
        NSString *path = [mainBundle pathForResource:@"Configurations" ofType:@"plist"];
        NSDictionary *configurations = [NSDictionary dictionaryWithContentsOfFile:path];
        
        // LOAD current configuration variables
        self.variables = [configurations objectForKey:self.configuration];
    }
    
    return self;
}

#pragma mark - Return the Configuration string for use by other objects
+ (NSString *)configuration
{
    return [[TUTConfiguration sharedConfiguration] configuration];
}

#pragma mark - Flurry Code
+ (NSString *)CAMFlurryCode
{
    TUTConfiguration *sharedConfiguration = [TUTConfiguration sharedConfiguration];
    if (sharedConfiguration.variables) {
        return [sharedConfiguration.variables objectForKey:TUTConfigurationCAMFlurryCode];
    }
    
    return nil;
}


#pragma mark - Google Analytics Code
+ (NSString *)CAMGoogleAnalyticsCode
{
    TUTConfiguration *sharedConfiguration = [TUTConfiguration sharedConfiguration];
    if (sharedConfiguration.variables) {
        return [sharedConfiguration.variables objectForKey:TUTConfigurationCAMGoogleAnalyticsCode];
    }
    
    return nil;
}


#pragma mark - URL
+ (NSString *)CAMurl
{
    TUTConfiguration *sharedConfiguration = [TUTConfiguration sharedConfiguration];
    if (sharedConfiguration.variables) {
        return [sharedConfiguration.variables objectForKey:TUTConfigurationCAMurl];
    }
    
    return nil;
}

@end
