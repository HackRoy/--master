//
//  WHmongorate.h
//  whm_project
//
//  Created by 王义国 on 16/11/11.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHrate.h"

@protocol WHmongorate <NSObject>
@end

@interface WHmongorate : JwModelBase

@property(nonatomic,strong)NSString <Optional> * insured;
@property(nonatomic,strong)NSString <Optional> * pid;
@property(nonatomic,strong)NSString <Optional> * bee_type;
@property(nonatomic,strong)NSArray <WHrate ,Optional> *rate;
@end
