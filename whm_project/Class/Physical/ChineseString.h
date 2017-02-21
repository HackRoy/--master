//
//  ChineseString.h
//  whm_project
//
//  Created by 贾增辉 on 2017/2/21.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChineseString : NSObject
@property(retain,nonatomic)NSString *string;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;



///----------------------
//返回一组字母排序数组(中英混排)
+(NSMutableArray*)SortArray:(NSArray*)stringArr;

@end
