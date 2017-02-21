//
//  JwDataService.m
//  e-bank
//
//  Created by chenJw on 16/10/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwDataService.h"
#import "JwCompanys.h"
#import "WHorganization.h"
#import "WHhotcompany.h"
#import "WHgetproduct.h"
#import "WHgetuseinfo.h"
#import "WHcompanyDetail.h"
#import "WHhospital.h"
#import "WHget_product_detail.h"
#import "WHget_user_realtion.h"
#import "WHget_relation_detail.h"
#import "WHgetmessage.h"
#import "WHgetrec.h"
#import "WHgetmessageDetall.h"
#import "WHgetintroduce.h"
#import "WHgethonor.h"
#import "WHmicro.h"
#import "WHgetprofirst.h"
#import "WHgetappcate.h"
#import "WHgetproperiod.h"
#import "WHgetcharacters.h"
#import "WHget_pro_rate.h"
#import "WHgetreport.h"
#import "WHgetpolicys.h"
#import "WHgetnearagent.h"
#import "WHproductList.h"
#import "WHgetnewsdetail.h"
#import "WHmin.h"
#import "WHgetfollowList.h"
#import "WHgetvited.h"
#import "WHgetcash.h"

#import "MacroUtility.h"
#import "JwUserCenter.h"
#import "JwUser.h"
#import "JGProgressHelper.h"

@implementation JwDataService

//获取公司列表
- (void)get_CompanysWithType:(NSString *)type
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [@{@"type": type.length >=1?type:@""} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_companys"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_companys" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *companys = [JwCompanys arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(companys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//获取分支机构列表
-(void)get_OrganizationWithCom_id:(NSString *)com_id
                        city_name:(NSString *)city_name
                         province:(NSString *)province
                             city:(NSString *)city
                           county:(NSString *)county

                          success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id.length>=1?com_id:@"",
                                    @"city_name":city_name,
                                    @"province":province,
                                    @"city":city,
                                    @"county":county 
                                     }mutableCopy];
    param =[[self filterParam:param interface:@"kb/get_organization"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_organization" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *organs = [WHorganization arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (organs);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }

    }];
  
    
}
//获取热门公司
-(void)get_hot_companyWithsuccess:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_hot_company"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_hot_company" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *hotcompanys = [WHhotcompany arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (hotcompanys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
    
}
//获取险种列表
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
                         success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"company_id":company_id,
                                     @"keyword":keyword ,
                                     @"sex":sex,
                                     @"characters_insurance":characters_insurance,
                                     @"period":period,
                                     @"cate_id":cate_id,
                                     @"pay_period":pay_period,
                                     @"rate":rate,
                                     @"insured":insured,
                                     @"birthday":birthday,
                                     @"yearly_income":yearly_income,
                                     @"debt":debt,
                                     @"rela_id":rela_id,
                                     @"p":p,
                                     @"pagesize":pagesize
                                     }mutableCopy];
     param = [[self filterParam:param interface:@"kb/get_product"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_product" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *products = [WHgetproduct arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success)
        {
            success(products);
        }
    } failure:^(NSError *error)
     {
        if (failure) {
            failure(error);
        }
    }];

    
}

//获取用户信息
-(void)get_user_infoWithUid:(NSString *)uid
                    success:(void (^)(NSArray * lists))success failure:(void (^)(NSError * error))failure
{
    NSMutableDictionary *param = [@{@"uid":[JwUserCenter sharedCenter].uid?[JwUserCenter sharedCenter].uid:@"",
                                    @"token":[JwUserCenter sharedCenter].key?[JwUserCenter sharedCenter].key:@""}
                                  mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_user_info"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_user_info" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *userinfos = [WHgetuseinfo arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(userinfos);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
//公司详情
-(void)get_company_detailWithCom_id:(NSString *)com_id
                                uid:(NSString *)uid
                            success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_company_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_company_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
       NSArray *companydetals = [WHcompanyDetail  arrayOfModelsFromDictionaries:infos error:nil];
      if (success) {
            success(companydetals);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//医院列表数据
-(void)get_hospitalWithlat:(NSString *)lat
                       lng:(NSString *)lng
                  province:(NSString *)province
                      city:(NSString *)city
                    county:(NSString *)county
                  distance:(NSString *)distance
                       map:(NSString *)map
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
                   success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"lat":lat,
                                     @"lng":lng,
                                     @"province":province ,
                                     @"city":city ,
                                     @"county":county,
                                     @"distance":distance,
                                     @"p":p,
                                     @"pagesize":pagesize,
                                     @"map":map}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_hospital"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_hospital" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *hospitals = [WHhospital arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(hospitals);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//险种详情
-(void)get_product_detailWithPro_id:(NSString *)pro_id
                                uid:(NSString *)uid
                            success:(void (^)(WHget_product_detail * userInfo ))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"pro_id":pro_id,
                                     @"uid":[JwUserCenter sharedCenter].uid}
                                   mutableCopy];
    
    param = [[self filterParam:param interface:@"kb/get_product_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_product_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        WHget_product_detail *productdetails = [[WHget_product_detail  alloc]initWithDictionary:[infos firstObject] error:nil];
        
        if (success) {
            success(productdetails);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//获取用户关系成员接口列表
-(void)get_user_realtionWithUid:(NSString *)uid
                        success:(void (^)(NSArray * lists ))success failure:(void (^)(NSError *))failure
{
    if ([JwUserCenter sharedCenter].uid != nil)
    {
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}
                                   mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_user_realtion"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_user_realtion" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *user_realtions = [WHget_user_realtion arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(user_realtions);
            NSLog(@"%@",user_realtions);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];
    
    }
    else
    {
        [JGProgressHelper showError:@"请登录账号"];
    }
    
    
}

//获取关系人详情
-(void)get_relation_detailWithId:(NSString *)ids
                         success:(void (^)(WHget_relation_detail * userInfo))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param =[@{@"id":ids,
                                    @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_relation_detail"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_relation_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
       WHget_relation_detail *relation_detail = [[WHget_relation_detail alloc]initWithDictionary:[infos firstObject] error:nil];
        if (success) {
            success(relation_detail);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
    
}
//获取留言列表
-(void)getmessageWithRes_uid:(NSString *)res_uid
                         uid:(NSString *)uid
                           p:(NSString *)p
                    pagesize:(NSString *)pagesize
                     success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"res_uid":[JwUserCenter sharedCenter].uid,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"p":p,
                              @"pagesize":pagesize,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_messages"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_messages" success:^(id data) {
        NSArray * infos = data[@"data"];
        NSArray * getmessages = [WHgetmessage arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(getmessages);
            //NSLog(@"%@",getmessages);
        }
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
    

}

//获取推荐险种列表
-(void)getrecWithAgent_uid:(NSString *)agent_uid
                       uid:(NSString *)uid
                         p:(NSString *)p
                  pagesize:(NSString *)pagesize
                   success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
      NSMutableDictionary *param = [@{@"agent_uid": [JwUserCenter sharedCenter].uid,
                                      @"uid":[JwUserCenter sharedCenter].uid,
                                      @"p":p,
                                      @"pagesize":pagesize,
                                      @"token":[JwUserCenter sharedCenter].key} mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_rec"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_rec" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *getrecs = [WHgetrec arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(getrecs);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}


//留言详情
-(void)getmessagedetailWithId:(NSString *)ids uid:(NSString *)uid success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"id":ids,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_message_detail"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_message_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *mesdetals = [WHgetmessageDetall  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(mesdetals);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//获取个人介绍内容
-(void)getintroduceWithUid:(NSString *)uid success:(void (^)(NSArray *lists))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_introduce"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_introduce" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *introduces = [WHgetintroduce  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(introduces);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
    
}


//获取荣誉
-(void)gethonorWithUid:(NSString *)uid
               success:(void (^)(NSArray * lists))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_honor"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_honor" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *honors= [WHgethonor arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(honors);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//获取代理人个人微站
-(void)getMicroWithAgent_uid:(NSString *)agent_uid
                         uid:(NSString *)uid
                     success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"agent_uid":agent_uid,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/micro"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/micro" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray * micros = [WHmin arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(micros);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//找险种搜索首页数据
-(void)getprofirstWithUid:(NSString * )uid success:(void (^)(WHgetprofirst *profirst))success failure:(void (^)(NSError *error))failure
{
    if ([JwUserCenter sharedCenter].uid != nil) {
        
    
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_pro_first"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_pro_first" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        WHgetprofirst *pro = [[WHgetprofirst alloc] initWithDictionary:[infos firstObject] error:nil];
        
        if (success) {
            success(pro);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    }
    else
    {
        [JGProgressHelper showError:@"请登录账号"];
    }

    
}

//找险种高级搜索分类
-(void)getappcateWithsuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_app_cate"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_app_cate" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *appcates = [WHgetappcate arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (appcates);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
    

    
    
}
//保障期间
-(void)getproperiodWithsuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_pro_period"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_pro_period" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *periods = [WHgetproperiod arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (periods);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

}

//险种特色保障
-(void)getcharactersWithsuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{} mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_characters"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_characters" success:^(id data) {
        NSArray *infos = data[@"data"];
        NSArray *characters  = [WHgetcharacters arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success (characters);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

}
//体检险种费率数据结构
-(void)getprorateWithPid:(NSString *)pid
                     uid:(NSString *)uid
                  gender:(NSString *)gender
                 success:(void (^)(NSArray * lists,NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"pid":pid,
                                     @"uid":[JwUserCenter sharedCenter].uid,
                                     @"gender":gender,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
      param = [[self filterParam:param interface:@"kbj/get_pro_rate"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_pro_rate" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *bigArr = [infos.firstObject objectForKey:@"mongo_rate"];
        NSArray *moreArr = [bigArr.firstObject objectForKey:@"rate"];
        NSLog(@"%@",data);
        NSMutableArray *mutableArr_pay_period = [NSMutableArray array];
        NSMutableArray *mutableArr_payOut = [NSMutableArray array];
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in moreArr) {
            if ([[dic allKeys] containsObject:@"pay_period"]) {
                [mutableArr_pay_period addObjectsFromArray:((NSDictionary *)[dic objectForKey:@"pay_period"]).allKeys];
//                mutableDict = [NSMutableDictionary dictionaryWithDictionary:((NSDictionary *)[dic objectForKey:@"pay_period"])];
                [mutableDict addEntriesFromDictionary:((NSDictionary *)[dic objectForKey:@"pay_period"])];
            }
            if ([[dic allKeys] containsObject:@"payout"]) {
//                [mutableArr_payOut addObjectsFromArray:[dic objectForKey:@"payout"]];
                [mutableArr_payOut addObject:[dic objectForKey:@"payout"]];
            }
        }
        NSLog(@"%@",mutableDict);
        NSSet *set = [NSSet setWithArray:mutableArr_pay_period];
        NSSet *set1 = [NSSet setWithArray:mutableArr_payOut];
        NSArray *rates = [WHget_pro_rate arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(rates, [set allObjects], [set1 allObjects], mutableDict);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//体检保存
-(void)getsavepolictWithUid:(NSString *)uid
                    rela_id:(NSString *)rela_id
                       pros:(NSString *)pros success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"rela_id":rela_id,
                                     @"pros":pros,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/save_policy"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/save_policy" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *reps = [WHgetreport arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(reps);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
//保单列表
-(void)getpolicysWithUid:(NSString *)uid
                 rela_id:(NSString *)rela_id
                 success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                                     @"rela_id":rela_id,
                                     @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_policys"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_policys" success:^(id data) {
        NSArray * infos = data[@"data"];
        NSArray * policysList = [WHgetpolicys arrayOfModelsFromDictionaries:infos error:nil];
        if (success ) {
            success(policysList);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//附近代理人textturn
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
                   success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"lng":lng ,
                              @"lat":lat ,
                              @"city_name":city_name ,
                              @"province":province ,
                              @"city":city ,
                              @"county":county,
                              @"type":type,
                              @"distance":@"10.00",
                              @"p":p,
                              @"pagesize":pagesize,
                              @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_near_agent"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_near_agent" success:^(id data)
    {
        
        NSArray *infos = data[@"data"];
        
        if (success)
        {
            success(infos);
        }
    } failure:^(NSError *error)
    {
        if (failure) {
            failure(error);
        }
    }];
    
    
}



//附近代理人
-(void)getnearagentWithLng:(NSString *)lng
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
                   success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"lng":lng ,
                              @"lat":lat ,
                              @"city_name":city_name ,
                              @"province":province ,
                              @"city":city ,
                              @"county":county,
                              @"type":type,
                              @"distance":@"10.00",
                              @"p":p,
                              @"pagesize":pagesize,
                              @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_near_agent"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_near_agent" success:^(id data)
    {
        NSArray *infos = data[@"data"];
       // NSArray *nearagents = [WHgetnearagent  arrayOfModelsFromDictionaries:infos error:nil];
        if (success)
        {
            success(infos);
        }
        
        
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
//获取发现里边分支机构
-(void)getorganizationWithLng:(NSString *)lng
                          lat:(NSString *)lat
                     distance:(NSString *)distance
                          map:(NSString *)map
                            p:(NSString *)p
                     pagesize:(NSString *)pagesize
                      success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"lng":lng ,
                              @"lat":lat,
                              @"distance":@"10.00",
                              @"p":p,
                              @"pagesize":pagesize,
                              @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_organization"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_organization" success:^(id data)
    {
        
        NSArray *infos = data[@"data"];
        NSArray *getorgs = [WHorganization  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(getorgs);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}

//关注列表
-(void)getfollowWithUid:(NSString *)uid
                success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_follow"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_follow" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *folllises = [WHgetfollowList arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(folllises);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//收藏险种列表接口
-(void)getcollectWithUid:(NSString *)uid
                    type:(NSString *)type
                 success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"type":type,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_collecti"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_collecti" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *prodlists = [WHproductList  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(prodlists);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}
//收藏公司列表
-(void)getcompanyWithUid:(NSString *)uid
                    type:(NSString *)type success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"type":type,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_collecti"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_collecti" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *prodlists = [WHcompany  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(prodlists);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}


-(void)getnewsWithUid:(NSString *)uid
                 type:(NSString *)type
              success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"type":type,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_collecti"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_collecti" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *prodlists = [WHnews  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(prodlists);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//新闻详情接口
-(void)getnewsdetailWithNews_id:(NSString *)news_id
                        success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"news_id":news_id}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_news_detail"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_news_detail" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray * details = [WHgetnewsdetail arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(details);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//附近代理人刷新选择三级省市区
-(void)getprovinceWithProvince:(NSString *)province
                          city:(NSString *)city
                        county:(NSString *)county
                        com_id:(NSString *)com_id
                         type :(NSString *)type
                      distance:(NSString *)distance
                           map:(NSString *)map
                       success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"province":province,
                              @"city":city,
                              @"county":county,
                              @"com_id":com_id,
                              @"type":type,
                              @"distance":@"10.00",
                              @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_near_agent"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_near_agent" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *nearagents = [WHgetnearagent  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(nearagents);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//刷新分支机构三级
-(void)getorgProvinceWithProvince:(NSString *)province
                             city:(NSString *)city
                           county:(NSString *)county
                           com_id:(NSString *)com_id
                         distance:(NSString *)distance
                              map:(NSString *)map
                          success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"province":province ? province:@"",
                              @"city":city?city:@"",
                              @"county":county?county:@"",
                              @"com_id":com_id?com_id:@"",
                              @"distance":@"10.00",
                              @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_organization"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_organization" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *getorgs = [WHorganization  arrayOfModelsFromDictionaries:infos error:nil];
        if (success) {
            success(getorgs);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    

}
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
                              success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"company_id":company_id ,@"keyword":keyword,@"sex":sex,@"age":age,@"characters":characters, @"period":period ,@"cate_id":care_id ,@"pay_period":pay_period,@"p":p ,@"pagesize":pagesize}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_product"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_product" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *products = [WHgetproduct arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(products);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    

}
//刷新医院接口数据
-(void)gethospitalWithCom_id:(NSString *)com_id
                    province:(NSString *)province
                        city:(NSString *)city
                      county:(NSString *)county
                    distance:(NSString *)distance
                         map:(NSString *)map
                     success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"com_id":com_id,
                                     @"province":province ,
                                     @"city":city ,
                                     @"county":county,
                                     @"distance":distance,
                                     @"map":map}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_hospital"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kb/get_hospital" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *hospitals = [WHhospital arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(hospitals);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
    
}

//体检报告合并
-(void)getreportWithPolicyid:(NSString *)policy_id
                         uid:(NSString *)uid
                     success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"policy_id":policy_id,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_report"] mutableCopy];
    
    [self.httpManager POST:param withPoint:@"kbj/get_report" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *reports = [WHgetreport arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(reports);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//获取公司新接口列表
-(void)getprocomWithIshasrate:(NSString *)is_has_rate success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary * param = [@{@"is_has_rate":is_has_rate}mutableCopy];
    param = [[self filterParam:param interface:@"kb/get_pro_com"]mutableCopy];
    [self.httpManager POST:param withPoint:@"kb/get_pro_com" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *companys = [JwCompanys arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(companys);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//获取新接口体检险种
-(void)getpolicyprosWithCompany_id:(NSString *)company_id
                           keyword:(NSString *)keyword
                               uid:(NSString *)uid
                                 p:(NSString *)p
                          pagesize:(NSString *)pagesize
                           success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"company_id":company_id,
                              @"keyword":keyword,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"p":p,
                              @"pagesize":pagesize,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_policy_pros"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_policy_pros" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *products = [WHgetproduct arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(products);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    

    
}

//zhanghu
-(void)getinvitedWithInvited_uid:(NSString *)invited_uid
                               p:(NSString *)p
                        pagesize:(NSString *)pagesize
                            uid :(NSString *)uid
                         success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"invited_uid":[JwUserCenter sharedCenter].uid,
                              @"p":p,
                              @"pagesize":pagesize,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_invited"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_invited" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *products = [WHgetvited arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(products);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

    
}

//提现
-(void)getcashWithUid:(NSString *)uid finance_id:(NSString *)finance_id success:(void (^)(NSArray * list))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"uid":[JwUserCenter sharedCenter].uid,
                              @"finance_id":finance_id,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_cash"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_cash" success:^(id data) {
        
        NSArray *infos = data[@"data"];
        NSArray *cashs = [WHgetcash arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success) {
            success(cashs);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

//我的记录
-(void)caiwujiluWithInvited_uid:(NSString *)p
                        pagesize:(NSString *)pagesize
                            uid :(NSString *)uid
                         success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSDictionary * param = [@{@"p":p,
                              @"pagesize":pagesize,
                              @"uid":[JwUserCenter sharedCenter].uid,
                              @"token":[JwUserCenter sharedCenter].key}mutableCopy];
    param = [[self filterParam:param interface:@"kbj/get_finance"] mutableCopy];
    [self.httpManager POST:param withPoint:@"kbj/get_finance" success:^(id data)
    {
        NSArray *infos = data[@"data"];
        
        NSArray *products = [WHgetcash arrayOfModelsFromDictionaries:infos error:nil];
        
        if (success)
        {
            success(products);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}




@end
