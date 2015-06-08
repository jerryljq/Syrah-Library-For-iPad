//
//  SyrahBorrowRecord.h
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyrahBorrowRecord : NSObject {
    
    int recordID;
    NSString *cardID;
    NSString *bookID;
    int borrowLength;
    NSString *borrowDate;
    NSString *returnDate;
    
}

-(void)RecordID:(int)recordId BorrowCardID:(NSString *)cardId andBorrowBookId:(NSString *)bookId andBorrowLength:(int)length andStartDate:(NSString *)startDate andEndDate:(NSString *)endDate;

-(NSString *)getBookID;

-(int)getRecordID;

-(NSString *)getCardID;

-(NSString *)getBookID;

-(int)getLength;

-(NSString *)getBorrowDate;

-(NSString *)getReturnDate;


@end
