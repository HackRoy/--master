//
//  JwHttpManager.h
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol HttpManagerDelegate <NSObject>

@required

- (BOOL)httpManager:(id)hepler isSuccess:(NSDictionary *)response;

- (void)httpManager:(id)helper response:(id)response error:(NSError *)error;

@end

@interface JwHttpManager : NSObject

@property (weak, nonatomic) id<HttpManagerDelegate> delegate;

+ (JwHttpManager *)sharedManager;

- (void)GET:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)GET:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failureBack:(void (^)(NSError * error, id data))failure;

- (void)POST:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)POST:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failureBack:(void (^)(NSError * error, id data))failure;

- (void)DELETE:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure;

- (void)upload:(NSDictionary *)params withPoint:(NSString *)point image:(UIImage *)image success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

- (void)upload:(NSDictionary *)params withPoint:(NSString *)point fileData:(NSData *)data success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;


@end
