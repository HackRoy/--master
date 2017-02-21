//
//  HMConfirmView.m
//  selectConfirm
//
//  Created by zhaoHm on 16/8/8.
//  Copyright © 2016年 zhaoHm. All rights reserved.
//

#import "HMConfirmView.h"

#define MZero 0
#define MScreenW [[UIScreen mainScreen] bounds].size.width
#define MScreenH [[UIScreen mainScreen] bounds].size.height
#define MIdentifier @"selectItemTableViewCell"

@interface HMConfirmView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HMConfirmView *unusedV;

//@property (nonatomic, weak) void(^block)(NSInteger index);
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) UITableViewCell *cell;


/**
 *  BackView
 */
@property (nonatomic, strong) UIView *backV;
/**
 *  Container View
 */
@property (nonatomic, strong) UIView *ContainerV;
/**
 *  Title
 */
@property (nonatomic, strong) UILabel *lblTitle;
/**
 *  TableView
 */
@property (nonatomic, strong) UITableView *tableV;
/**
 *  Confirm Btn
 */
@property (nonatomic, strong) UIButton *btnConfirm;
/**
 *  Cancel Btn
 */
@property (nonatomic, strong) UIButton *btnCancel;
/**
 *  Center Point
 */
@property (nonatomic, strong) UIButton *myButton;

@end

@implementation HMConfirmView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// 在调用 -drawRect 之前,一定要考虑是不是要为view自定义绘制任务,如果没有,就不要在子类当中实现(或者空的) -drawRect方法,因为系统一旦检测到 -drawRect方法被调用了,系统就会为视图分配一个寄宿图(view.layer.contents),这个寄宿图的像素尺寸等于视图大小 乘以 contentsScale 的值.  如果不使用,就会造成CPU自愿和内存的浪费.
-(void)drawRect:(CGRect)rect
{
    self.backgroundColor = [UIColor clearColor];
    // setup UI
    [self setupUI];
}

/**
*  setup UI
*/
-(void)setupUI
{
    // BackView
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(MZero, MZero, MScreenW, MScreenH)];
    backV.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    [self addSubview:backV];
    self.backV = backV;
    
    // Container View
    CGFloat containerVW = CGRectGetWidth(self.backV.frame) * 0.9;
    CGFloat containerVH = CGRectGetHeight(self.backV.frame) * 0.8;
    CGFloat containerVX = (MScreenW - containerVW) * 0.2;
    CGFloat containerVY = (MScreenH - containerVH - 64) * 0.2;
    UIView *containerV = [[UIView alloc] initWithFrame:CGRectMake(containerVX+10, containerVY, containerVW, containerVH)];
    containerV.backgroundColor = [UIColor whiteColor];
    containerV.layer.cornerRadius = 5;
    containerV.layer.masksToBounds = YES;
    [self.backV addSubview:containerV];
    self.ContainerV = containerV;
    
    // Title
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(MZero + 10, MZero, CGRectGetWidth(containerV.frame), 30)];
    lblTitle.backgroundColor = [UIColor clearColor];
    [self.ContainerV addSubview:lblTitle];
    self.lblTitle = lblTitle;
    lblTitle.text = (self.title) ? _title : @"请选择分组";
    lblTitle.textColor = (self.titleColor) ? _titleColor : [UIColor blackColor];
    lblTitle.font = (self.titleFont) ? _titleFont : [UIFont systemFontOfSize:15];
    
    // TableView
    UITableView *tableV = [[UITableView alloc] initWithFrame:CGRectMake(MZero, CGRectGetMaxY(lblTitle.frame), CGRectGetWidth(containerV.frame), CGRectGetHeight(containerV.frame) - CGRectGetHeight(lblTitle.frame) - 50) style:UITableViewStylePlain];
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:MIdentifier];
    tableV.backgroundColor = [UIColor clearColor];
    tableV.delegate = self;
    tableV.dataSource = self;
    [self setExtraCellLineHidden:tableV];
//    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.ContainerV addSubview:tableV];
    self.tableV = tableV;
    
    // Cancel Btn
    CGFloat btnW = (CGRectGetWidth(self.ContainerV.frame) - 10 * 4) / 2;
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnCancel.layer setBorderWidth:1.0];
    [btnCancel.layer setBorderColor:[UIColor blackColor].CGColor];
    btnCancel.layer.cornerRadius = 5;
    btnCancel.layer.masksToBounds = YES;
    btnCancel.frame = CGRectMake(10, CGRectGetMaxY(self.tableV.frame) + 10, btnW, 30);
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ContainerV addSubview:btnCancel];
    self.btnCancel = btnCancel;
    
    // Confirm Btn
    UIButton *btnConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnConfirm.layer setBorderWidth:1.0];
    [btnConfirm.layer setBorderColor:[UIColor blackColor].CGColor];
    btnConfirm.layer.cornerRadius = 5;
    btnConfirm.layer.masksToBounds = YES;
    btnConfirm.frame = CGRectMake(CGRectGetMaxX(btnCancel.frame) + 20, CGRectGetMaxY(self.tableV.frame) + 10, btnW, 30);
    [btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
    [btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnConfirm addTarget:self action:@selector(btnConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ContainerV addSubview:btnConfirm];
    self.btnConfirm = btnConfirm;
    
}

-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}


#pragma mark -- UITABLE DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:MIdentifier];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MIdentifier];
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    _cell.textLabel.text = _itemArr[indexPath.row];
    

    

    _cell.accessoryView = ({
        UIButton *btnV = [UIButton buttonWithType:UIButtonTypeCustom];
        btnV.frame = CGRectMake(0, 0, 20, 20);
        [btnV setImage:[UIImage imageNamed:@"check_no"] forState:UIControlStateNormal];
        [btnV addTarget:self action:@selector(btnVAction:) forControlEvents:UIControlEventTouchUpInside];
        btnV.tag = indexPath.row;
        btnV;
    });
    return _cell;
}

-(void)btnVAction:(UIButton *)btn
{
    // 取消上次选中的
    if (_myButton != nil) {
        // myindexPath有值
        [_myButton setImage:[UIImage imageNamed:@"check_no"] forState:UIControlStateNormal];
    }
    // changes
    [btn setImage:[UIImage imageNamed:@"check_yse"] forState:UIControlStateNormal];
    _myButton = btn;
    _index = btn.tag;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (id btn in cell.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (_myButton != nil) {
                [_myButton setImage:[UIImage imageNamed:@"check_no"] forState:UIControlStateNormal];
            }
            [((UIButton *)btn) setImage:[UIImage imageNamed:@"check_yse"] forState:UIControlStateNormal];
            _myButton = (UIButton *)btn;
            _index = ((UIButton *)btn).tag;
        }
    }
}


/**
 *  cancel button
 */
-(void)btnCancelAction:(UIButton *)sender
{
    // delegate for cancel action
    if ([self.delegate respondsToSelector:@selector(cancelActionWithNothing)]) {
        [self.delegate cancelActionWithNothing];
    }
}

/**
 *  confirm button
 */
-(void)btnConfirmAction:(UIButton *)sender
{
    // return index of itemArr
    // delegate for confirm action
    if ([self.delegate respondsToSelector:@selector(confirmActionWithIndexOfArr:SelectName:Key:)]) {
//        [self.delegate confirmActionWithIndexOfArr:_index];
        if (_itemArr.count != 0) {
            [self.delegate confirmActionWithIndexOfArr:_index SelectName:_itemArr[_index] Key:_key];
        }else {
            [self.delegate confirmActionWithIndexOfArr:_index SelectName:@"" Key:_key];
        }
    }
}

@end
