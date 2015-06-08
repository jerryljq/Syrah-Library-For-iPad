//
//  SyrahBook.m
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "SyrahBook.h"
#import "SRDatabase.h"

/*
@interface SyrahBook : NSObject {
    
    NSString *bookID;
    NSString *bookCategory;
    NSString *bookTitle;
    NSString *bookPress;
    int bookPubYear;
    NSString *bookAuthor;
    float bookPrice;
    int bookStoreNumTotal;
    int bookStoreNumCurrent;
}
 
 */

@implementation SyrahBook

-(void)newBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum {
    
    //Insert a new book
    //Creating a new instance
    
    bookID = ID;
    bookCategory = category;
    bookTitle = title;
    bookPress = press;
    bookPubYear = year;
    bookAuthor = author;
    bookPrice = price;
    bookStoreNumTotal = bookNum;
    
}

-(BOOL)isBookAlreadyExistingInLibrary:(NSString *)bookID {
    
    //DB Query Book ID
    /*
     if([bookDB found])
        return true;
     else
        return false;
     */
    return false;
     
}

-(int)insertIntoLibrary {
    
    int errorNo = 0;
    if ([self isBookAlreadyExistingInLibrary:bookID]) {
        //Update
    } else {
        //Make SQL query statement
        //[DB insert]
    }
    
    SRDatabase *db = [[SRDatabase alloc] init];
    
    errorNo = [db openDB];
    return errorNo;
}

-(NSString *)getBookID {
    return bookID;
}

-(NSString *)getBookTitle {
    return bookTitle;
}

-(NSString *)getAuthor {
    return bookAuthor;
}

-(NSString *)getPress {
    return bookPress;
}

-(int)getPubYear {
    return bookPubYear;
}

-(int)getBookNum {
    return bookStoreNumTotal;
}

-(SyrahBook *)initWithNewBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum {
    
    if (self = [super init]) {
        bookID = ID;
        bookCategory = category;
        bookTitle = title;
        bookPress = press;
        bookPubYear = year;
        bookAuthor = author;
        bookPrice = price;
        bookStoreNumTotal = bookNum;
        
    }
    return self;
    
    
}

+(SyrahBook *)initWithNewBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum {
    
    SyrahBook *book = [[SyrahBook alloc] initWithNewBookID:ID newBookCate:category newBookTit:title newBookPress:press newBookYear:year newBookAut:author newBookPrice:price totalNum:bookNum];
    
    return book;
}


@end
