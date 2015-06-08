//
//  InsertBookControllerViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/18.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "InsertBookControllerViewController.h"
#import "SyrahDatabase/SyrahBook.h"

@interface InsertBookControllerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *bookId;
@property (weak, nonatomic) IBOutlet UITextField *bookTitle;
@property (weak, nonatomic) IBOutlet UITextField *bookAuthor;
@property (weak, nonatomic) IBOutlet UITextField *bookPress;
@property (weak, nonatomic) IBOutlet UITextField *bookNum;
@property (weak, nonatomic) IBOutlet UITextField *bookPubYear;
@property (weak, nonatomic) IBOutlet UITextField *bookCate;
@property (weak, nonatomic) IBOutlet UITextField *bookPrice;


@end

@implementation InsertBookControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)InsertBook:(id)sender {
    
    SyrahBook *newBook = [[SyrahBook alloc] init];
    [newBook newBookID:_bookId.text newBookCate:_bookCate.text newBookTit:_bookTitle.text newBookPress:_bookPress.text newBookYear:[_bookPubYear.text intValue] newBookAut:_bookAuthor.text newBookPrice:[_bookPrice.text floatValue] totalNum:[_bookNum.text intValue]];
   
    SRDatabase *db = [[SRDatabase alloc] init];
    //[db openDB];
    
    //Create a SQL Query including the bookID
    NSString *existingQuery = [NSString stringWithFormat:@"SELECT bookID FROM book WHERE bookID = '%@';", _bookId.text];
    
    NSMutableArray *existingResult = [db bookQuery:existingQuery];
    
    if ([existingResult count] != 0) {
        //Book already exists
        NSLog(@"This book already exists in the library");
        //Update the record
    } else {
        //This book does not exist in the library, create a new record
        NSLog(@"This book does not exist. Now will create it");
        
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO book VALUES ('%@','%@','%@','%@', %d, '%@', %f, %d);", _bookId.text, _bookCate.text, _bookTitle.text, _bookPress.text, _bookPubYear.text.intValue, _bookAuthor.text, _bookPrice.text.floatValue, _bookNum.text.intValue];
       
        int errorNo = [db insertData:insertQuery];
        
        if (errorNo == 0) {
            //_UserPassText.text = nil;
            NSLog(@"Update finished");
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"图书插入成功" message:@"新图书已经添加到书库当中。" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
            
        } else {
            NSLog(@"Error with error no %d\n", errorNo);
            NSString *temp = [NSString stringWithFormat:@"错误代码%d", errorNo];
            UIAlertView *passWordWrongAlert = [[UIAlertView alloc] initWithTitle:@"插入新书出错" message:temp delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
            [passWordWrongAlert show];
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
