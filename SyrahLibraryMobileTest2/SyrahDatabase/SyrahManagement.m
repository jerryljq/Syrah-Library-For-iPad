//
//  SyrahManagement.m
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//


/*
 NSString *managerID;
 NSString *managerName;
 NSString *managerPasswd;
 NSString *managerContact;
 NSString *managerWorkPlace;
 NSString *inviteCode;
 */
#import "SyrahManagement.h"

@implementation SyrahManagement

-(void)manRegID:(NSString *)ID manRegName:(NSString *)name manRegPass:(NSString *)pass manRegCont:(NSString *)contact manWorkPlace:(NSString *)workPlace manInviteCode:(NSString *)code {
    
    managerID = ID;
    managerName = name;
    managerPasswd = pass;
    managerContact = contact;
    managerWorkPlace = workPlace;
    inviteCode = code;
    
}

-(BOOL)isManAlreadyExistingInDataBase {
    
    return false;
}

-(NSString *)getAdminName {
    return managerID;
}

-(NSString *)getRealName {
    return managerName;
}

-(NSString *)getAdminPass {
    return managerPasswd;
}

-(NSString *)getAdminWork {
    return managerWorkPlace;
}

-(NSString *)getAdminContact {
    return managerContact;
}

-(int)insertMan {
    
    SRDatabase *db = [[SRDatabase alloc] init];
    [db openDB];
    
    
    
    return 0;
}



@end
