//
//  BookBorrowViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/25.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "BookBorrowViewController.h"
#import "SRDatabase.h"

extern NSString *currentUserID;

@interface BookBorrowViewController ()
@property (weak, nonatomic) IBOutlet UITextField *borrowBookIDText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBookNameText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBookAuthorText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBookPressText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBookPubYearText;
@property (weak, nonatomic) IBOutlet UITextField *borrowBookBorrowTime;
@property (weak, nonatomic) IBOutlet UITextField *borrowLength;
@property (weak, nonatomic) IBOutlet UITextField *borrowReturnTime;
@property (weak, nonatomic) IBOutlet UITextField *currentUserText;
@property (strong, nonatomic)NSString *currentUserID;
@property (strong, nonatomic)SyrahBook *currentBook;
@property (strong, nonatomic)NSDate *now;

@end

@implementation BookBorrowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"borrowInfo" object:nil];
    _borrowLength.text = @"0";
    _now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *now = [dateFormat stringFromDate:_now];
    _borrowBookBorrowTime.text = now;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)notificationHandler:(NSNotification *)notification {
    
    NSLog(@"6---------");
    //What is received object? It's a NSMutableArray!
    NSMutableArray *receivedObject = [notification object];
    //_currentUserID = [receivedObject objectAtIndex:1];
    _currentBook = [receivedObject objectAtIndex:0];
    _currentUserText.text = currentUserID;
    _borrowBookIDText.text = [_currentBook getBookID];
    _borrowBookNameText.text = [_currentBook getBookTitle];
    _borrowBookAuthorText.text = [_currentBook getAuthor];
    _borrowBookPressText.text = [_currentBook getPress];
    _borrowBookPubYearText.text = [NSString stringWithFormat:@"%d", [_currentBook getPubYear]];
}

- (IBAction)borrowViewClear:(UIButton *)sender {
    _borrowLength.text = @"0";
}
- (IBAction)borrowBook:(UIButton *)sender {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
    NSString *borrowCheckQuery = [NSString stringWithFormat:@"SELECT * FROM book WHERE bookID = '%@';", [_currentBook getBookID]];
    NSMutableArray *checkQueryResult = [db bookQuery:borrowCheckQuery];
    int remainBook = [[checkQueryResult objectAtIndex:0] getBookNum];
    
    if (remainBook > 0) {
        //Create a SQL query
        NSString *borrowQuery = [NSString stringWithFormat:@"INSERT INTO borrowRecord(userID, bookID, borrowDate, returnDate, borrowLength) VALUES ('%@', '%@', '%@', '%@', %d);", currentUserID, [_currentBook getBookID], _borrowBookBorrowTime.text, _borrowReturnTime.text, _borrowLength.text.intValue];
        //SQL_EXEC
        NSString *borrowCountSubtract = [NSString stringWithFormat:@"UPDATE book SET bookNum = %d WHERE bookID = '%@';", remainBook-1, [_currentBook getBookID]];
        
        int errorNo = [db insertData:borrowQuery];
        int errorNo2 = [db insertData:borrowCountSubtract];
        
        if (errorNo == 0 && errorNo2 == 0) {
            NSLog(@"Update finished");
            
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"借书成功" message:@"你已经借书，请按时还书。祝你阅读愉快。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            NSLog(@"Error with error no %d %d\n", errorNo, errorNo2);
            NSString *temp = [NSString stringWithFormat:@"错误代码%d %d", errorNo, errorNo2];
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"借书出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
        }
    } else {
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"借书失败" message:@"图书数量不足，请联系管理员" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }
    
    //Show result
    
}
- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)insmodifytime:(UITextField *)sender {
    
    NSDate *returnDate = [_now dateByAddingTimeInterval:24 * 3600 * _borrowLength.text.intValue];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *returnDateStr = [dateFormat stringFromDate:returnDate];
    _borrowReturnTime.text = returnDateStr;
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
