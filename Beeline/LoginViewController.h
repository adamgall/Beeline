//
//  LoginViewController.h
//  Beeline
//
//  Created by Brandon Thomas on 3/31/14.
//  Copyright (c) 2014 Gall Thomas Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)loginPressed:(id)sender;

@end
