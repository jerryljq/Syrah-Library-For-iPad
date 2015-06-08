//
//  ShowRecordForReaderViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/25.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "ShowRecordForReaderViewController.h"
#import "SRDatabase.h"
extern NSString *currentUserID;

@interface ShowRecordForReaderViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *recordList;
@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation ShowRecordForReaderViewController

- (void)viewDidLoad {
    [self addSearchBar];
    [_recordList setDelegate:self];
    [_recordList setDataSource:self];
    [super viewDidLoad];
    
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *queryAllUsersStatement = [NSString stringWithFormat:@"SELECT * FROM borrowRecord WHERE userID = '%@'", currentUserID];
    self.dataArray = [db borrowListQuery:queryAllUsersStatement];
    printf("%d:------\n", [self.dataArray count]);
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addSearchBar {
    
    CGRect searchBarRect = CGRectMake(0, _navBar.frame.size.height-44, self.view.frame.size.width, 44);
    
    searchBar = [[UISearchBar alloc] initWithFrame:searchBarRect];
    
    searchBar.placeholder = @"Search...";
    searchBar.showsCancelButton = YES;
    searchBar.delegate = self;
    _recordList.tableHeaderView = searchBar;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    printf("%d:------\n", [self.dataArray count]);
    return [self.dataArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recordInfo"];
    // Configure the cell...
    
    NSLog(@"hereby");
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    // [[cell textLabel] setText:@"Test 0"];
    NSLog(@"hereby");
    
    SyrahBorrowRecord *temp = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *tempBookID = [temp getBookID];
    
    NSString *bookTitleQuery = [NSString stringWithFormat:@"SELECT * FROM book WHERE bookID = '%@';", tempBookID];
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
    SyrahBook *bookQuery = [[db bookQuery:bookTitleQuery] objectAtIndex:0];
    
    NSString *bookTitle = [bookQuery getBookTitle];
    
    cell.textLabel.text = bookTitle;
    
    // cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self updateView];
    NSLog(@"11111111@@@@@");
    [self performSegueWithIdentifier:@"borrowRecordView" sender:self];
    //Notification operation is block operations. MUST performSegue first.
    NSLog(@"22222222@@@@@");
    NSNotification *userinfo = [NSNotification notificationWithName:@"recordinfo" object:[self.dataArray objectAtIndex:indexPath.row]];
    
    NSLog(@"33333333@@@@@");
    [[NSNotificationCenter defaultCenter] postNotification:userinfo];
    
    
    NSLog(@"you selected section %d row %d",indexPath.section,indexPath.row);
    //  NSLog([[self.dataArray objectAtIndex:indexPath.row] getBookID]);
}

-(void)updateView {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    NSString *queryAllUsersStatement = [NSString stringWithFormat:@"SELECT * FROM borrowRecord WHERE userID = '%@'", currentUserID];
    self.dataArray = [db borrowListQuery:queryAllUsersStatement];
    [self.recordList reloadData];
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
