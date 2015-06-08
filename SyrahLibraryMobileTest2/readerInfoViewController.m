//
//  readerInfoViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/28.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "readerInfoViewController.h"
#import "SRDatabase.h"

extern NSString *currentUserID;

@interface readerInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *readerIDText;
@property (weak, nonatomic) IBOutlet UITextField *readerNameText;
@property (weak, nonatomic) IBOutlet UITextField *readerPassText;
@property (weak, nonatomic) IBOutlet UITextField *readerContactText;
@property (weak, nonatomic) IBOutlet UITextField *readerWorkText;

@end

@implementation readerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshView {
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *temp = [NSString stringWithFormat:@"SELECT * FROM user WHERE userID = '%@';", currentUserID];
    NSMutableArray *queryResult = [db userQuery:temp];
    SyrahBorrowCard *show = [queryResult objectAtIndex:0];
    _readerIDText.text = currentUserID;
    _readerNameText.text = [show getUserName];
    _readerContactText.text = [show getUserContact];
    _readerWorkText.text = [show getUserWork];
}
- (IBAction)resetPass:(UIButton *)sender {
    
    NSString *resetPassQuery = [NSString stringWithFormat:@"UPDATE user SET userPass = '%@' WHERE userID = '%@';", _readerPassText.text, currentUserID];
    SRDatabase *db = [[SRDatabase alloc] init];
    
    int errorNo = [db insertData:resetPassQuery];
    
    if (errorNo == 0) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"密码修改成功" message:@"你已经修改了你的密码" delegate:self  cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [view show];
    } else {
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"密码修改失败" message:temp delegate:self  cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [view show];
    }
}
- (IBAction)quitVIew:(UIButton *)sender {
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
