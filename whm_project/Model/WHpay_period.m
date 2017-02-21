//
//  WHpay_period.m
//  whm_project
//
//  Created by 王义国 on 16/11/16.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpay_period.h"

@implementation WHpay_period

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"15年期缴":@"year15",
                                                      @"5年期缴":@"year5",
                                                      @"趸缴":@"year",
                                                      @"10年期缴":@"year10",
                                                      @"20年期缴":@"year20"}];
}

@end
