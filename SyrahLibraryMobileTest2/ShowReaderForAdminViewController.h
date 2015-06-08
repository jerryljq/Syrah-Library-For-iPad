//
//  ShowReaderForAdminViewController.h
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/24.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRDatabase.h"
#import "SyrahBorrowCard.h"

@interface ShowReaderForAdminViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    UISearchBar *searchBar;
}

@end
