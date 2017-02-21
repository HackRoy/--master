//
//  CreateMD5WithImage.m
//  GGSee
//
//  Created by 李志强 on 15/8/21.
//  Copyright (c) 2015年 李志强. All rights reserved.
//

#import "CreateMD5WithImage.h"
#import "MyDdddd.h"


@implementation CreateMD5WithImage
+(NSString *)createMD5WithImage:(NSData *)imageData
{
    NSString * string = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    return [MyDdddd md5:string];
}

+(NSString*)fileMD5:(NSData *)data
{
    NSString * dataPath = NSTemporaryDirectory();
    
    //将图片归档
    [data writeToFile:[dataPath stringByAppendingPathComponent:@"dataForImage.tmp"] atomically:YES];
    
    //
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:[dataPath stringByAppendingPathComponent:@"dataForImage.tmp"]];
    if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didn't exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 1000 ];
        CC_MD5_Update(&md5, [fileData bytes], (int)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}
@end
