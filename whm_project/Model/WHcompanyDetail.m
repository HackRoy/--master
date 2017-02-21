//
//  WHcompanyDetail.m
//  whm_project
//
//  Created by 王义国 on 16/10/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcompanyDetail.h"

@implementation WHcompanyDetail

+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"description":@"descriptionJw"}];
}

@end
