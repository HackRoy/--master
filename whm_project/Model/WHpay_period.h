//
//  WHpay_period.h
//  whm_project
//
//  Created by 王义国 on 16/11/16.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"

@protocol WHpay_period <NSObject>



@end

@interface WHpay_period : JwModelBase

@property (nonatomic, strong) NSString <Optional> *year15;
@property (nonatomic, strong) NSString <Optional> *year5;
@property (nonatomic, strong) NSString <Optional> *year;
@property (nonatomic, strong) NSString <Optional> *year10;
@property (nonatomic, strong) NSString <Optional> *year20;

@end
