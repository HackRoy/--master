//
//  JwSingleton.h
//  SeniorCare
//
//  Created by chenJw on 16/8/25.
//  Copyright © 2016年 Jw. All rights reserved.
//

//  单例宏

// .h文件
#define JwSingletonH(name) + (instancetype)shared##name;
// .m文件
#define JwSingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

/* JwSingleton_h */
