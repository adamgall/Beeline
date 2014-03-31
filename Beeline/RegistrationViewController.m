//
//  RegistrationViewController.m
//  Beeline
//
//  Created by Brandon Thomas on 3/31/14.
//  Copyright (c) 2014 Gall Thomas Inc. All rights reserved.
//

#import <Parse/Parse.h>
#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

UIAlertView *waitDlg = nil;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    waitDlg = [[UIAlertView alloc] initWithTitle:nil message:@"Please wait while registering your account." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doRegistration:(id)sender {
    [waitDlg show];
    
    PFUser *user = [PFUser user];
    user.username = self.email.text;
    user.password = self.password.text;
    user.email = self.email.text;
    
    // other fields can be set just like with PFObject
    user[@"phone"] = @"419-908-9392";
    user[@"latitude"] = @"0.00";
    user[@"longitude"] = @"0.00";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            [waitDlg dismissWithClickedButtonIndex:0 animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            [waitDlg setMessage:errorString];
            [waitDlg addButtonWithTitle:@"Okay"];
            // Show the errorString somewhere and let the user try again.
        }
    }];
    
}

@end
