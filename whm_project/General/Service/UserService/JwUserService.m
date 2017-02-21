//
//  JwUserService.m
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwUserService.h"
#import "JwUserCenter.h"
#import "JwUser.h"
#import "JwAreass.h"
#import "MacroUtility.h"

@implementation JwUserService

//登录接口
- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"mobile": mobile,
                                    @"pwd": password} mutableCopy];
    param = [[self filterParam:param interface:@"kb/login"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/login" success:^(id data)
    {
        NSArray *infos = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:[infos firstObject] error:nil];
        [JwUserCenter sharedCenter].user = user;
        [JwUserCenter sharedCenter].isLogined = YES;
        [[JwUserCenter sharedCenter] save];
        
        [WBYRequest  showMessage:user.info];

        NSUserDefaults * stand = [NSUserDefaults standardUserDefaults];
        [stand setObject:user.name forKey:@"xingming"];
        [stand setObject:user.company forKey:@"gongsi"];
        [stand setObject:user.key forKey:MYTOKEN];
        [stand setObject:user.uid forKey:MYUID];
        
        [stand synchronize];
        if (success)
        {
            success(user);
        }
    } failure:^(NSError *error)
    {
        if (failure) {
            failure(error);
        }
    }];
}

//用户或代理人注册
- (void)registWithName:(NSString *)name
          mobile:(NSString *)mobile
         captcha:(NSString *)captcha
             pwd:(NSString *)pwd
            type:(NSString *)type
      company_id:(NSString *)company_id
          org_id:(NSString *)org_id
   exhibition_no:(NSString *)exhibition_no
        nickname:(NSString *)nickname
       work_time:(NSString *)work_time
       id_number:(NSString *)id_number
      profession:(NSString *)profession
   specialize_in:(NSString *)specialize_in
         address:(NSString *)address
         success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure
{
    NSMutableDictionary *param = [@{@"name": name,
                                    @"mobile": mobile,
                                    @"captcha": captcha,
                                    @"pwd": pwd,
                                    @"type": type} mutableCopy];
    if ([type isEqualToString:@"1"])
    {
        param[@"company_id"] = company_id;
        param[@"org_id"] = org_id;
        param[@"exhibition_no"] = exhibition_no;
        param[@"nickname"] = nickname;
        param[@"id_number"] = id_number;
        if (work_time)
        {
            param[@"work_time"] = work_time;
        }
        if (profession) {
            param[@"profession"] = profession;
        }
        if (specialize_in) {
            param[@"specialize_in"] = specialize_in;
        }
        if (address) {
            param[@"address"] = address;
        }
    }
    
    param = [[self filterParam:param interface:@"kb/regist"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/regist" success:^(id data) {
        
        NSDictionary *info = data[@"data"];
        JwUser *user = [[JwUser alloc] initWithDictionary:info error:nil];
        
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//退出登录
- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure
{
    
    NSMutableDictionary *param = [@{@"uid": [JwUserCenter sharedCenter].uid} mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/logout"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/logout" success:^(id data) {
        
        [JwUserCenter sharedCenter].user = nil;
        [JwUserCenter sharedCenter].isLogined = NO;
        [[JwUserCenter sharedCenter] save];
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//忘记密码
-(void)forgetwordWithMobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                        pwd:(NSString *)pwd
                    success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"mobile":mobile,
                                     @"captcha":captcha,
                                     @"pwd":pwd} mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/reset_pwd"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/reset_pwd" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//发送短信
-(void)sendsmsWithMobile:(NSString *)mobile
                    type:(NSString *)type
            check_mobile:(NSString *)check_mobile
                 success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"mobile":mobile,
                                     @"type":type,
                                     @"check_mobile":check_mobile
                                     } mutableCopy];
    param = [[self filterParam:param interface:@"kb/send_sms"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/send_sms" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}

//修改密码
-(void)updatepwdUid:(NSString *)uid
            old_pwd:(NSString *)old_pwd
                pwd:(NSString *)pwd
            success:(void (^)())success failure:(void (^)(NSError *))failure{
    
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"old_pwd":old_pwd,
                                     @"pwd":pwd,
                                     @"token":[JwUserCenter sharedCenter].key
                                     } mutableCopy];
    param = [[self filterParam:param interface:@"kbj/update_pwd"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/update_pwd" success:^(id data) {

        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
//保存用户信息

-(void)save_userWithUid:(NSString *)uid
                 avatar:(NSString *)avatar
                   name:(NSString *)name
                    sex:(NSString *)sex
               birthday:(NSString *)birthday
              area_info:(NSString *)area_info
           area_info_id:(NSString *)area_info_id
                address:(NSString *)address
                success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid ,
                              @"avatar":avatar ,
                              @"name":name ,
                              @"sex":sex ,
                              @"birthday":birthday,
                              @"area_info":area_info ,
                              @"area_info_id":area_info_id,
                              @"address":address,
                              @"token":[JwUserCenter sharedCenter].key
                              }mutableCopy];
    
    param = [[self filterParam:param interface:@"kbj/save_user"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/save_user" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}


//修改手机号
-(void)update_mobileWithUid:(NSString *)uid
                     mobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                    success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"mobile":mobile,
                              @"captcha":captcha,
                              @"token":[JwUserCenter sharedCenter].key}
                            mutableCopy];
    param = [[self filterParam:param interface:@"kbj/update_mobile"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/update_mobile" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//保存用户关系成员接口
-(void)save_user_realtionWithUid:(NSString *)uid
                              id:(NSString *)ids
                            name:(NSString *)name
                          avatar:(NSString *)avatar
                             sex:(NSString *)sex
                        birthday:(NSString *)birthday
                        relation:(NSString *)relation
                   yearly_income:(NSString *)yearly_income
                      yearly_out:(NSString *)yearly_out
                            debt:(NSString *)debt
                         success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"id":ids,
                              @"name":name,
                              @"avatar":avatar,
                              @"sex":sex,
                              @"birthday":birthday,
                              @"relation":relation,
                              @"yearly_income":yearly_income,
                              @"yearly_out":yearly_out,
                              @"debt":debt,
                              @"token":[JwUserCenter sharedCenter].key}
                            mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_user_realtion"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/save_user_realtion" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}

//删除联系人
-(void)del_relationWithId:(NSString *)ids
                  success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"id":ids,
                                     @"token":[JwUserCenter sharedCenter].key}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_relation"]mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/del_relation" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
//获取地区
-(void)get_all_areaWithsuccess:(void (^)(NSArray *areas))success failure:(void (^)(NSError *error))failure
{
   
    NSMutableDictionary * param = [@{} mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/get_all_area"] mutableCopy];

    [self.httpManager POST:param withPoint:@"kb/get_all_area" success:^(id data)
    {
        
        NSArray *infos = data[@"data"];
        NSArray *areas = [JwAreass arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(areas);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//保存个人介绍

-(void)save_introduceWithUid:(NSString *)uid
                   introduce:(NSString *)introduce
                     success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"introduce":introduce,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_introduce"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_introduce" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//删除留言回复
-(void)delmessageWithId:(NSString *)ids
                    uid:(NSString *)uid
                success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"id":ids,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_message"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_message" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

//保存留言
-(void)savemessageWithReq_uid:(NSString *)req_uid
                      res_uid:(NSString *)res_uid
                          uid:(NSString *)uid
                      message:(NSString *)message
                   message_id:(NSString *)message_id
                    city_name:(NSString *)city_name
                     req_name:(NSString *)req_name
                      success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"req_uid":[JwUserCenter sharedCenter].uid,
                                     @"res_uid":res_uid,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"message":message,
                                     @"message_id":message_id,
                                     @"city_name":city_name,
                                     @"req_name":req_name,
                                     @"token":[JwUserCenter sharedCenter].key }mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_message"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_message" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}

//保存荣誉接口
-(void)savehonorWithUid:(NSString *)uid
                    img:(NSString *)img
                success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"img":img,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_honor"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_honor" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//删除荣誉
-(void)delhonorWithId:(NSString *)ids
                  uid:(NSString *)uid success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"id":ids,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_honor"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_honor" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//保存完善的保单信息

-(void)updatePolicyWithId:(NSString *)ids
                      uid:(NSString *)uid
                    sn_no:(NSString *)sn_no
               start_date:(NSString *)start_date
                   holder:(NSString *)holder
              beneficiary:(NSString *)beneficiary
                  success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"id":ids,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"sn_no":sn_no,
                                     @"start_date":start_date,
                                     @"holder":holder ,
                                     @"beneficiary":beneficiary,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/update_only_policy"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/update_only_policy" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//删除保单
-(void)delpolicyWithPolicy_id:(NSString *)policy_id
                          uid:(NSString *)uid
                      success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"policy_id":policy_id,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_policy"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_policy" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//获取关注接口
-(void)getsaveFollowWithUid:(NSString *)uid
                  agent_uid:(NSString *)agent_uid
                    success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"agent_uid":agent_uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_follow"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_follow" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

      
}

//取消关注
-(void)delfollowWithID:(NSString *)ids
                   uid:(NSString *)uid
               success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"id":ids,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_follow"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_follow" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    

    
}
//取消关注与关注
-(void)followWithUid:(NSString *)uid
           agent_uid:(NSString *)agent_uid
             success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"agent_uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/follow"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/follow" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

}
//收藏和取消收藏
-(void)collectWithUid:(NSString *)uid
              type_id:(NSString *)type_id
                 type:(NSString *)type
              success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"type_id":type_id,
                              @"type":type,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/collect"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/collect" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//单个取消收藏接口
-(void)delcollectWithUid:(NSString *)uid
                 type_id:(NSString *)type_id
                    type:(NSString *)type
                success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"type_id":type_id,
                              @"type":type,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_collecti"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_collecti" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
//保存推荐险种
-(void)seaverecWithPids:(NSString *)pids
                    uid:(NSString *)uid success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"pids":pids,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_rec"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_rec" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
//取消推荐险种接口
-(void)delrecWithUid:(NSString *)uid
                 pid:(NSString *)pid
             success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"pid":pid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/del_rec"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/del_rec" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}
////保存认证信息

-(void)save_verifyWithUid:(NSString *)uid
                  company:(NSString *)company
                     name:(NSString *)name
               cardnumber:(NSString *)cardnumber
       organizationnumber:(NSString *)organizationnumber
                    point:(NSString *)point
                  address:(NSString *)address
                      job:(NSString *)job
                  success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"company":company,
                              @"name":name,
                              @"cardnumber":cardnumber,
                              @"organizationnumber":organizationnumber ,
                              @"point":point,
                              @"address":address,
                              @"job":job,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_verify"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_verify" success:^(id data) {
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}


//提现
-(void)tixianWithUid:(NSString *)uid money:(NSString *)money name:(NSString *)name card_num:(NSString *)card_num bank:(NSString *)bank success:(void (^)())success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"money":money,
                                     @"name":name,
                                     @"card_num":card_num,
                                     @"bank":bank,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/extract_cash"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/extract_cash" success:^(id data) {
        
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
