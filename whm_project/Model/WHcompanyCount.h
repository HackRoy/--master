//
//  WHcompanyCount.h
//  whm_project
//
//  Created by 王义国 on 16/12/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHyearapp.h"
#import "WHspcil_attriModel.h"
#import "WBYspecial_attriModel.h"

@protocol WHcompanyCount <NSObject>


@end

@interface WHcompanyCount : JwModelBase
//@property(nonatomic,strong)NSString <Optional> * year_app;
@property(nonatomic,strong)NSArray<WHyearapp > * year_app;
@property(nonatomic,strong)NSArray<WHspcil_attriModel > * special_attri;
@property(nonatomic,strong)NSArray<WBYspecial_attriModel > *prod_type_code_app;
@property(nonatomic,strong)NSArray<WBYspecial_attriModel> * ins_type;
@property(nonatomic,strong)NSArray<WBYspecial_attriModel> * sale_status;




@end
