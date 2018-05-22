//
//  AuthHistoryDTO.h
//  VSProject
//
//  Created by 陈 海涛 on 16/9/26.
//  Copyright © 2016年 user. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthHistoryDTO : NSObject
@property (nonatomic,strong) NSString* status  ; //	申请状态	UNRESOLVED：待认证，PASS：已通过， REJECT：已拒绝
@property (nonatomic,strong) NSString* processTime; //	处理时间
@property (nonatomic,strong) NSString* rejectReason;//	拒绝理由
@property (nonatomic,strong) NSString* applyTime;//	申请时间
@property (nonatomic,strong) NSString* enterpriseName;//	企业名称
@property (nonatomic,strong) NSString* enterpriseLegalPerson;//	法人名称
@property (nonatomic,strong) NSString* contactName;//	联系人
@property (nonatomic,strong) NSString* contactNumber;//	联系方式
@property (nonatomic,strong) NSString* enterpriseIdentity;//	企业注册号

@end
