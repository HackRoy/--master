//
//  WHspcil_attriModel.h
//  whm_project
//
//  Created by apple on 16/12/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol WHspcil_attriModel <NSObject>
@end
@interface WHspcil_attriModel : JSONModel
@property(nonatomic,strong)NSString <Optional> * value;
@property(nonatomic,strong)NSString <Optional> * name;

@end
