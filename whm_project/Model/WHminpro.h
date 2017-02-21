//
//  WHminpro.h
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JwModelBase.h"

@protocol  WHminpro <NSObject>


@end

@interface WHminpro : JwModelBase

@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSString <Optional> * img;
@property(nonatomic,strong)NSString <Optional> * small_img;
@property(nonatomic,strong)NSString <Optional> * limit_age;
@property(nonatomic,strong)NSString <Optional> * ptype;
@property(nonatomic,strong)NSString <Optional> * ptype_name;
@property(nonatomic,strong)NSString <Optional> * logo;
@end
