//
//  SyrahBook.h
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

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

-(void)newBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum;

-(SyrahBook *)initWithNewBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum;

+(SyrahBook *)initWithNewBookID:(NSString *)ID newBookCate:(NSString *)category newBookTit:(NSString *)title newBookPress:(NSString *)press newBookYear:(int)year newBookAut:(NSString *)author newBookPrice:(float)price totalNum:(int)bookNum;


//-(int)bookBorrow:(int)borrowNum;

-(BOOL)isBookAlreadyExistingInLibrary:(NSString *)bookID;

-(int)insertIntoLibrary;

-(NSString *)getBookID;

-(NSString *)getBookTitle;

-(NSString *)getAuthor;

-(NSString *)getPress;

-(int)getPubYear;

-(int)getBookNum;



@end
