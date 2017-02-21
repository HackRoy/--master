//
//  WHget_product_detail.h
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHcompany.h"

@protocol WHget_product_detail <NSObject>

@end
@interface WHget_product_detail : JwModelBase
@property(nonatomic,strong)NSString<Optional> * id;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * short_name;
//其他信息
@property(nonatomic,strong)NSString <Optional> * clause;
@property(nonatomic,strong)NSString <Optional> * cases;
@property(nonatomic,strong)NSString <Optional> * rights;
@property(nonatomic,strong)NSString <Optional> * rule;
@property(nonatomic,strong)NSString <Optional> * pdf_path;
@property(nonatomic,strong)NSString <Optional> * company_logo;
@property(nonatomic,strong)NSString <Optional> * company_short_name;
@property(nonatomic,strong)NSString <Optional> * ins_type_name;
@property(nonatomic,strong)NSString <Optional> * sale_status_name;
@property(nonatomic,strong)NSString <Optional> * is_main;
@property(nonatomic,strong)WHcompany <Optional> * company;


@end
