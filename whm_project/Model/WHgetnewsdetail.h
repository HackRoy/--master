//
//  WHgetnewsdetail.h
//  whm_project
//
//  Created by 王义国 on 16/12/6.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@interface WHgetnewsdetail : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id ;
@property(nonatomic,strong)NSString <Optional> * cid;
@property(nonatomic,strong)NSString <Optional> * created_time;
@property(nonatomic,strong)NSString <Optional> * source;
@property(nonatomic,strong)NSString <Optional> * title;
@property(nonatomic,strong)NSString <Optional> * content;
@property(nonatomic,strong)NSString <Optional> * author;
@property(nonatomic,strong)NSString <Optional> * thumbnail;
@property(nonatomic,strong)NSString <Optional> * update_time;
@property(nonatomic,strong)NSString <Optional> * count;
@property(nonatomic,strong)NSString <Optional> * rank;
@property(nonatomic,strong)NSString <Optional> * status;
@property(nonatomic,strong)NSString <Optional> * is_collect;
@property(nonatomic,strong)NSString <Optional> * type_name;

@end
