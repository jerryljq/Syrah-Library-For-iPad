//
//  ShowBookTableTableViewController.h
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/22.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyrahBook.h"
#import "SRDatabase.h"

@interface ShowBookTableTableViewController : UITableViewController {
    NSMutableArray *dataArray;
    UITableView *dataView;
    UISearchBar *searchBar;
    UINavigationBar *navBar;
    UIView *view;
}

@property (nonatomic, retain)NSMutableArray *dataArray;



@end
