//
//  ShowBookForAdminViewController.h
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/23.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRDatabase.h"
#import "SyrahBook.h"

@interface ShowBookForAdminViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UISearchBar *searchBar;
}

@end
