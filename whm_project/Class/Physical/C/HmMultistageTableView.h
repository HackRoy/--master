//
//  HmMultistageTableView.h
//  whm_project
//
//  Created by zhaoHm on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HmMultistageTableView;

@protocol HmTableViewDataSource <NSObject>

@required

- (NSInteger)mTableView:( HmMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)mTableView:(HmMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(HmMultistageTableView *)mTableView;

@end

@protocol HmTableViewDelegate <NSObject>

@optional

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)mTableView:(HmMultistageTableView *)mTableView viewForHeaderAtSection:(NSInteger)section;

- (void)mTableView:(HmMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section;

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section;

- (void)mTableView:(HmMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)mTableView:(HmMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HmMultistageTableView : UIView<UITableViewDelegate,UITableViewDataSource>

// 数据源代理委托
@property (nonatomic, assign) id<HmTableViewDataSource> dataSource;
// 事件代理委托
@property (nonatomic, assign) id<HmTableViewDelegate> delegate;


@property (nonatomic, strong, readonly) NSIndexPath *openedIndexPath;
// 主体Tableview
@property (nonatomic, strong, readonly) UITableView *tableV;
// 展开最内层cell 要显示的view
@property (nonatomic, strong) UIView *atomView;
// 展开后atomView的位置坐标(相对于展开的cell的左下角) Default is CGPointMake(0, 0);
@property (nonatomic) CGPoint atomOrigin;

/**
 *  列表单元添加复用标识
 *
 *  @param identifier 复用标识字符串
 *
 *  @return 列表单元对象
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;

- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

/**
 * 模拟列表cell点击事件 -1 为关闭
 * 
 * @param indexPath cell所在路径
 */
- (void)sendCellTouchActionWithIndexPath:(NSIndexPath *)indexPath;

/**
 * 模拟列表Header点击事件 -1 为关闭
 *
 * @param section header 索引
 */
- (void)sendHeaderTouchActionWithSection:(NSInteger)section;

/**
 * 重新加载数据
 */
- (void)reloadData;

- (void)mRegisterNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier;

- (UITableViewHeaderFooterView *)mDequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

- (void)mRegisterClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
@end
