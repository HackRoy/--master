//
//  HmMultistageTableView.m
//  whm_project
//
//  Created by zhaoHm on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmMultistageTableView.h"

typedef enum
{
    // 最外层
    HmHeaderLineTouch,
    // 中间层
    HmCellLineTouch,
    // 代码
    HmCodeSendTouch,
} HmLineTouchType;

static const CGFloat kDefultHeightForRow = 44.0f;
static const CGFloat kDefultHeightForAtom = 44.0f;

@implementation HmMultistageTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
        
        _atomOrigin = CGPointMake(0, 0);
        
        _tableV = [[UITableView alloc] initWithFrame:frame];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.backgroundColor = [UIColor clearColor];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self addSubview:_tableV];
    }
    return self;
}

#pragma mark -- Public Methods
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    id cell = [self.tableV dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
//    [self tableView:_tableV cellForRowAtIndexPath:indexPath];
    id cell = [self.tableV dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

-(id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier
{
    return [self.tableV dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

-(void)sendHeaderTouchActionWithSection:(NSInteger)section
{
    [self openOrCloseHeaderWithSection:section];
}

- (void)sendCellTouchActionWithIndexPath:(NSIndexPath *)indexPath
{
    [self openOrCloseCellWithTouchType:HmCodeSendTouch forIndexPath:indexPath];
}

-(void)reloadData
{
//    _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    [self.tableV reloadData];
}

- (void)mRegisterNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [self.tableV registerNib:nib forCellReuseIdentifier:identifier];
}

- (UITableViewHeaderFooterView *)mDequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier {
    return [self.tableV dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

- (void)mRegisterClass:(nullable Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.tableV registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    [self.tableV reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

#pragma mark -- Private Methods

/**
 *  为视图添加点击手势监听
 *
 *  @param view   要监听的视图
 *  @param action 方法名
 */
- (void)addTapGestureRecognizerForView:(UIView *)view action:(SEL)action
{
    if (view) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewCellTouchUpInside:)];
        [view addGestureRecognizer:tapGesture];
    }
}

/**
 *  从视图移除点击手势监听
 *
 *  @param view 要移除监听的视图
 */
- (void)removeTapGestureRecognizerFromView:(UIView *)view
{
    if (view) {
        for (UIGestureRecognizer *gesture in view.gestureRecognizers) {
            if ([gesture.view isEqual:view]) {
                [view removeGestureRecognizer:gesture];
            }
        }
    }
}



#pragma mark -- Private Operation For Header Open & Close

/**
 *  创建待插入NSIndexPath数组
 *
 *  @param section header 索引
 *
 *  @return 待删除NSIndexPath数组
 */
- (NSMutableArray *)buildInsertRowWithSection:(NSInteger)section
{
    NSInteger insert = [self invoke_numberOfRowsInSection:section];
    
    if (insert != 0) {
        [self invoke_willOpenHeaderAtSection:section];
    }
    
    _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:section];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < insert; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}

/**
 *  创建待删除NSIndexPath数组
 *
 *  @param section header 索引
 *
 *  @return 待删除NSIndexPath数组
 */
- (NSMutableArray *)buildDeleteRowWithSection:(NSInteger)section
{
    NSInteger delete = [self invoke_numberOfRowsInSection:section];
    
    if (delete != 0) {
        [self invoke_willCloseHeaderAtSection:section];
    }
    
    if (section == self.openedIndexPath.section) {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    }
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < delete; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:section]];
    }
    
    return indexPaths;
}

/**
 *  展开或关闭列表的 Header
 *
 *  @param section header 索引
 */
- (void)openOrCloseHeaderWithSection:(NSInteger)section
{
    NSMutableArray *deleteIndexPaths = [[NSMutableArray alloc] init];
    NSMutableArray *insertIndexPaths = [[NSMutableArray alloc] init];
    
    NSInteger oldSection = self.openedIndexPath.section;
    NSInteger newSection = section;
    
    if (oldSection <= -1) {
        // 当前列表header是关闭状态
        if (oldSection != newSection) {
            // 展开newSection
            insertIndexPaths = [self buildInsertRowWithSection:newSection];
        }
    }
    else
    {
        // 当前列表header是展开状态
        if (oldSection != newSection && newSection > -1) {
            // 关闭oldSection && 展开 newSection
            deleteIndexPaths = [self buildDeleteRowWithSection:oldSection];
            insertIndexPaths = [self buildInsertRowWithSection:newSection];
        }
        else
        {
            // 关闭oldSection && 还原 oldSection = -1
            deleteIndexPaths = [self buildDeleteRowWithSection:oldSection];
        }
    }
    
    [self.tableV beginUpdates];
    if (insertIndexPaths.count > 0) {
        [self.tableV insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    if (deleteIndexPaths.count > 0) {
        [self.tableV deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    [self.tableV endUpdates];
}

#pragma mark -- Private Operation For Row Open & Close

/**
 *  创建待reload NSIndexPath 数组 For insert atomView
 *
 *  @param row row 索引
 *
 *  @return 待reload NSIndexPath 数组
 */
- (NSMutableArray *)buildWillOpenRowsWithRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:self.openedIndexPath.section];
    
    [self invoke_willOpenRowAtIndexPath:indexPath];
    
    _openedIndexPath = indexPath;
    
    return [NSMutableArray arrayWithObject:indexPath];
}

/**
 *  创建待reload NSIndexPath 数组 for close atomView
 *
 *  @param row row 索引
 *
 *  @return 待reload NSIndexPath 数组
 */
- (NSMutableArray *)buildWillCloseRowsWithRow:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:(long)self.openedIndexPath];
    
    [self invoke_willCloseRowAtIndexPath:indexPath];
    
    if (row == self.openedIndexPath.row) {
        _openedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:self.openedIndexPath.section];
    }
    
    return [NSMutableArray arrayWithObject:indexPath];
}

/**
 *  展开或关闭列表的 Row
 *
 *  @param row Row 索引
 */
- (void)openOrCloseCellWithRow:(NSInteger)row
{
    NSMutableArray *reloadIndexPaths = [NSMutableArray array];
    
    NSInteger oldRow = self.openedIndexPath.row;
    NSInteger newRow = row;
    
    if (oldRow <= -1) {
        // 当前列表Row是全部关闭状态
        if (oldRow != newRow) {
            // 展开newRow
            reloadIndexPaths = [self buildWillOpenRowsWithRow:newRow];
        }
    }
    else
    {
        // 当前列表Row是一个展开状态
        if (oldRow != newRow) {
            // 关闭oldRow && 展开newRow
            [reloadIndexPaths addObjectsFromArray:[self buildWillCloseRowsWithRow:oldRow]];
            [reloadIndexPaths addObjectsFromArray:[self buildWillOpenRowsWithRow:newRow]];
        }
        else
        {
            // 关闭oldRow && 还原 oldRow = -1
            reloadIndexPaths = [self buildWillCloseRowsWithRow:oldRow];
        }
    }
    [self.tableV reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark -- Private Operation For Row & Header

/**
 *  展开或关闭列表的Cell Or Header
 *
 *  @param touchType 展开操作触发的来源类型
 *  @param indexPath Cell 和 Header 索引路径
 */
- (void)openOrCloseCellWithTouchType:(HmLineTouchType)touchType forIndexPath:(NSIndexPath *)indexPath
{
    switch (touchType) {
        case HmHeaderLineTouch:
            [self openOrCloseHeaderWithSection:indexPath.section];
            break;
        case HmCellLineTouch:
            [self openOrCloseCellWithRow:indexPath.row];
            break;
        case HmCodeSendTouch:
            if (indexPath.section != self.openedIndexPath.section) {
                [self openOrCloseHeaderWithSection:indexPath.section];
                
                double delayInSeconds = 0.4;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [self openOrCloseCellWithRow:indexPath.row];
                });
            }
            else
            {
                [self openOrCloseCellWithRow:indexPath.row];
            }
            break;
        default:
            break;
    }
}

#pragma mark -- Touch Selector

/**
 *  列表头点击时触发
 *
 *  @param gesture Tap Gesture Recognizer
 */
- (void)tableViewHeaderTouchUpInside:(UITapGestureRecognizer *)gesture
{
    NSInteger section = gesture.view.tag;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:-1 inSection:section];
    
    [self openOrCloseCellWithTouchType:HmHeaderLineTouch forIndexPath:indexPath];
}

/**
 *  列表点击时触发
 *
 *  @param gesture Tap Gesture Recognizer
 */
- (void)tableViewCellTouchUpInside:(UITapGestureRecognizer *)gesture
{
    // 判断点击区域
    UITableViewCell *cell = (UITableViewCell *)gesture.view;
    NSIndexPath *indexPath = [self.tableV indexPathForCell:cell];
    
    CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
    CGFloat w = cell.bounds.size.width;
    CGRect rect = CGRectMake(0, 0, w, h);
    CGPoint point = [gesture locationInView:cell];
    if (CGRectContainsPoint(rect, point)) {
        if (self.atomView) {
            [self openOrCloseCellWithTouchType:HmCellLineTouch forIndexPath:indexPath];
        }
        [self invoke_didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- Table View Delegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self addTapGestureRecognizerForView:cell action:@selector(tableViewCellTouchUpInside:)];
    
    if ([self.openedIndexPath compare:indexPath] == NSOrderedSame) {
        CGFloat atomViewHeight = [self invoke_heightForAtomAtIndexPath:indexPath];
        CGFloat cellViewHeight = [self invoke_heightForRowAtIndexPath:indexPath];
        self.atomView.frame = CGRectMake(self.atomOrigin.x, self.atomOrigin.y + cellViewHeight, cell.bounds.size.width, atomViewHeight);
        
        [cell addSubview:self.atomView];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self removeTapGestureRecognizerFromView:cell];
    
    if ([cell.subviews containsObject:self.atomView]) {
        [self.atomView removeFromSuperview];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = [self invoke_heightForRowAtIndexPath:indexPath];
    
    if ([self.openedIndexPath compare:indexPath] == NSOrderedSame) {
        h += [self invoke_heightForAtomAtIndexPath:indexPath];
    }
    
    return h;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [self invoke_viewForHeaderInSection:section];
    
    if (view) {
        CGFloat height = [self tableView:tableView heightForHeaderInSection:section];
        CGRect frame = CGRectMake(0, 0, tableView.bounds.size.width, height);
        view.frame = frame;
        view.tag = section;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewHeaderTouchUpInside:)];
        [view addGestureRecognizer:tapGesture];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self invoke_heightForHeaderInsection:section];
    }
    else
    {
        return 0;
    }
}

#pragma mark -- Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)] && self.openedIndexPath.section != section) {
        return 0;
    }
    
    NSInteger n = 0;
    n = [self invoke_numberOfRowsInSection:section];
    return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self invoke_cellForRowAtIndexPath:indexPath];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self invoke_numberOfSectionsInTableView];
}

#pragma mark -- Invoke Delegate

- (CGFloat)invoke_heightForHeaderInsection:(NSInteger)section
{
    NSInteger h = 0;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:heightForHeaderInSection:)]) {
        h = [self.delegate mTableView:self heightForHeaderInSection:section];
    }
    return h;
}

- (CGFloat)invoke_heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = kDefultHeightForRow;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:heightForRowAtIndexPath:)]) {
        h = [self.delegate mTableView:self heightForRowAtIndexPath:indexPath];
    }
    return h;
}

- (CGFloat)invoke_heightForAtomAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h = kDefultHeightForAtom;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:heightForAtomAtIndexPath:)]) {
        h = [self.delegate mTableView:self heightForAtomAtIndexPath:indexPath];
    }
    return h;
}

- (UIView *)invoke_viewForHeaderInSection:(NSInteger)section
{
    UIView *view = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:viewForHeaderAtSection:)]) {
        view = [self.delegate mTableView:self viewForHeaderAtSection:section];
    }
    return view;
}

- (void)invoke_willOpenHeaderAtSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:willOpenHeaderAtSection:)]) {
        [self.delegate mTableView:self willOpenHeaderAtSection:section];
    }
}

- (void)invoke_willCloseHeaderAtSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:willCloseHeaderAtSection:)]) {
        [self.delegate mTableView:self willCloseHeaderAtSection:section];
    }
}

- (void)invoke_willOpenRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:willOpenRowAtIndexPath:)]) {
        [self.delegate mTableView:self willOpenRowAtIndexPath:indexPath];
    }
}

- (void)invoke_willCloseRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:willCloseRowAtIndexPath:)]) {
        [self.delegate mTableView:self willCloseRowAtIndexPath:indexPath];
    }
}

- (void)invoke_didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(mTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate mTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- Invoke DataSource

- (NSInteger)invoke_numberOfRowsInSection:(NSInteger)section
{
    NSInteger n = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView:numberOfRowsInSection:)]) {
        n = [self.dataSource mTableView:self numberOfRowsInSection:section];
    }
    return n;
}

- (UITableViewCell *)invoke_cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(mTableView:cellForRowAtIndexPath:)]) {
        cell = [self.dataSource mTableView:self cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (NSInteger)invoke_numberOfSectionsInTableView
{
    NSInteger n = 1;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        n = [self.dataSource numberOfSectionsInTableView:self];
    }
    return n;
}

@end



