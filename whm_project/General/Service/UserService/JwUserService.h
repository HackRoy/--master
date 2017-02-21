//
//  JwUserService.h
//  e-bank
//
//  Created by chenJw on 16/9/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"

@class JwUser;
@class JwAreass;

@interface JwUserService : JwServiceBase

//登录接口
- (void)loginWithMobile:(NSString *)mobile
               password:(NSString *)password
                success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure;

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
               success:(void (^)(JwUser *user))success failure:(void (^)(NSError *error))failure;

//退出登录
- (void)logoutWithSuccess:(void (^)())success failure:(void (^)(NSError *error))failure;

//忘记密码
-(void)forgetwordWithMobile:(NSString *)mobile
                    captcha:(NSString *)captcha
                        pwd:(NSString *)pwd
                    success:(void (^)())success failure:(void (^)(NSError *error))failure;

//发送短信
-(void)sendsmsWithMobile:(NSString *)mobile
                    type:(NSString *)type
            check_mobile:(NSString *)check_mobile
                 success:(void (^)())success failure:(void (^)(NSError *error))failure;

//修改密码
-(void)updatepwdUid:(NSString *)uid
            old_pwd:(NSString *)old_pwd
                pwd:(NSString *)pwd
            success:(void (^)())success failure:(void (^)(NSError *error))failure;



//保存用户信息
-(void)save_userWithUid:(NSString *)uid
                 avatar:(NSString *)avatar
                   name:(NSString *)name
                    sex:(NSString *)sex
               birthday:(NSString *)birthday
              area_info:(NSString *)area_info
           area_info_id:(NSString *)area_info_id
               address :(NSString *)address
   success:(void (^)())success failure:(void (^)(NSError *error))failure;



//
//修改手机号
-(void)update_mobileWithUid:(NSString *)uid
                     mobile:(NSString *)mobile
                    captcha:(NSString *)captcha
             success:(void (^)())success failure:(void (^)(NSError *error))failure;




//保存用户关系成员接口
-(void)save_user_realtionWithUid:(NSString *)uid
                              id:(NSString * )ids
                            name:(NSString *)name
                          avatar:(NSString *)avatar
                             sex:(NSString *)sex
                        birthday:(NSString *)birthday
                        relation:(NSString *)relation
                   yearly_income:(NSString *)yearly_income
                      yearly_out:(NSString *)yearly_out
                            debt:(NSString *)debt

                         success:(void (^)())success failure:(void (^)(NSError *error))failure;


//删除关系人
-(void)del_relationWithId:(NSString *)ids
                  success:(void (^)())success failure:(void (^)(NSError *error))failure;

//获取地区

-(void)get_all_areaWithsuccess:(void (^)(NSArray *areas))success failure:(void (^)(NSError *error))failure;


//保存个人介绍
-(void)save_introduceWithUid:(NSString *)uid
                   introduce:(NSString *)introduce
 success:(void (^)())success failure:(void (^)(NSError *error))failure;



//删除留言回复

-(void)delmessageWithId:(NSString * )ids
                    uid:(NSString *)uid
                success:(void(^)())success failure:(void(^)(NSError *error))failure;




//保存留言
-(void)savemessageWithReq_uid:(NSString *)req_uid
                      res_uid:(NSString *)res_uid
                          uid:(NSString *)uid
                      message:(NSString *)message
                   message_id:(NSString *)message_id
                    city_name:(NSString *)city_name
                     req_name:(NSString *)req_name
success:(void(^)())success failure:(void(^)(NSError *error))failure;
    


//保存荣誉接口
-(void)savehonorWithUid:(NSString *)uid img:(NSString *)img
                success:(void(^)())success failure:(void(^)(NSError * error))failure;


//删除荣誉
-(void)delhonorWithId:(NSString * )ids
                  uid:(NSString * )uid

              success:(void(^)())success failure:(void(^)(NSError * error))failure;



//保存完善的保单信息
-(void)updatePolicyWithId:(NSString *)ids
                      uid:(NSString *)uid
                    sn_no:(NSString *)sn_no
               start_date:(NSString *)start_date
                holder:(NSString *)holder
              beneficiary:(NSString *)beneficiary
                  success:(void(^)())success failure:(void(^)(NSError * error))failure;

//删除保单
-(void)delpolicyWithPolicy_id:(NSString *)policy_id
                          uid:(NSString *)uid
                      success:(void(^)())success failure:(void(^)(NSError * error))failure;


//获取关注接口
-(void)getsaveFollowWithUid:(NSString * )uid agent_uid:(NSString * )agent_uid
                    success:(void(^)())success failure:(void(^)(NSError * error))failure;


//取消关注
-(void)delfollowWithID:(NSString * )ids
                   uid:(NSString *)uid
              success:(void(^)())success failure:(void(^)(NSError * error))failure;

//取消关注与关注
-(void)followWithUid:(NSString *)uid
           agent_uid:(NSString *)agent_uid
             success:(void(^)())success failure:(void(^)(NSError * error))failure;
//收藏和取消收藏
-(void)collectWithUid:(NSString *)uid
              type_id:(NSString *)type_id
                 type:(NSString *)type
  success:(void(^)())success failure:(void(^)(NSError * error))failure;


//单个取消收藏接口
-(void)delcollectWithUid:(NSString *)uid
                 type_id:(NSString *)type_id
                    type:(NSString *)type
                success:(void(^)())success failure:(void(^)(NSError * error))failure;


//保存推荐险种
-(void)seaverecWithPids:(NSString *)pids
                    uid:(NSString * )uid
                success:(void(^)())success failure:(void(^)(NSError * error))failure;

//取消推荐险种接口
-(void)delrecWithUid:(NSString * )uid
                 pid:(NSString *)pid
             success:(void(^)())success failure:(void(^)(NSError * error))failure;


//保存认证信息
-(void)save_verifyWithUid:(NSString *)uid
                  company:(NSString *)company
                     name:(NSString *)name
               cardnumber:(NSString *)cardnumber
       organizationnumber:(NSString *)organizationnumber
                    point:(NSString *)point
                  address:(NSString *)address
                      job:(NSString *)job
                  success:(void (^)())success failure:(void (^)(NSError *error))failure;

//tixian
-(void)tixianWithUid:(NSString *)uid
               money:(NSString *)money
                name:(NSString *)name
            card_num:(NSString *)card_num
                bank:(NSString *)bank
             success:(void (^)())success failure:(void (^)(NSError *error))failure;




@end
