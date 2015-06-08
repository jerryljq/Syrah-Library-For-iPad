//
//  UserInfoViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/24.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SyrahBorrowCard.h"
#import "SRDatabase.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UserIDText;
@property (weak, nonatomic) IBOutlet UITextField *UserNameText;
@property (weak, nonatomic) IBOutlet UITextField *UserPassText;
@property (weak, nonatomic) IBOutlet UITextField *UserWorkPlaceText;
@property (weak, nonatomic) IBOutlet UITextField *UserContactText;
@property (strong, nonatomic)SyrahBorrowCard *userReceived;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"userinfo" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)notificationHandler:(NSNotification *)notification {
    
    NSLog(@"5--------");
    _userReceived = [notification object];
    _UserIDText.text = [_userReceived getUserID];
    _UserNameText.text = [_userReceived getUserName];
    _UserWorkPlaceText.text = [_userReceived getUserWork];
    _UserContactText.text = [_userReceived getUserContact];
}

- (IBAction)resetPassword:(UIButton *)sender {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
    NSString *currentUserID = [_userReceived getUserID];
    
    NSString *resetPasswordQuery = [NSString stringWithFormat:@"UPDATE user SET userPass='%@' WHERE userID = '%@';", _UserPassText.text, currentUserID];
    
    int errorNo = [db insertData:resetPasswordQuery];
    
    if (errorNo == 0) {
        _UserPassText.text = nil;
        NSLog(@"Update finished");
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"密码重置成功" message:@"你已经重置了该用户的密码" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
        
    } else {
        NSLog(@"Error with error no %d\n", errorNo);
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"重置密码出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }
}

- (IBAction)deleteReader:(id)sender {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM user WHERE userID = '%@';", [_userReceived getUserID]];
    int errorNo = [db insertData:deleteQuery];
    if (errorNo == 0) {
        NSLog(@"Update finished");
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"用户删除成功" message:@"你已经删除了这个用户" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        NSLog(@"Error with error no %d\n", errorNo);
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"用户删除出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)modifyReaderData:(UIButton *)sender {
    
    // TO BE FINISHED
}

- (IBAction)closeView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
