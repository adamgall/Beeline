//
//  LoginViewController.m
//  Beeline
//
//  Created by Brandon Thomas on 3/31/14.
//  Copyright (c) 2014 Gall Thomas Inc. All rights reserved.
//

#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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

- (IBAction)loginPressed:(id)sender {
    NSString *username = self.email.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            UIStoryboard *board = self.storyboard;
                                            UIViewController *next = [board instantiateViewControllerWithIdentifier:@"Beeline"];
                                            [self.navigationController presentViewController:next animated:YES completion:nil];
                                        } else {
                                            // The login failed. Check error to see why.
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:error.description delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                                            [alert show];
                                        }
                                    }];
}

@end
