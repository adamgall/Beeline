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
@end

@implementation GTMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.defaultChannel = @"Location";
    
    [self addDefaultChannel];
}

- (void)addDefaultChannel
{
    // When users indicate they are no longer Giants fans, we unsubscribe them.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:self.defaultChannel forKey:@"channels"];
    [currentInstallation saveInBackground];
}

- (void)removeDefaultChannel
{
    }

- (IBAction)sendLocation:(id)sender
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation removeObject:self.defaultChannel forKey:@"channels"];
    [currentInstallation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        PFPush *push = [[PFPush alloc] init];
        [push setChannel:@"Location"];
        [push setMessage:@"Crap butt."];
        [push sendPushInBackground];
        
        [self addDefaultChannel];
    }];
}

@end
