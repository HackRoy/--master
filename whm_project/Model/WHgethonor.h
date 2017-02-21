//
//  WHgethonor.h
//  whm_project
//
//  Created by 王义国 on 16/11/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHgethonor <NSObject>


@end

@interface WHgethonor : JwModelBase

@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * uid;
@property(nonatomic,strong)NSString <Optional> * create_time;
@property(nonatomic,strong)NSString <Optional> * img1;
@property(nonatomic,strong)NSString <Optional> * img2;
@property(nonatomic,strong)NSString <Optional> * img3;
@property(nonatomic,strong)NSString <Optional> * remark;

@end
