//
//  AdminInfoViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/28.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "AdminInfoViewController.h"
#import "SRDatabase.h"
extern NSString *currentUserID;

@interface AdminInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *adminIDText;
@property (weak, nonatomic) IBOutlet UITextField *adminNameText;
@property (weak, nonatomic) IBOutlet UITextField *adminContactText;
@property (weak, nonatomic) IBOutlet UITextField *adminWorkText;
@property (weak, nonatomic) IBOutlet UITextField *adminPassText;

@end

@implementation AdminInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)resetPass:(UIButton *)sender {
    
    NSString *updatePass = [NSString stringWithFormat:@"UPDATE admin SET adminPass = '%@' WHERE adminID = '%@';", _adminPassText.text, currentUserID];
    
    SRDatabase *db = [[SRDatabase alloc] init];
    int errorNo = [db insertData:updatePass];
    
    if (errorNo == 0) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"密码修改成功" message:@"你已经修改了你的密码" delegate:self  cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [view show];
    } else {
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"密码修改失败" message:temp delegate:self  cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [view show];
    }
    
}


-(void)refreshView {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *userQuery = [NSString stringWithFormat:@"SELECT * FROM admin WHERE adminID = '%@';", currentUserID];
    NSMutableArray *temp = [db adminQuery:userQuery];
    SyrahManagement *tempUser = [temp objectAtIndex:0];
    
    _adminIDText.text = currentUserID;
    _adminNameText.text = [tempUser getRealName];
    _adminWorkText.text = [tempUser getAdminWork];
    _adminContactText.text = [tempUser getAdminContact];
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
