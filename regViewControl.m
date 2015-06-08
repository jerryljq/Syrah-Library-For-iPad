//
//  regViewControl.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/18.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "regViewControl.h"

@interface regViewControl ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *regType;
@property (weak, nonatomic) IBOutlet UITextField *regWorkID;
@property (weak, nonatomic) IBOutlet UITextField *regUserName;
@property (weak, nonatomic) IBOutlet UITextField *regPass;
@property (weak, nonatomic) IBOutlet UITextField *regPassCheck;
@property (weak, nonatomic) IBOutlet UITextField *regWorkPlace;
@property (weak, nonatomic) IBOutlet UITextField *regContact;
@property (weak, nonatomic) IBOutlet UITextField *regAdminInviteCode;
@property (weak, nonatomic) IBOutlet UILabel *regAdminInviteCodeTitle;



@end

@implementation regViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)regTypeChanged:(id)sender {
    if ([_regType selectedSegmentIndex] == 0) {
        [_regAdminInviteCode setHidden:false];
        [_regAdminInviteCodeTitle setHidden:false];
    } else {
        [_regAdminInviteCode setHidden:true];
        [_regAdminInviteCodeTitle setHidden:true];
    }
}
- (IBAction)regSave:(id)sender {
    
    //Database initialization
    SRDatabase *db = [[SRDatabase alloc] init];
    //[db openDB];
    
    if ([_regType selectedSegmentIndex] == 0) {
        
        NSLog(@"Admin register\n");
        
        //Create Query for insertion a new administrator
        NSString *regTemp = [NSString stringWithFormat:@"SELECT * FROM admin WHERE adminID = '%s';", _regWorkID.text.UTF8String];
        NSMutableArray *result = [db adminQuery:regTemp];
        
        NSLog(@"--%d\n", _regAdminInviteCode.text.intValue);
        
        if (_regAdminInviteCode.text.intValue == ADMINCODE) {
        //Simplified for test. Restore it after testing.
            if ([result count] != 0) {
                //User already exists
                NSLog(@"User already exists");
                UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"用户已经存在" message:@"请修改你的用户名" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [succ show];
                } else {
                
                if ([_regPass.text isEqualToString:_regPassCheck.text] && [_regPass.text length] != 0) {
                    //Agree to register
                    NSLog(@"hereby");
                    NSString *regQuery = [NSString stringWithFormat:@"INSERT INTO admin VALUES ('%@', '%@', '%@', '%@', '%@', '%@');", _regWorkID.text, _regUserName.text, _regPass.text, _regWorkPlace.text, _regContact.text, _regAdminInviteCode.text];
                    int errorNo = [db insertData:regQuery];
                    
                    if (errorNo == SQLITE_OK) {
                        NSLog(@"User created successfully");
                        UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"你已经可以登录图书馆" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [succ show];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        NSLog(@"User created failed with error no %d", errorNo);
                        NSLog(@"User created failed with error no %d", errorNo);
                        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
                        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"注册失败" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [fail show];
                    }
                
                } else {
                    //Alert that password is wrong
                    NSLog(@"Password is wrong\n");
                    UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"请两次输入相同的密码" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                    [succ show];
                }
            }
        
        } else {
            UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"邀请码错误" message:@"你输入的邀请码没有权限注册管理员账号" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [succ show];
        }
        
        //Don't forget to close DB after using it!
        NSLog(@"User check finished");
        
        
        //new administrator insertion finished.
        
        //New reader insertion
        
        } else if ([_regType selectedSegmentIndex] == 1) {
            NSLog(@"User register\n");
            
            NSString *regTemp = [NSString stringWithFormat:@"SELECT * FROM user WHERE userID = '%s';", _regWorkID.text.UTF8String];
            NSMutableArray *result = [db userQuery:regTemp];
            
            if ([result count] != 0) {
                //User already exists
                NSLog(@"User already exists");
                UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"用户已经存在" message:@"请修改你的用户名" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                [succ show];
            } else {
                
                if ([_regPass.text isEqualToString:_regPassCheck.text] && [_regPass.text length] != 0) {
                    //Agree to register
                    NSLog(@"hereby");
                    NSString *regQuery = [NSString stringWithFormat:@"INSERT INTO user VALUES ('%@', '%@', '%@', '%@', '%@');", _regWorkID.text, _regUserName.text, _regPass.text, _regWorkPlace.text, _regContact.text];
                    int errorNo = [db insertData:regQuery];
                    
                    if (errorNo == SQLITE_OK) {
                        NSLog(@"User created successfully");
                        UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"注册成功" message:@"你已经可以登录图书馆" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [succ show];
                        [self dismissViewControllerAnimated:YES completion:nil];
                    } else {
                        NSLog(@"User created failed with error no %d", errorNo);
                        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
                        UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"注册失败" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                        [fail show];
                    }
                    
                } else {
                    //Alert that password is wrong
                    NSLog(@"Password is wrong\n");
                    UIAlertView *succ = [[UIAlertView alloc] initWithTitle:@"密码错误" message:@"请两次输入相同的密码" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
                    [succ show];
                }
            }
            
        }
    
    
    //[db closeDB];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
