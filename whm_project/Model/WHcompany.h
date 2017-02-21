//
//  WHcompany.h
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHcompany <NSObject>

@end
@interface WHcompany : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id;
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * shortWh;
@property(nonatomic,strong)NSString <Optional> * short_name;
@property(nonatomic,strong)NSString <Optional> * logo;
@property(nonatomic,strong)NSString <Optional> * initial;
@property(nonatomic,strong)NSString <Optional> * create_time;

@end
