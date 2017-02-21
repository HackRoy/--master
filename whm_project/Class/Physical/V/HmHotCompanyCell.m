//
//  HmHotCompanyCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmHotCompanyCell.h"
#import "UIColor+Hex.h"
#import "MacroUtility.h"
#import "WHproductSearchTableViewController.h"


#define HmCompanyCollectionCellIdentifier @"HmCompanyCollectionCellIdentifier"
#define HmCompanyW (kScreenWitdh - 3) / 3
#define HmCompanyH HmCompanyW

@interface HmHotCompanyCell ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) void(^blockPush)(WHhotcompany *selectCompany);

@end

@implementation HmHotCompanyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCollectionViewLayout];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

-(void)setupCollectionViewLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置布局方向 垂直
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 1.5;
    layout.minimumLineSpacing = 1.5;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(HmCompanyW, HmCompanyH);
    // 通过一个布局策略layout来创建一个collectionView
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, HmCompanyH * 2 + 1.5) collectionViewLayout:layout];
    // 设置代理
    _collectionV.delegate = self;
    _collectionV.dataSource = self;
    _collectionV.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [self.contentView addSubview:_collectionV];
}

#pragma mark -- Collection View Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.hotCompanyArr.count <= 0) {
        return 0;
    }
    else if (self.hotCompanyArr.count >0 && self.hotCompanyArr.count <=6)
    {
        return self.hotCompanyArr.count;
    }
    else
    {
        return 6;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmCompanyCollectionCell class]) bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:HmCompanyCollectionCellIdentifier];
        nibsRegistered = YES;
    }
    HmCompanyCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HmCompanyCollectionCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.model = self.hotCompanyArr[indexPath.row];
    return cell;
}

//选择热门公司事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WHhotcompany * model = self.hotCompanyArr[indexPath.row];
    
    if (self.blockPush) {
        self.blockPush(model);
    }

}

-(void)hotCompanyPushToNext:(void (^)(WHhotcompany *))block
{
    self.blockPush = block;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
