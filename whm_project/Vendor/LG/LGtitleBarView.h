//
//  LGtitleBarView.h
//  titleScroll
//
//  Created by jamy on 15/7/6.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGtitleBarView;
@protocol LGtitleBarViewDelegate <NSObject>
@optional
- (void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index;

@end

@interface LGtitleBarView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, assign) id<LGtitleBarViewDelegate> delegate;
@end
