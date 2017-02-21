//
//  WHgetmessage.h
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol  WHgetmessage<NSObject>


@end

@interface WHgetmessage : JwModelBase
@property(nonatomic,strong)NSString<Optional> * id ;
@property(nonatomic,strong)NSString<Optional> * req_uid;
@property(nonatomic,strong)NSString<Optional> *res_uid;
@property(nonatomic,strong)NSString<Optional> *message_id;
@property(nonatomic,strong)NSString<Optional> *read;
@property(nonatomic,strong)NSString<Optional> *reply_status;
@property(nonatomic,strong)NSString<Optional> *create_time;
@property(nonatomic,strong)NSString<Optional> *ip;
@property(nonatomic,strong)NSString<Optional> *city_name;
@property(nonatomic,strong)NSString<Optional> *req_name;
@property(nonatomic,strong)NSString<Optional> *message;


@end
