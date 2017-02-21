//
//  JwDataService.h
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwServiceBase.h"
#import "JwServiceDefine.h"
@class JwCompanys;
@class WHorganization;
@class WHhotcompany;
@class WHgetproduct;
@class WHgetuseinfo;
@class WHcompanyDetail;
@class WHhospital;
@class WHget_product_detail;
@class WHget_user_realtion;
@class WHget_relation_detail;
@class WHgetmessage;
@class WHgetrec;
@class WHgetmessageDetall;
@class WHgetintroduce;
@class WHgethonor;
@class WHmicro;
@class WHgetprofirst;
@class WHgetappcate;
@class WHgetproperiod;
@class WHgetcharacters;
@class WHget_pro_rate;
@class WHgetreport;
@class WHgetpolicys;
@class WHgetnearagent;
@class WHgetfollowList;
@class WHproductList;
@class WHmin;
@class WHgetnewsdetail;
@class WHgetvited;
@class WHgetcash;
@interface JwDataService : JwServiceBase



//获取公司列表
- (void)get_CompanysWithType:(NSString *)type
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//获取分支机构列表

-(void)get_OrganizationWithCom_id:(NSString *)com_id
                        city_name:(NSString *)city_name
                         province:(NSString *)province
                             city:(NSString *)city
                           county:(NSString *)county
                             
                          success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//热门公司列表
-(void)get_hot_companyWithsuccess:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;


//找险种列表

-(void)get_productWithCompany_id:(NSString *)company_id
                         keyword:(NSString *)keyword
                             sex:(NSString *)sex
            characters_insurance:(NSString *)characters_insurance
                          period:(NSString *)period
                         cate_id:(NSString *)cate_id
                      pay_period:(NSString *)pay_period
                            rate:(NSString *)rate
                         insured:(NSString *)insured
                        birthday:(NSString *)birthday
                   yearly_income:(NSString *)yearly_income
                            debt:(NSString *)debt
                         rela_id:(NSString *)rela_id
                               p:(NSString *)p
                        pagesize:(NSString *)pagesize
success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//获取用户信息
-(void)get_user_infoWithUid:(NSString *)uid
                    success:(void (^)(NSArray * lists))success failure:(void (^)(NSError * error))failure;


//公司详情列表
-(void)get_company_detailWithCom_id:(NSString * )com_id
                                uid:(NSString *)uid
success:(void (^)(NSArray * list))success failure:(void (^)(NSError *error))failure;

//医院列表第一次获取
-(void)get_hospitalWithlat:(NSString *)lat
                       lng:(NSString *)lng
                  province:(NSString *)province
                      city:(NSString *)city
                    county:(NSString *)county
                  distance:(NSString *)distance
                       map:(NSString *)map
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
                      success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;


//险种详情
-(void)get_product_detailWithPro_id:(NSString * )pro_id
                                uid:(NSString * )uid
                            success:(void (^)(WHget_product_detail * userInfo))success failure:(void (^)(NSError *error))failure;



//获取用户关系成员接口列表
-(void)get_user_realtionWithUid:(NSString *)uid
                        success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;


//获取关系人详情
-(void)get_relation_detailWithId :(NSString *)ids

                          success:(void (^)(WHget_relation_detail * userInfo))success failure:(void (^)(NSError *error))failure;
//获取留言列表
-(void)getmessageWithRes_uid :(NSString *)res_uid
                          uid:(NSString *)uid
                            p:(NSString *)p
                    pagesize :(NSString *)pagesize
  success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;

//推荐险种列表
-(void)getrecWithAgent_uid:(NSString *)agent_uid
                       uid:(NSString *)uid
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure;

//留言详情接口
-(void)getmessagedetailWithId:(NSString *)ids
                        uid:(NSString * )uid
  success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//获取个人介绍
-(void)getintroduceWithUid:(NSString *)uid

 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//荣誉列表
-(void)gethonorWithUid:(NSString * )uid
               success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;



//代理人个人微站
-(void)getMicroWithAgent_uid:(NSString *)agent_uid uid:(NSString *)uid
                     success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//找险种搜索首页数据
-(void)getprofirstWithUid:(NSString * )uid
                   success:(void (^)(WHgetprofirst *profirst))success failure:(void (^)(NSError *error))failure;

//找险种高级搜索分类

-(void)getappcateWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//保障期间
-(void)getproperiodWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;



//险种特色保障
-(void)getcharactersWithsuccess:(void(^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//体检险种费率数据结构
-(void)getprorateWithPid:(NSString *)pid
                     uid:(NSString *)uid
                  gender:(NSString *)gender
 success:(void (^)(NSArray * lists, NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict))success failure:(void (^)(NSError *error))failure;


//体检保存
-(void)getsavepolictWithUid:(NSString *)uid
                    rela_id:(NSString *)rela_id
                       pros:(NSString *)pros
success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//保单列表
-(void)getpolicysWithUid:(NSString * )uid
                 rela_id:(NSString *)rela_id
                 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//附近代理人 text

-(void)oneGetnearagentWithLng:(NSString *)lng
                          lat:(NSString *)lat
                    city_name:(NSString *)city_name
                     province:(NSString *)province
                         city:(NSString *)city
                       county:(NSString *)county
                         type:(NSString *)type
                     distance:(NSString *)distance
                          map:(NSString *)map
                           p :(NSString *)p
                     pagesize:(NSString *)pagesize
                      success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
//附近代理人
-(void)getnearagentWithLng:(NSString *)lng
                       lat:(NSString *)lat
                 city_name:(NSString *)city_name
                  province:(NSString *)province
                      city:(NSString *)city
                    county:(NSString *)county
                      type:(NSString *) type
                  distance:(NSString *)distance
                       map:(NSString *)map
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
                   success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//获取发现里边分支机构
-(void)getorganizationWithLng:(NSString *)lng
                          lat:(NSString *)lat
                     distance:(NSString *)distance
                          map:(NSString *)map
                            p:(NSString *)p
                     pagesize:(NSString *)pagesize
                      success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//关注列表
-(void)getfollowWithUid:(NSString *)uid
  success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//收藏险种列表接口
-(void)getcollectWithUid:(NSString *)uid
                    type:(NSString *)type
                 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//收藏公司列表
-(void)getcompanyWithUid:(NSString *)uid
                    type:(NSString *)type
                 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//收藏新闻列表
-(void)getnewsWithUid:(NSString *)uid
                    type:(NSString *)type
                 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//新闻详情接口
-(void)getnewsdetailWithNews_id:(NSString *)news_id
 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//附近代理人刷新选择三级省市区
-(void)getprovinceWithProvince:(NSString *)province
                          city:(NSString *)city
                        county:(NSString *)county
                        com_id:(NSString *)com_id
                         type :(NSString *)type
                      distance:(NSString *)distance
                           map:(NSString *)map
                       success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;
//刷新分支机构代理人
-(void)getorgProvinceWithProvince:(NSString * )province
                          city:(NSString *)city
                        county:(NSString *)county
                        com_id:(NSString *)com_id
                      distance:(NSString *)distance
                          map :(NSString *)map
 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;


//获取高级搜索筛选
-(void)powsearchProductWithcompany_id:(NSString *)company_id
                              keyword:(NSString *)keyword
                                  sex:(NSString *)sex
                                  age:(NSString *)age
                           characters:(NSString *)characters
                               period:(NSString *)period
                              cate_id:(NSString *)care_id
                           pay_period:(NSString *)pay_period
                                    p:(NSString *)p
                             pagesize:(NSString *)pagesize
                              success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//刷新医院接口数据
-(void)gethospitalWithCom_id:(NSString *)com_id
                    province:(NSString *)province
                        city:(NSString *)city
                      county:(NSString * )county
                    distance:(NSString *)distance
                         map:(NSString *)map
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//体检报告合并
-(void)getreportWithPolicyid:(NSString *)policy_id
                         uid:(NSString *)uid

                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;
//新公司列表接口
-(void)getprocomWithIshasrate:(NSString *)is_has_rate
 success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure;

//新体检险种接口数据列表

-(void)getpolicyprosWithCompany_id:(NSString *)company_id
                           keyword:(NSString *)keyword
                               uid:(NSString *)uid
                                 p:(NSString *)p
                          pagesize:(NSString *)pagesize
 success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;
//账户
-(void)getinvitedWithInvited_uid:(NSString *)invited_uid
                               p:(NSString *)p
                        pagesize:(NSString *)pagesize
                             uid:(NSString *)uid
                         success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;
//提现信息
-(void)getcashWithUid:(NSString *)uid
           finance_id:(NSString *)finance_id
success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *error))failure;

//财务记录
-(void)caiwujiluWithInvited_uid:(NSString *)p
                       pagesize:(NSString *)pagesize
                           uid :(NSString *)uid
                        success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;
@end
