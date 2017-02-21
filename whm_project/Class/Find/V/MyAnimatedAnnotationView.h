//
//  MyAnimatedAnnotationView.h
//  ShanXinZhiHuiYangLaoZiNv
//
//  Created by Stephy_xue on 16/7/25.
//  Copyright © 2016年 henankuibu. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MyAnimatedAnnotationView : BMKAnnotationView

@property (nonatomic, strong) NSMutableArray *annotationImages;
@property (nonatomic, strong) UIImageView *annotationImageView;

@end
