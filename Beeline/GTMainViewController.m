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

@property (nonatomic, strong) NSString *defaultChannel;

@property (nonatomic, weak) IBOutlet UIButton *sendLocation;

@end

@implementation GTMainViewController

CLLocationManager *locMan = nil;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.defaultChannel = @"Location";
    
    locMan = [[CLLocationManager alloc] init];
    [locMan startUpdatingLocation];
    
    self.sendLocation.enabled = NO;
    
    [self addDefaultChannel];
}

- (void)addDefaultChannel
{
    // When users indicate they are no longer Giants fans, we unsubscribe them.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:self.defaultChannel forKey:@"channels"];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        self.sendLocation.enabled = YES;
    }];
}

- (IBAction)sendLocation:(id)sender
{
    float latitude, longitude;
    CLLocation *here = locMan.location;
    

    latitude = here.coordinate.latitude;
    longitude = here.coordinate.longitude;
    
    NSLog(@"lat: %f\nlong: %f", latitude, longitude);
    
    /*
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Location"];
    [push sendPushInBackground];
    */
    self.sendLocation.enabled = NO;
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:self.defaultChannel forKey:@"channels"];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:self.defaultChannel];
        [push setMessage:[NSString stringWithFormat:@"My Location: %f, %f", latitude, longitude]];
        [push sendPushInBackground];
        
        [self addDefaultChannel];
    }];
}
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
}

@end
