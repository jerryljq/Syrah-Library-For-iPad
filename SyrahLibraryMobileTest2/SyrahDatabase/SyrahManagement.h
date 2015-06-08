//
//  SyrahManagement.h
//  SyrahLibraryAlpha1
//
//  Created by Jerry Lee on 15/4/2.
//  Copyright (c) 2015年 Jerry's Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRDatabase.h"

@interface SyrahManagement : NSObject {
    
    NSString *managerID;
    NSString *managerName;
    NSString *managerPasswd;
    NSString *managerContact;
    NSString *managerWorkPlace;
    NSString *inviteCode;
}

-(void)manRegID:(NSString *)ID manRegName:(NSString *)name manRegPass:(NSString *)pass manRegCont:(NSString *)contact manWorkPlace:(NSString *)workPlace manInviteCode:(NSString *)code;

-(int)insertMan;

-(NSString *)getAdminName;

-(NSString *)getAdminPass;

-(BOOL)isManAlreadyExistingInDataBase;

-(NSString *)getAdminWork;
-(NSString *)getAdminContact;
-(NSString *)getRealName;

@end
