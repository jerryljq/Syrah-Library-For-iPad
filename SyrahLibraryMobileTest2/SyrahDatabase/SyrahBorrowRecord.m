//
//  SyrahBorrowRecord.m
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "SyrahBorrowRecord.h"

@implementation SyrahBorrowRecord


-(void)RecordID:(int)recordId BorrowCardID:(NSString *)cardId andBorrowBookId:(NSString *)bookId andBorrowLength:(int)length andStartDate:(NSString *)startDate andEndDate:(NSString *)endDate {
    recordID = recordId;
        cardID = cardId;
        bookID = bookId;
        borrowLength = length;
        borrowDate = startDate;
        returnDate = endDate;
}

-(int)getRecordID {
    return recordID;
}

-(NSString *)getCardID {
    return cardID;
}

-(NSString *)getBookID {
    return bookID;
}

-(int)getLength {
    return borrowLength;
}

-(NSString *)getBorrowDate {
    return borrowDate;
}

-(NSString *)getReturnDate{
    return returnDate;
}

@end
