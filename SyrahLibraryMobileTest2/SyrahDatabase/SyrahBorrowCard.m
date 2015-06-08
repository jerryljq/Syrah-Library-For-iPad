//
//  SyrahBorrowCard.m
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import "SyrahBorrowCard.h"

@implementation SyrahBorrowCard

-(void)newCardID:(NSString *)ID newCardUserName:(NSString *)userName newCardPass:(NSString *)pass newWord:(NSString *)work newCardUserContact:(NSString *)contact {
    
    cardID = ID;
    cardUserName = userName;
    cardUserPass = pass;
    cardUserContact = contact;
    cardUserWork = work;
    
}

-(NSString *)getUserID {
    return cardID;
}

-(NSString *)gerUserPass {
    return cardUserPass;
}

-(NSString *)getUserName {
    return cardUserName;
}

-(NSString *)getUserContact {
    return cardUserContact;
}

-(NSString *)getUserWork {
    return cardUserWork;
}

@end
