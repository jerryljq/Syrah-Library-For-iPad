//
//  ViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/18.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "ViewController.h"

extern NSString *currentUserID;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPass;
@property (weak, nonatomic) IBOutlet UISegmentedControl *UserType;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginCheck:(id)sender {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    //[db openDB];
    
    if ([_UserType selectedSegmentIndex] == 0) {
        NSLog(@"Reader\n");
        
        NSString *userLoginQuery = [NSString stringWithFormat:@"SELECT * FROM user WHERE userID = '%@';", _userName.text];
        
        NSMutableArray *result = [db userQuery:userLoginQuery];
        
        if ([result count] != 0) {
            for (SyrahBorrowCard *userTemp in result) {
                if ([[userTemp getUserID] isEqualToString:_userName.text]) {
                    if ([[userTemp gerUserPass] isEqualToString:_userPass.text]) {
                        NSLog(@"User login successful");
                        [self performSegueWithIdentifier:@"loginCheckSucc" sender:self];
                        currentUserID = [userTemp getUserID];
                        
                    } else {
                        NSLog(@"Password is wrong");
                        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"您输入的密码有误..." delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [passWordWrongAlert show];
                        self.userPass.text = nil;
                    }
                }
            }
        } else {
            NSLog(@"User does not exist");
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"用户不存在" message:@"请先注册新用户..." delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
            self.userPass.text = nil;
            self.userName.text = nil;
        }

    } else if ([_UserType selectedSegmentIndex] == 1) {
        
        // Begin of Administrator Login
        NSLog(@"Admin\n");

        // Create query statement
        NSString *adminLoginQuery = [NSString stringWithFormat:@"SELECT * FROM admin WHERE adminID = '%@'", self.userName.text];
        
        //Receive Query statement
        NSMutableArray *result = [db adminQuery:adminLoginQuery];

        
        //Traversal the results and find if the user occours
        if ([result count] != 0) {
            for (SyrahManagement *adminTemp in result) {
                if ([[adminTemp getAdminName] isEqualToString:_userName.text]) {
                    if ([[adminTemp getAdminPass] isEqualToString:_userPass.text]) {
                        NSLog(@"Login Succeeded!\n");
                        [self performSegueWithIdentifier:@"adminCheckSucc" sender:self];
                        currentUserID = [adminTemp getAdminName];
                    } else {
                        //Alert that password is wrong
                        NSLog(@"Password is wrong");
                        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"您输入的密码有误..." delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [passWordWrongAlert show];
                        self.userPass.text = nil;
                    }
                }
            }
            //The end of the Administrator user login
        } else {
            //Alert user does not exist
            
            NSLog(@"User does not exist");
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"用户不存在" message:@"请先注册新用户..." delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
            self.userPass.text = nil;
            self.userName.text = nil;
        }
        
        
    } else if ([_UserType selectedSegmentIndex] == 2) {
        NSLog(@"Visitor\n");
            [self performSegueWithIdentifier:@"visitorCheckSucc" sender:self];
        currentUserID = nil;
        
    }
}

- (IBAction)register:(id)sender {
    [self performSegueWithIdentifier:@"Register" sender:self];
}

@end
