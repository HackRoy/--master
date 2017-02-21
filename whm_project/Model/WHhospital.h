//
//  WHhospital.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
@interface WHhospital : JwModelBase
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * tel ;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * longitude;
@property(nonatomic,strong)NSString * latitude;
@property(nonatomic,strong)NSString * distance;


@end
