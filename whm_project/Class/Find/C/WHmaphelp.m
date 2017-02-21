//
//  WHmaphelp.m
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmaphelp.h"
#import "AppDelegate.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@implementation WHmaphelp
+ (void)getUserLocationLongitude:(NSString **)longitude latitude:(NSString **)latitude {
    *longitude = [NSString stringWithFormat:@"%lf", [(AppDelegate *)[[UIApplication sharedApplication] delegate] locationService].userLocation.location.coordinate.longitude];
    *latitude = [NSString stringWithFormat:@"%lf", [(AppDelegate *)[[UIApplication sharedApplication] delegate] locationService].userLocation.location.coordinate.latitude];
}

+ (double)distanceBetweenPoint1:(CLLocationCoordinate2D)point1 andPoint2:(CLLocationCoordinate2D)point2 {
    BMKMapPoint p1 = BMKMapPointForCoordinate(point1);
    BMKMapPoint p2 = BMKMapPointForCoordinate(point2);
    return BMKMetersBetweenMapPoints(p1, p2);
}

@end
