//
//  RecordInfoViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/26.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "RecordInfoViewController.h"
#import "SRDatabase.h"

@interface RecordInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookIDText;
@property (weak, nonatomic) IBOutlet UITextField *bookTitleText;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorText;
@property (weak, nonatomic) IBOutlet UITextField *bookPressText;
@property (weak, nonatomic) IBOutlet UITextField *userIDText;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *userContactText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBeginTimeText;
@property (weak, nonatomic) IBOutlet UITextField *borrowLengthText;
@property (weak, nonatomic) IBOutlet UITextField *borrowReturnTimeText;
@property (strong, nonatomic)SyrahBorrowRecord *recordReceived;

@end

@implementation RecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"recordinfoa" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)notificationHandler:(NSNotification *)notification {
    
    NSLog(@"8--------");
    _recordReceived = [notification object];
    _bookIDText.text = [_recordReceived getBookID];
    
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM book WHERE bookID = '%@';", [_recordReceived getBookID]];
    
    NSMutableArray *tempResult = [db bookQuery:tempQuery];
    SyrahBook *tempBook = [tempResult objectAtIndex:0];
    
    _borrowBeginTimeText.text = [_recordReceived getBorrowDate];
    _borrowLengthText.text = [NSString stringWithFormat:@"%d", [_recordReceived getLength]];
    _borrowReturnTimeText.text = [_recordReceived getReturnDate];
    _bookTitleText.text = [tempBook getBookTitle];
    _bookPressText.text = [tempBook getPress];
    _bookAuthorText.text = [tempBook getAuthor];
}

- (IBAction)returnBook:(UIButton *)sender {
    
    //Borrow one book and number decreases by 1
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *borrowCheckQuery = [NSString stringWithFormat:@"SELECT * FROM book WHERE bookID = '%@';", [_recordReceived getBookID]];
    NSMutableArray *checkQueryResult = [db bookQuery:borrowCheckQuery];
    int remainBook = [[checkQueryResult objectAtIndex:0] getBookNum];
    NSString *borrowCountSubtract = [NSString stringWithFormat:@"UPDATE book SET bookNum = %d WHERE bookID = '%@';", remainBook+1, [_recordReceived getBookID]];
    int errorNo = [db insertData:borrowCountSubtract];
    
    if (errorNo == 0) {
        NSLog(@"Update finished");
        
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"还书成功" message:@"你已经归还这本书" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        NSLog(@"Error with error no %d\n", errorNo);
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"还书出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }

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
