//
//  GTMainViewController.m
//  Beeline
//
//  Created by Adam Gall on 3/28/14.
//  Copyright (c) 2014 Gall Thomas Inc. All rights reserved.
//

#import "GTMainViewController.h"
#import <Parse/Parse.h>

@interface GTMainViewController ()

@end

@implementation GTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // When users indicate they are no longer Giants fans, we unsubscribe them.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"Location" forKey:@"channels"];
    [currentInstallation saveInBackground];
}

- (IBAction)sendLocation:(id)sender
{
    float latitude, longitude;
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *here = locationManager.location;
    
    // Get the accuracy of the location
    float acc = here.horizontalAccuracy;
    
    // Call the WS to check-in
    /*
    NSDictionary* postParams = @{
                                 @"settingsID": [NSNumber numberWithInt:self.appSettings.settingsID],
                                 @"verified": [NSNumber numberWithInt:((self.checkinVerified) ? 1 : 0)],
                                 @"accuracy": [NSNumber numberWithFloat:acc],
                                 @"latitude": [NSNumber numberWithFloat:here.coordinate.latitude ],
                                 @"longitude": [NSNumber numberWithFloat:here.coordinate.longitude ],
                                 @"timestamp": [NSString stringWithFormat:@"2013-10-16 12:00:00"]
                                 };
     */

    latitude = here.coordinate.latitude;
    longitude = here.coordinate.longitude;
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Location"];
    [push setMessage:[NSString stringWithFormat:@"My Location: %f, %f", latitude, longitude]];
    [push sendPushInBackground];
}

@end
