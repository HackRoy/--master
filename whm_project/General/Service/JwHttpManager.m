//
//  JwHttpManager.m
//  e-bank
//
//  Created by chenJw on 16/9/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwHttpManager.h"
#import "JwServiceDefine.h"
#import "MacroUtility.h"

@implementation JwHttpManager

+ (JwHttpManager *)sharedManager{
    static JwHttpManager *httpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[JwHttpManager alloc] init];
    });
    return httpManager;
}

- (void)GET:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    session.requestSerializer.timeoutInterval = 30;
    
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    //申明请求的结果是json类型
    //session.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html , 也可以在AFURLResponseSerialization里面的init方法中设
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", @"text/javascript", nil];
    //申明返回的结果是json类型
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    //信任非法证书
    session.securityPolicy.allowInvalidCertificates = YES;
    //校验证书
    session.securityPolicy.validatesDomainName = NO;
    
    //数据请求
    [session GET:point parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        if ([self.delegate httpManager:self isSuccess:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSString *domain = responseObject[@"info"];
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
            failure(error);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        failure(error);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];

}

- (void)GET:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failureBack:(void (^)(NSError * error, id data))failure{
    
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    session.requestSerializer.timeoutInterval = 30;
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    //申明请求的结果是json类型
    //session.requestSerializer = [AFJSONRequestSerializer serializer];

    //如果报接受类型不一致请替换一致text/html , 也可以在AFURLResponseSerialization里面的init方法中设
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", @"text/javascript", nil];
    //申明返回的结果是json类型
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    //信任非法证书
    session.securityPolicy.allowInvalidCertificates = YES;
    //校验证书
    session.securityPolicy.validatesDomainName = NO;
    
    //数据请求
    [session GET:point parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        if ([self.delegate httpManager:self isSuccess:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSString *domain = responseObject[@"info"];
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
            failure(error, responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        failure(error, nil);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}

- (void)POST:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    //////
 session.responseSerializer.acceptableContentTypes = nil;//[NSSet setWithObject:@"text/ plain"];
    session.securityPolicy = [AFSecurityPolicy defaultPolicy];
    session.securityPolicy.allowInvalidCertificates = YES;//忽略https证书
    session.securityPolicy.validatesDomainName = NO;//是否验证域名
    ////
    session.requestSerializer.timeoutInterval = 15;
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
//    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", @"text/javascript", nil];
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    session.securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy.validatesDomainName = NO;
    
    [session POST:point parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {        
        if ([self.delegate httpManager:self isSuccess:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSString *domain = responseObject[@"info"];
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
            failure(error);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        DLog(@"%@", error);
        failure(error);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}

- (void)POST:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failureBack:(void (^)(NSError * error, id data))failure{
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    session.requestSerializer.timeoutInterval = 30;
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", @"text/javascript", nil];
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    session.securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy.validatesDomainName = NO;
    
    [session POST:point parameters:params progress:^(NSProgress * _Nonnull uploadProgress)
     {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@", responseObject);
        
        if ([self.delegate httpManager:self isSuccess:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSString *domain = responseObject[@"info"];
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
            failure(error, responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@", error);
        failure(error, nil);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}

- (void)DELETE:(NSDictionary *)params withPoint:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    session.requestSerializer.timeoutInterval = 30;
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", @"text/javascript", nil];
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    session.securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy.validatesDomainName = NO;
    
    [session DELETE:point parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DLog(@"%@", responseObject);
        
        if ([self.delegate httpManager:self isSuccess:responseObject]) {
            success(responseObject);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:nil];
            }
        }else{
            NSString *domain = responseObject[@"info"];
            NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
            failure(error);
            
            if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                [self.delegate httpManager:self response:responseObject error:error];
            }
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        DLog(@"%@", error);
        failure(error);
        if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
            [self.delegate httpManager:self response:nil error:error];
        }
    }];
}


- (void)upload:(NSDictionary *)params withPoint:(NSString *)point image:(UIImage *)image success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    session.requestSerializer.timeoutInterval = 30;
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];
    
    session.requestSerializer = [AFJSONRequestSerializer serializer];
    //session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"test/json",@"application/json",@"text/plain", nil];
    session.securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy.validatesDomainName = NO;
    
    [session POST:point parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     {
         NSData *data = UIImageJPEGRepresentation(image, 0.5f);
         // 上传时使用当前的系统时间做为文件名
         NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
         formatter.dateFormat  = @"yyyyMMddHHmmssSSS";
         NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
         /**
          *  appendPartWithFileData  //  指定上传的文件
          *  name                    //  指定在服务器中获取对应文件或文本时的key
          *  fileName                //  指定上传文件的原始文件名
          *  mimeType                //  指定上传文件的MIME类型
          */
         [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
         
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         
         if ([self.delegate httpManager:self isSuccess:responseObject]) {
             success(responseObject);
             
             if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                 [self.delegate httpManager:self response:responseObject error:nil];
             }
         }else{
             NSString *domain = responseObject[@"info"];
             NSError *error = [NSError errorWithDomain:domain code:[responseObject[@"err"] integerValue] userInfo:responseObject];
             failure(error);
             
             if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
                 [self.delegate httpManager:self response:responseObject error:error];
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
         failure(error);
         if ([self.delegate respondsToSelector:@selector(httpManager:response:error:)]) {
             [self.delegate httpManager:self response:nil error:error];
         }
     }];
}

- (void)upload:(NSDictionary *)params withPoint:(NSString *)point fileData:(NSData *)data success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    
    NSURL *baseURL = [NSURL URLWithString:kServiceBaseURL];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    [session.requestSerializer setValue:@"ios" forHTTPHeaderField:@"client"];

    NSURL *url = [NSURL URLWithString:point];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        }else{
            success(responseObject);
        }
    }];
    [uploadTask resume];
}










@end
