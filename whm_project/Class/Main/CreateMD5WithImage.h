//
//  CreateMD5WithImage.h
//  GGSee
//
//  Created by 李志强 on 15/8/21.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface CreateMD5WithImage : NSObject
+(NSString *)createMD5WithImage:(NSString *)string;
+(NSString*)fileMD5:(NSData *)data;
@end
