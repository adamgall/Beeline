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
    PFPush *push = [[PFPush alloc] init];
    [push setChannel:@"Location"];
    [push setMessage:@"Crap butt."];
    [push sendPushInBackground];
}

@end
