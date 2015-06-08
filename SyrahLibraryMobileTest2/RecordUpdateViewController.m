//
//  RecordUpdateViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/25.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "RecordUpdateViewController.h"
#import "SRDatabase.h"

@interface RecordUpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookIDText;
@property (weak, nonatomic) IBOutlet UITextField *bookNameText;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorText;
@property (weak, nonatomic) IBOutlet UITextField *bookPressText;
@property (weak, nonatomic) IBOutlet UITextField *bookPubYearText;
@property (weak, nonatomic) IBOutlet UITextField *bookBorrowTimeText;
@property (weak, nonatomic) IBOutlet UITextField *bookBorrowLengthText;
@property (weak, nonatomic) IBOutlet UITextField *bookReturnTimeText;
@property (weak, nonatomic) IBOutlet UITextField *bookAddBorrowLengthText;
@property (strong, nonatomic)SyrahBorrowRecord *recordReceived;

@end

@implementation RecordUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"recordinfo" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)notificationHandler:(NSNotification *)notification {
    
    NSLog(@"8--------");
    _recordReceived = [notification object];
    _bookIDText.text = [_recordReceived getBookID];
    
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *tempQuery = [NSString stringWithFormat:@"SELECT * FROM book WHERE bookID = '%@';", [_recordReceived getBookID]];
    
    NSMutableArray *tempResult = [db bookQuery:tempQuery];
    SyrahBook *tempBook = [tempResult objectAtIndex:0];
    
    _bookBorrowTimeText.text = [_recordReceived getBorrowDate];
    _bookBorrowLengthText.text = [NSString stringWithFormat:@"%d", [_recordReceived getLength]];
    _bookReturnTimeText.text = [_recordReceived getReturnDate];
    _bookNameText.text = [tempBook getBookTitle];
    _bookPressText.text = [tempBook getPress];
    _bookPubYearText.text = [NSString stringWithFormat:@"%d", [tempBook getPubYear]];
    _bookAuthorText.text = [tempBook getAuthor];
}
- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addLength:(id)sender {
    //Database operation
    SRDatabase *db = [[SRDatabase alloc] init];
    
    int queryID = [_recordReceived getRecordID];
    
    int allDay = _bookBorrowLengthText.text.intValue+_bookAddBorrowLengthText.text.intValue;
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *beginDate = [format dateFromString:_bookReturnTimeText.text];
    
    NSDate *newReturnDate = [beginDate dateByAddingTimeInterval:allDay * 24 * 3600];
    
    NSString *newReturnDateStr = [format stringFromDate:newReturnDate];
    
    NSString *updateQuery = [NSString stringWithFormat:@"UPDATE borrowRecord SET borrowLength = %d, returnDate = '%@' WHERE recordID = %d;", allDay, newReturnDateStr, [_recordReceived getRecordID]];
    
    int errorNo = [db insertData:updateQuery];
    
    if (errorNo == 0) {
        NSLog(@"Update finished");
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"更新成功" message:@"你已经更新了借书记录" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
        
    } else {
        NSLog(@"Error with error no %d\n", errorNo);
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"更新记录出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }
    
    _bookBorrowLengthText.text = [NSString stringWithFormat:@"%d", allDay];
    
    _bookReturnTimeText.text = newReturnDateStr;
    
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
