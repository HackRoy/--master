//
//  WBYRequest.m
//  KuiBuText
//
//  Created by Stephy_xue on 16/3/4.
//  Copyright © 2016年 Baoya. All rights reserved.
//

#import "WBYRequest.h"

#import "Md5.h"

@implementation WBYRequest

+ (void)showMessage:(NSString *)message 
{
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    for (UIView *view in window.subviews)
    {
        if (view.tag == 1001 || view.tag == 1002)
        {
            [view removeFromSuperview];
        }
    }
    UIView * bgView =[UIView new];
    bgView.tag = 1001;
    [window addSubview:bgView];
    
    UILabel * myLab=[UILabel new];
    myLab.tag = 1002;
    myLab.text=message;
    myLab.numberOfLines=0;
    myLab.layer.masksToBounds=YES;
    myLab.layer.cornerRadius=10;
    myLab.layer.borderColor = wBlue.CGColor;
    myLab.layer.borderWidth = 1;
    
    myLab.textColor=[UIColor whiteColor];
    myLab.backgroundColor=[UIColor blackColor];
    myLab.textAlignment=NSTextAlignmentCenter;
    CGFloat kuan=[message boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.width;
    
    [bgView addSubview:myLab];
    [bgView makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.right.bottom.top.equalTo(0);
     }];
    
    [myLab makeConstraints:^(MASConstraintMaker *make)
     {
         make.center.equalTo(bgView.center);
         make.height.equalTo(30);
         make.width.equalTo(kuan+30);
     }];
    
    [UIView animateWithDuration:0.6 animations:^{
        
    } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.6 animations:^{
             bgView.alpha = 0.81;
             myLab.alpha = 1;
         } completion:^(BOOL finished)
          {
              [UIView animateWithDuration:0.6 animations:^{
                  bgView.alpha = 0.8;
                  myLab.alpha = 0.9;
                  
//                  CABasicAnimation * baseAn =[CABasicAnimation animationWithKeyPath:@"position"];
//                  baseAn.duration = 2;
//                  baseAn.toValue = [NSValue valueWithCGRect:CGRectMake(-200, bgView.center.y, kuan+30, 40)];
//                  baseAn.removedOnCompletion = YES;
//                  
//                  [myLab.layer addAnimation:baseAn forKey:nil];
                  
              } completion:^(BOOL finished)
               {
                   [bgView removeFromSuperview];
                   [myLab removeFromSuperview];
                   [myLab.layer removeAllAnimations];
                   
               }];
          }];
     }];
}
//获得系统的版本号

+ (double)getCurrentIOS
{
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}
+(NSString *)getBundleShortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+(void)wbyPostRequestDataUrl:(NSString *)url addParameters:(NSDictionary *)requestDict success:(getModelBlock)successBlock failure:(failDownloadBlcok)failureBlock isRefresh:(BOOL)isRefresh
{
    if (url==nil)
    {
        return ;
    }
    NSString* myUrl=[NSString stringWithFormat:@"%@%@",BASEURL,url];
    NSString * urlStr=[NSURL URLWithString:myUrl]?myUrl:[self strUTF8Encoding:myUrl];
    AFHTTPSessionManager*manger=[self getAFManager];
    [manger POST:urlStr parameters:requestDict progress:^(NSProgress * _Nonnull uploadProgress)
     {
         // 回到主队列刷新UI,用户自定义的进度条
         dispatch_async(dispatch_get_main_queue(),^{
         });
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         
//              NSFileManager *fm = [NSFileManager defaultManager];
//                 NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//                 NSString *filePath = [path objectAtIndex:0];
//         
//                 NSString *plistPath = [filePath stringByAppendingPathComponent:@"allAreafileaaa.plist"];
//                 [fm createFileAtPath:plistPath contents:nil attributes:nil];
//            [responseObject[@"data"] writeToFile:plistPath atomically:YES];
//                 
//                 NSLog(@"===%@",filePath);         
         if (responseObject)
         {
             WBYReqModel * model=[[WBYReqModel alloc] initWithDictionary:responseObject error:nil];
             if (model)
             {
                 successBlock(model);
             }
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         if (failureBlock)
         {
             failureBlock(error);
         }
          [WBYRequest showMessage:@"请求失败"];
         
     }];
    
}


+(AFHTTPSessionManager *)getAFManager
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
}


+(NSString *)strUTF8Encoding:(NSString *)str
{
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+(NSString*)timeStr:(NSString*)myTime
{
    if ((NSNull *)myTime != [NSNull null])
    {
        //double time=[myTime longLongValue]/1000;
        double time=[myTime longLongValue];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * confromTimesp=[NSDate dateWithTimeIntervalSince1970:time];
        NSString*confromTimespStr = [formatter stringFromDate:confromTimesp];
        return confromTimespStr;
     }
    else
     {
        return @"";
    }
}
#pragma mark - 判断手机号
//验证邮箱
+ (BOOL)isEmailAddress:(NSString *)address
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:address];
}



+(BOOL)isMobileNumber:(NSString *)mobileNum

{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"\\d{2,5}-\\d{7,8}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       
       || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        
        return YES;
        
    }
    
    else
        
    {
        
        return NO;
        
    }
 }

//^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$


+ (BOOL)isChePaiHao:(NSString *)address
{
    NSString *emailRegex = @"^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[警京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼]{0,1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES  %@", emailRegex];
    return [emailTest evaluateWithObject:address];
}





+(NSString*)creatFile:(NSString*)aName
{
    NSString*fileeee= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0];
    
    NSString*filePath=[fileeee stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",aName]];
    
    return filePath;
    
    
}

//通过string和字体大小求出text自适应需要的高度
+ (CGFloat)getAutoHeightForString:(NSString *)String
                        withWidth:(CGFloat)width
                     withFontSize:(CGFloat)fontSize
{
    // 01: 约定绘制文本的最大范围
    // 02: 绘制文本的方式, 枚举类型
    // 03: 绘制文本的属性, 字体大小/行的截取方式等.
    NSDictionary *dic = @{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]};
    CGFloat height = [String boundingRectWithSize:CGSizeMake(width,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return height;
}

+ (CGFloat)getWeightForString:(NSString *)String
                        withHeight:(CGFloat)height
                     withFontSize:(CGFloat)fontSize
{
    // 01: 约定绘制文本的最大范围
    // 02: 绘制文本的方式, 枚举类型
    // 03: 绘制文本的属性, 字体大小/行的截取方式等.
    NSDictionary *dic = @{NSFontAttributeName :[UIFont systemFontOfSize:fontSize]};
    CGFloat w = [String boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.width;
    return w;
}

//图片资源大小
+(NSString*)fileSizeOfLength:(long long)length{
    
    if (length<1000) {
        return [NSString stringWithFormat:@"%lldB",length];
    }else if (length<1000*1000)
    {
        return [NSString stringWithFormat:@"%.2fKB",length/1000.0];
    }else if (length<1000*1000*1000)
    {
        return [NSString stringWithFormat:@"%.2fMB",length/1000/1000.0];
    }else
    {
        return [NSString stringWithFormat:@"%.2fGB",length/1000/1000/1000.0];
    }
}


+ (BOOL)isPersonIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
    }

//比较领个日期的大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    switch (result)
    {
            //bDate比aDate大
        case NSOrderedAscending: aa=1; break;
            //小
        case NSOrderedDescending: aa=-1; break;
            //等
        case NSOrderedSame: aa=0; break;
        default:
            
            ; break;
    }
    
    
//    if (aa==0)
//    {
////        相等
//    }else if (aa==1)
//    {
//       //bDate比aDate大
//        
//    }else if (aa==-1)
//    {
//        //bDate比aDate小
//        
//        
//    }
    
    
    return aa;
}


//获取当前日期的毫秒数

+ (long long)getCurrentDate
{
    
    return [[NSDate date] timeIntervalSince1970]*1000;
}

//获取字符串日期的毫秒数

+ (long long)getZiFuChuan:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1=[dateFormatter dateFromString:time];
    
   return [date1 timeIntervalSince1970]*1000;
    
//    日期转化字符串
  /*  NSDateFormatter *dateToStringFormatter=[[NSDateFormatter alloc] init];
    [dateToStringFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nsDate=[dateToStringFormatter stringFromDate:date];  */
    
}
//加密

+ (NSString *)jiami:(NSString *)canshu
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSArray * inters = [canshu componentsSeparatedByString:@"/"];
    NSString * kbStr = [[MyDdddd md5:[NSString stringWithFormat:@"kuaibao%@%@%@api", [inters firstObject], dateStr, [inters lastObject]]] lowercaseString];
    
    if(kbStr.length > 1)
    {
        return kbStr;
    }
    else
    {
        return @"0";
    }
    
}

//排序

+(NSArray *)paixuArr:(NSMutableArray *)arr
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [arrM addObject:[NSNumber numberWithInteger:[obj integerValue]]];
    }];
    
    return  [arrM sortedArrayUsingSelector:@selector(compare:)];
    
}

+(NSMutableArray*)shanchuSame:(NSMutableArray *)dataArray
{
    NSMutableArray *listAry = [[NSMutableArray alloc] init];
    for (NSString *str in dataArray)
    {
        if (![listAry containsObject:str])
        {
            [listAry addObject:str];
        }
    }
    return listAry;
}


@end
