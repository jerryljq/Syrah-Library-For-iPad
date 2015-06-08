//
//  SRDatabase.h
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/18.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#define TYPEUSER 0
#define TYPEADMIN 1
#define TYPEBOOK 2
#define TYPEBORROW 3

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SyrahManagement.h"
#import "SyrahBorrowCard.h"
#import "SyrahBook.h"
#import "SyrahBorrowRecord.h"

@interface SRDatabase : NSObject {
    
    //State a variable of DB
    sqlite3 *db;
}

-(int)openDB;

-(int)createNewTable:(NSString *)tableName;

-(int)insertData:(NSString *)data;

-(NSMutableArray *)select:(NSString *)sqlQuery;

-(NSMutableArray *)bookQuery:(NSString *)sqlQuery;

-(NSMutableArray *)adminQuery:(NSString *)sqlQuery;

-(NSMutableArray *)userQuery:(NSString *)sqlQuery;

-(NSMutableArray *)borrowListQuery:(NSString *)sqlQuery;

-(NSString *)checkString:(const unsigned char *)cString;

-(void)closeDB;







@end
