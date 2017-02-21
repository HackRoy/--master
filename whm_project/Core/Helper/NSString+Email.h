//
//  NSString+Email.h
//  ZJNews
//
//  Created by Tang Haibo on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Email)
- (BOOL)validateEmail;
- (NSString *)emailHideConversion;
- (NSString *)mobileHideConversion;
- (NSString *)businessCodeHideCoversion;
@end
