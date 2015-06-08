//
//  ShowBookTableTableViewController.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/22.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "ShowBookTableTableViewController.h"

@interface ShowBookTableTableViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;

@end

@implementation ShowBookTableTableViewController

- (void)viewDidLoad {
    
  //  SRDatabase *db = [[SRDatabase alloc] init];
  //  NSString *queryAllBooksStatement = @"SELECT * FROM book";
  //  self.dataArray = [db bookQuery:queryAllBooksStatement];
    
    self.navigationController.navigationBarHidden = NO;
    
    float fv = _NavBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.tableView.frame = CGRectMake(0, fv, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-fv);

    
 //   [self.navigationItem setTitle:@"Hello"];
    
 //   self.navigationController.navigationBar.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 44);
    
    [super viewDidLoad];
    
    [self addSearchBar];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    
 /*   [self.tableView setClipsToBounds:YES];
    float fv = self.navigationController.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    
    self.tableView.frame = CGRectMake(0, fv, self.tabBarController.view.frame.size.width, self.tabBarController.view.frame.size.height-fv);*/
 //   self.navigationController.navigationBar.translucent = YES;
 //   self.tabBarController.tabBar.translucent = YES;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.dataArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookInfo"];
    // Configure the cell...
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    }
    
    //[[cell textLabel] setText:@"Test 0"];
    
    
    SyrahBook *temp = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [temp getBookTitle];
    NSLog([temp getBookID]);
    NSLog([temp getBookTitle]);
    
    return cell;
    
}

-(void)addSearchBar {
    
    CGRect viewRect = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 60);
    CGRect SearchBarRect = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, self.view.frame.size.width, 44);
    
    view = [[UIView alloc] initWithFrame:viewRect];
    searchBar = [[UISearchBar alloc] initWithFrame:SearchBarRect];
    
    searchBar.placeholder = @"Search";
    searchBar.showsCancelButton = YES;
    searchBar.delegate = view;
    
    navBar = [[UINavigationBar alloc] initWithFrame:viewRect];
    
    
    
    [self.view addSubview:view];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
