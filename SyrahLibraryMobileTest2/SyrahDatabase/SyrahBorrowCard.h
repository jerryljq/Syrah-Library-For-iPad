//
//  SyrahBorrowCard.h
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SyrahBorrowCard : NSObject {
    
    NSString *cardID;
    NSString *cardUserName;
    NSString *cardUserPass;
    NSString *cardUserContact;
    NSString *cardUserWork; //工作单位
    
}

-(void)newCardID:(NSString *)ID newCardUserName:(NSString *)userName newCardPass:(NSString *)pass newWord:(NSString *)work newCardUserContact:(NSString *)contact;

-(BOOL)deleteCard:(NSString *)cardID;

-(NSString *)getUserID;

-(NSString *)gerUserPass;

-(NSString *)getUserName;

-(NSString *)getUserContact;

-(NSString *)getUserWork;
@end
