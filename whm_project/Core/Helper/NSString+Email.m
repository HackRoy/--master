//
//  NSString+Email.m
//  ZJNews
//
//  Created by Tang Haibo on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+Email.h"

@implementation NSString (Email)

-(BOOL)validateEmail
{
    NSString *email = self;
    //检查email里是否有'@'和'.' ag:jddj@qq.com
    if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
    {
        NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet] mutableCopy];
        [invalidCharSet removeCharactersInString:@"_-"];
        
        NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        //根据@把字符分割成两个子串jddj和.com
        
        //取出后半部分字符串
        NSString *domainPart = [email substringFromIndex:range1.location+1];
        NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
        
        for (NSString *string in stringsArray2) 
        {
            NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
            //检查‘@’和‘.’是否相邻
            if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
                return NO;
        }
        return YES;
    }
    else
        return NO;
}

-(NSString *) emailHideConversion {
    NSMutableString *email = [[NSMutableString alloc] initWithString: self];
    NSRange range = [email rangeOfString:@"@"];
    if(range.length <1) {
        return self;
    }
    NSString *emailHead = [email substringWithRange:NSMakeRange(0,range.location+1)];
    NSString *tmp = [email substringWithRange:NSMakeRange(range.location, email.length - range.location)];
    range = [tmp rangeOfString:@"."];
    int hiddenLength = (int)range.location-1;
    NSString *emailTail = [tmp substringWithRange:NSMakeRange(range.location, tmp.length-range.location)];
    email = [[NSMutableString alloc] init];
    [email appendString: emailHead];
    for (int i=0; i<hiddenLength; i++) {
        [email appendString:@"*"];
    }
    [email appendString:emailTail];
    
    return email;
}

- (NSString *)mobileHideConversion {
    NSMutableString *mobile = [[NSMutableString alloc] initWithString: self];
    if (self.length < 7) {
        return self;
    }
    NSRange range;
    range.location = 3;
    range.length = 4;
    [mobile replaceCharactersInRange: range withString:@"****"];
    
    return mobile;
}

- (NSString *)businessCodeHideCoversion {
    NSMutableString *businessCode = [[NSMutableString alloc] initWithString:self];
    
    if (self.length < 6) {
        return self;
    }
    
    NSRange range;
    range.location = 5;
    range.length = self.length < 10 ? self.length - 5 : 5;
    NSMutableString *replaceStr = [[NSMutableString alloc] initWithCapacity:range.length];
    for (int i=0; i<range.length; i++) {
        [replaceStr appendString:@"*"];
    }
    
    [businessCode replaceCharactersInRange:range withString:replaceStr];
    
    return businessCode;
}

@end
