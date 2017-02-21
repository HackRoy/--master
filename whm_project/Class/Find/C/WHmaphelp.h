//
//  WHmaphelp.h
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCLocationManager.h"

@interface WHmaphelp : NSObject
+ (void)getUserLocationLongitude:(NSString **)longitude latitude:(NSString **)latitude;
+ (double)distanceBetweenPoint1:(CLLocationCoordinate2D)point1 andPoint2:(CLLocationCoordinate2D)point2;
@end
