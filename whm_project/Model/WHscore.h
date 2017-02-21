//
//  WHscore.h
//  whm_project
//
//  Created by 王义国 on 16/11/14.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHscore<NSObject>
@end
@interface WHscore : JwModelBase
@property(nonatomic,strong)NSString <Optional> * score;
@property(nonatomic,strong)NSString <Optional> * level;
@property(nonatomic,strong)NSString <Optional> * rate;

@end
