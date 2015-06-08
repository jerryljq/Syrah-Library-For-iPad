//
//  SRDatabase.m
//  SyrahLibraryMobileTest2
//
//  Created by Jerry Lee on 15/4/18.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//


#import "SRDatabase.h"

@implementation SRDatabase

-(int)openDB {
    
    NSString *fileSearch = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName;
    const char *cfileName;
    
    fileName = [fileSearch stringByAppendingPathComponent:@"bookStorage.sqlite"];
    NSLog(fileName);
    
    cfileName = fileName.UTF8String;
    
    int errorNo = sqlite3_open(cfileName, &(db));
    
    if (errorNo == SQLITE_OK) {
        NSLog(@"Database Opened succeeded\n");
        //return 1;
    } else {
        NSLog(@"Database Open failed\n");
        //return 0;
    }
    
    const char *sql="CREATE TABLE IF NOT EXISTS admin (adminID text PRIMARY KEY,adminName text NOT NULL,adminPass char NOT NULL, adminContact char, adminWorkPlace char, adminInviteCode char);CREATE TABLE IF NOT EXISTS user (userID text PRIMARY KEY, userName text NOT NULL,userPass char NOT NULL, userContact char, userWorkPlace char); CREATE TABLE IF NOT EXISTS book (bookID text PRIMARY KEY, bookCate text, bookTitle text NOT NULL, bookPress text, bookPubYear int, bookAuthor text, bookPrice double, bookNum int);CREATE TABLE IF NOT EXISTS borrowRecord (recordID integer PRIMARY KEY AUTOINCREMENT, userID text NOT NULL, bookID text NOT NULL, borrowDate text NOT NULL, returnDate text NOT NULL, borrowLength int NOT NULL);";
    
    char *errmsg=NULL;
    errorNo = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
    if (errorNo == SQLITE_OK) {
        NSLog(@"Table created successfully\n");
        return 1;
    } else {
        NSLog(@"Table created failed\n");
        NSLog(@"Error number: %d", errorNo);
        return 0;
    }
    
}

-(int)createNewTable:(NSString *)tableName {
    
    
    return 0;
}

-(int)insertData:(NSString *)data {
    
    const char *insertQuery = data.UTF8String;
    
    char *err;
    
    printf("%s\n", insertQuery);
    
    [self openDB];
    
    int errorNo = sqlite3_exec(db, insertQuery, NULL, NULL, &err);
    
    //printf("%s\n", err);
    
    [self closeDB];
    
    return errorNo;
}

-(NSMutableArray *)select:(NSString *)sqlQuery {
    
 /*   //const char *queryStatement = sqlQuery.UTF8String;
    const char *queryStatement = "Select id, name from book where total_num > 20";
    sqlite3_stmt *stmt = NULL;
    NSMutableArray *queryResult = [[NSMutableArray alloc] init];
    
    if (sqlite3_prepare_v2(db, queryStatement, -1, &stmt, NULL) == SQLITE_OK) {
        NSLog(@"* Query Statement is okay\n");
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            int colNumber = sqlite3_column_count(stmt);
            NSMutableArray *thisQuery = [[NSMutableArray alloc] init];
            for (int i = 0; i < colNumber; i++) {
                NSString *temp = sqlite3_column_text(stmt, i);
                id p = CFBridgingRelease(temp);
            }
            
            
            
        }
        
    }
    
    */
    return 0;
}

-(NSMutableArray *)bookQuery:(NSString *)sqlQuery {
    
    [self openDB];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    const char *queryStatement = sqlQuery.UTF8String;
    
    sqlite3_stmt *stmt = NULL;
    
    if (sqlite3_prepare_v2(db, queryStatement, -1, &stmt, NULL) == SQLITE_OK) {
        
        NSLog(@"Query Statement is okay");
        printf("%s\n", queryStatement);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
            NSString *bookID = [self checkString:sqlite3_column_text(stmt, 0)];
            NSString *bookCategory = [self checkString:sqlite3_column_text(stmt, 1)];
            NSString *bookTitle = [self checkString:sqlite3_column_text(stmt, 2)];
            NSString *bookPress = [self checkString:sqlite3_column_text(stmt, 3)];
            int bookPubYear = sqlite3_column_int(stmt, 4);
            NSString *bookAuthor = [self checkString:sqlite3_column_text(stmt, 5)];
            double price = sqlite3_column_double(stmt, 6);
            int bookNumTotal = sqlite3_column_int(stmt, 7);
            
            SyrahBook *book = [[SyrahBook alloc] init];
            [book newBookID:bookID newBookCate:bookCategory newBookTit:bookTitle newBookPress:bookPress newBookYear:bookPubYear newBookAut:bookAuthor newBookPrice:price totalNum:bookNumTotal];
            [result addObject:book];
            
        }
    } else {
        
        NSLog(@"Error here");
        [self closeDB];
        return nil;
    }
    [self closeDB];
    return result;
}

-(NSMutableArray *)adminQuery:(NSString *)sqlQuery {
    
    [self openDB];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];

    
    const char *queryStatement = sqlQuery.UTF8String;
   // const char *queryStatement = "Select * from admin";
    sqlite3_stmt *stmt = NULL;
    
   // const char *testPurpose = "INSERT INTO admin (adminID, adminName, adminPass) VALUES ('3130000548', 'admin', 'admin');";
   // int i = sqlite3_exec(db, testPurpose, NULL, NULL, NULL);
   // NSLog(@"here");
   // printf("%d\n", i);
    
    if (sqlite3_prepare_v2(db, queryStatement, -1, &stmt, NULL) == SQLITE_OK) {
        
        NSLog(@"* Query Statement is okay\n");
        printf("%s\n", queryStatement);
        
        //result = nil;
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            const char *adminIDTemp = sqlite3_column_text(stmt, 0);
            const char *adminNameTemp = sqlite3_column_text(stmt, 1);
            const char *adminPassTemp = sqlite3_column_text(stmt, 2);
            const char *adminContactTemp = sqlite3_column_text(stmt, 3);
            const char *adminWorkPlaceTemp = sqlite3_column_text(stmt, 4);
            const char *adminInviteCodeTemp = sqlite3_column_text(stmt, 5);

            
            NSString *adminID = [[NSString alloc] initWithUTF8String:adminIDTemp];
            NSString *adminName = [[NSString alloc] initWithUTF8String:adminNameTemp];
            NSString *adminPass = [[NSString alloc] initWithUTF8String:adminPassTemp];
            NSString *adminConact = @"111";//[[NSString alloc] initWithUTF8String:adminContactTemp];
            NSString *adminWorkPlace = @"222";//[[NSString alloc] initWithUTF8String:adminWorkPlaceTemp];
            NSString *adminInviteCode = @"333";//[[NSString alloc] initWithUTF8String:adminInviteCodeTemp];
            
            SyrahManagement *tempResult = [[SyrahManagement alloc] init];
            [tempResult manRegID:adminID manRegName:adminName manRegPass:adminPass manRegCont:adminConact manWorkPlace:adminWorkPlace manInviteCode:adminInviteCode];
            [result addObject:tempResult];
        }
        
    } else {
        NSLog(@"error !!!!!");
        [self closeDB];
        return nil;
    }
    
    if (result == nil) {
        NSLog(@"111111111");
    } else {
        NSLog(@"222222222");
    }
    
    [self closeDB];
    return result;
}

-(NSMutableArray *)userQuery:(NSString *)sqlQuery {
    
    [self openDB];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
       const char *queryStatement = sqlQuery.UTF8String;
     //const char *queryStatement = "Select * from user";
     sqlite3_stmt *stmt = NULL;
     
     if (sqlite3_prepare_v2(db, queryStatement, -1, &stmt, NULL) == SQLITE_OK) {
         
         NSLog(@"* Query Statement is okay\n");
     
         
         while (sqlite3_step(stmt) == SQLITE_ROW) {
             
             NSString *userID = [self checkString:sqlite3_column_text(stmt, 0)];
           /*  const char *userNameTemp = sqlite3_column_text(stmt, 1);
             const char *userPassTemp = sqlite3_column_text(stmt, 2);
             const char *userContactTemp = sqlite3_column_text(stmt, 3);
             const char *userWorkPlaceTemp = sqlite3_column_text(stmt, 4);*/
             
             NSString *userName = [self checkString:sqlite3_column_text(stmt, 1)];
             NSString *userPass = [self checkString:sqlite3_column_text(stmt, 2)];
             NSString *userContact = [self checkString:sqlite3_column_text(stmt, 3)];
             NSString *userWorkPlace = [self checkString:sqlite3_column_text(stmt, 4)];
             
             SyrahBorrowCard *tempResult = [[SyrahBorrowCard alloc] init];
             [tempResult newCardID:userID newCardUserName:userName newCardPass:userPass newWord:userWorkPlace newCardUserContact:userContact];
             [result addObject:tempResult];
         }
     
     } else {
         NSLog(@"Error");
         [self closeDB];
         return nil;
     }
    
    if (result == nil) {
        NSLog(@"111111111");
    } else {
        NSLog(@"222222222");
    }
    
    [self closeDB];
    return result;
    
}

-(NSMutableArray *)borrowListQuery:(NSString *)sqlQuery {
    
    [self openDB];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    //const char *queryStatement = "SELECT * FROM record";
    const char *queryStatement = sqlQuery.UTF8String;
    
    sqlite3_stmt *stmt = NULL;
    
    if (sqlite3_prepare_v2(db, queryStatement, -1, &stmt, NULL) == SQLITE_OK) {
        
        NSLog(@"* Query Statement is okay\n");
    
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            int recordID = sqlite3_column_int(stmt, 0);
            /*  const char *userNameTemp = sqlite3_column_text(stmt, 1);
             const char *userPassTemp = sqlite3_column_text(stmt, 2);
             const char *userContactTemp = sqlite3_column_text(stmt, 3);
             const char *userWorkPlaceTemp = sqlite3_column_text(stmt, 4);*/
            
            NSString *userID = [self checkString:sqlite3_column_text(stmt, 1)];
            NSString *bookID = [self checkString:sqlite3_column_text(stmt, 2)];
            NSString *borrowLength = [self checkString:sqlite3_column_text(stmt, 5)];
            NSString *borrowDate = [self checkString:sqlite3_column_text(stmt, 3)];
            NSString *returnDate =[self checkString:sqlite3_column_text(stmt, 4)];
            NSDate *convertedBorrowDate = [self dateFromString:borrowDate];
            NSDate *convertedReturnDate = [self dateFromString:returnDate];
            
           // NSDate *borrowDateConverted = [[NSDate alloc] ]
            NSLog(@"1111111111121212");
            SyrahBorrowRecord *tempResult = [[SyrahBorrowRecord alloc] init];
            [tempResult RecordID:recordID BorrowCardID:userID andBorrowBookId:bookID andBorrowLength:borrowLength.intValue andStartDate:borrowDate andEndDate:returnDate];
            NSLog(@"1111111111121212");
            [result addObject:tempResult];
            NSLog(@"1111111111121212");
        }
        
        
        
    } else {
        NSLog(@"Error in Record Query");
        result = nil;
    }
    
    
    [self closeDB];
    return result;
    
}

-(void)closeDB {
    // Close the connection to the database
    sqlite3_close(db);
}

-(NSString *)checkString:(const unsigned char *)cString {
    
    if (cString == NULL) {
        return nil;
    } else {
        NSString *returnStr = [[NSString alloc] initWithUTF8String:cString];
        return returnStr;
    }
}

-(NSDate *)dateFromString:(NSString *)stringDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateResult = [dateFormatter dateFromString:stringDate];
    
    return dateResult;
}

@end
