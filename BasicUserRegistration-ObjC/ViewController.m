//
//  ViewController.m
//  BasicUserRegistration-ObjC
//
//  Created by Ramon Vitor on 07/10/16.
//  Copyright © 2016 Ayrton Alves. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void) alert:(NSString*) message title:(NSString*)title;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)alert:(NSString*)message
       title:(NSString*) title {
    // Show some greeting message
    // Creating a simple alert
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    // Creating the actions of the alert
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle your yes please button action here
                               }];
    
    [alert addAction:okButton];
    
    // Showing the alert
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)login:(id)sender {
    //This gets the fields from the UITextFields
    NSString* username = [self.usernameText text];
    NSString* password = [self.passwordText text];
    
    [PFUser logInWithUsernameInBackground:username password:password
                                    block:^(PFUser *user, NSError *error) {
        if (user) {
            [self alert:@"Welcome back" title:@"Login"];
        } else {
            NSString* errorString = [error userInfo][@"error"];
            [self alert:errorString title:@"Error"];
        }
    }];
}

- (IBAction)register:(id)sender {
    //This gets the fields from the UITextFields
    NSString* username = [self.usernameText text];
    NSString* password = [self.passwordText text];
    
    //We are not setting the email here; just for simplicity sake
    PFUser* user = [PFUser user];
    user.username = username;
    user.password = password;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(!error) {
            [self alert:@"Registered successfully!" title:@"Register"];
        }
        else {
            NSString* errorString = [error userInfo][@"error"];
            [self alert:errorString title:@"Error"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
