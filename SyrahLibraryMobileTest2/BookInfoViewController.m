//
//  BookInfoViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/24.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "BookInfoViewController.h"

@interface BookInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookNameText;
@property (weak, nonatomic) IBOutlet UITextField *bookTitleText;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthorText;
@property (weak, nonatomic) IBOutlet UITextField *bookPressText;
@property (weak, nonatomic) IBOutlet UITextField *bookNumText;
@property (weak, nonatomic) IBOutlet UITextField *bookPubYearText;
@property (weak, nonatomic) IBOutlet UITextField *bookCategoryText;
@property (weak, nonatomic) IBOutlet UITextField *bookPriceText;
@property (weak, nonatomic) IBOutlet UITextField *bookNumAddText;


@end

@implementation BookInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"bookinfo" object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)notificationHandler:(NSNotification *)notification {
    
    NSLog(@"4-------");
    SyrahBook *bookReceived = [notification object];
    _bookNameText.text = [bookReceived getBookID];
    _bookTitleText.text = [bookReceived getBookTitle];
    //_bookAuthorText.text = [bookReceived getBook]
    NSLog(_bookTitleText.text);
    NSLog(_bookNameText.text);
    
}
- (IBAction)ModifyBookData:(UIButton *)sender {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
 //   NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO book VALUES ('%@','%@','%@','%@', %d, '%@', %f, %d);", _bookId.text, _bookCate.text, _bookTitle.text, _bookPress.text, _bookPubYear.text.intValue, _bookAuthor.text, _bookPrice.text.floatValue, _bookNum.text.intValue];
    
    NSString *updateQuery = [NSString stringWithFormat:@"UPDATE book SET bookCate ='%@', bookTitle = '%@', bookPress = '%@', bookPubYear = '%@', bookAuthor = '%@', bookPrice = '%@' WHERE bookID = '%@';", _bookCategoryText.text, _bookTitleText.text, _bookPressText.text, _bookPubYearText.text, _bookAuthorText.text, _bookPriceText.text, _bookNameText.text];
    
    int errorNo = [db insertData:updateQuery];
    
    if (errorNo) {
        NSLog(@"Error with error number %d\n", errorNo);
    } else {
        NSLog(@"Book updated successfully");
    }
    
}
- (IBAction)closeBookView:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addStorage:(UIButton *)sender {
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *addQuery = [NSString stringWithFormat:@"UPDATE book SET bookNum = '%d' WHERE bookID = '%@';", _bookNumText.text.intValue + _bookNumAddText.text.intValue, _bookNameText.text];
    
    int errorNo = [db insertData:addQuery];
    if (errorNo) {
        NSLog(@"Error with error number %d\n", errorNo);
    } else {
        
        NSLog(@"Book added successfully");
        _bookNumText.text = [NSString stringWithFormat:@"%d",_bookNumText.text.intValue + _bookNumAddText.text.intValue];
        _bookNumAddText.text = nil;
        
    }
    
}
- (IBAction)deleteBook:(UIButton *)sender {
    SRDatabase *db = [[SRDatabase alloc] init];
    
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM book WHERE bookID = '%@';", _bookNameText.text];
    int errorNo = [db insertData:deleteQuery];
    if (errorNo == 0) {
        NSLog(@"Update finished");
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"图书删除成功" message:@"你已经删除了这本图书" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        NSLog(@"Error with error no %d\n", errorNo);
        NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
        UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"图书删除出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [passWordWrongAlert show];
    }
    
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
