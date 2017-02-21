//
//  WHnews.h
//  whm_project
//
//  Created by 王义国 on 16/11/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHnews <NSObject>


@end
@interface WHnews : JwModelBase
@property(nonatomic,strong)NSString <Optional> * id ;
@property(nonatomic,strong)NSString <Optional> * cid;
@property(nonatomic,strong)NSString <Optional> * title;
@property(nonatomic,strong)NSString <Optional> * soucre;
@property(nonatomic,strong)NSString <Optional> * created_time;
@property(nonatomic,strong)NSString <Optional> * thumbnail;
@property(nonatomic,strong)NSString <Optional> * count;
@property(nonatomic,strong)NSString <Optional> * is_collect;


@end
