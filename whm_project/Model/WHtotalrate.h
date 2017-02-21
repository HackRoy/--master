//
//  WHtotalrate.h
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHtotalrate <NSObject>


@end

@interface WHtotalrate : JwModelBase
@property(nonatomic,strong)NSString <Optional> * name;
@property(nonatomic,strong)NSString <Optional> * score;
@property(nonatomic,strong)NSString <Optional> * level;
@property(nonatomic,strong)NSString <Optional> * des;

@end
