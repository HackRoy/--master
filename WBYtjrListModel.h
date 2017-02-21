//
//  WBYtjrListModel.h
//  whm_project
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WBYtjrListModel <NSObject>

@end

@interface WBYtjrListModel : JSONModel
@property(nonatomic,copy)NSString  * id;
@property(nonatomic,copy)NSString  * name;
@property(nonatomic,copy)NSString  * sex;
@property(nonatomic,copy)NSString  * birthday;
@property(nonatomic,copy)NSString  * mobile;
@property(nonatomic,copy)NSString  * avatar;
@property(nonatomic,copy)NSString  * type;
@property(nonatomic,copy)NSString  * invited_count;
@property(nonatomic,copy)NSString  * status;


@end
