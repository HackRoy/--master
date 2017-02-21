//
//  WHcount.h
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHyearapp.h"
@protocol WHcount <NSObject>

@end
@interface WHcount : JwModelBase
@property(nonatomic,strong)NSString <Optional> * pro_count;
@property(nonatomic,strong)NSString <Optional> * message_count;
@property(nonatomic,strong)NSString <Optional> * news_count;
@property(nonatomic,strong)NSString <Optional> * customer_count;


@end
