//
//  WHcompany.m
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcompany.h"

@implementation WHcompany
+(JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"short":@"shortWh"}];
}

@end
