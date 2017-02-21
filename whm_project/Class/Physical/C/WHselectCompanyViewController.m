//
//  WHselectCompanyViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/13.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHselectCompanyViewController.h"
#import "insuranceCollectionViewCell.h"
#import "completeTableViewCell.h"
#import "CMIndexBar.h"
#import "JwDataService.h"
#import "WHhotcompany.h"
#import "JGProgressHelper.h"
#import <UIImageView+WebCache.h>
#import "JwCompanys.h"
#import "NSString+PinYin.h"
#import "WHinstruTypeTableViewController.h"
#define kScreenW [[UIScreen mainScreen] bounds].size.width

#define HmCompanyTabelCellIdentifier @"HmCompanyTabelCellIdentifier"
#define HmCompanyCollecteI @"HmCompanyCollecteIdentifier"

#import "HmCompanyTableCell.h"
#import "HmCompanyCollectionCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "HmHotCompanyCell.h"
#import "WHproductSearchTableViewController.h"


@interface WHselectCompanyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,CMIndexBarDelegate>
{
    CMIndexBar *indexBar;
}
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UILabel *hotLab;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout * layout;
// 组头
@property (nonatomic, strong) NSArray *groupsTitle;
@property (nonatomic, strong) NSMutableArray *hotNameArr;
@property (nonatomic,strong)NSMutableArray *allArr;
@property (nonatomic,strong)NSMutableArray *firstArr;
@property (nonatomic,strong)NSMutableDictionary * dic;
// 每组内容
@property (nonatomic, strong) NSArray *contentsRow;
//
@property (nonatomic,strong)NSMutableDictionary * dic1;

@end

@implementation WHselectCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.title = @"选择公司";
    
    _groupsTitle = [NSArray array];
    _contentsRow = [NSArray array];
    _hotNameArr = [NSMutableArray array];
    _allArr = [NSMutableArray array];
    _firstArr =[NSMutableArray array];
    
    [self shuju];
    
    [self getData];
    

}
-(void)getData
{
    id hud = nil;
    hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.dataService get_hot_companyWithsuccess:^(NSArray *lists) {
        [hud hide:YES];
        for (WHhotcompany *model in lists)
        {
            [_hotNameArr addObject:model];
            
        }
        [self setUI];
    } failure:^(NSError *error) {
        
        [hud hide:YES];
        [JGProgressHelper showError:nil inView:self.view];
    }];
    
    
    [self.dataService getprocomWithIshasrate:@"1" success:^(NSArray *lists) {
        for (JwCompanys * model in lists)
        {
            [_allArr addObject:model];
        }
        
        NSArray * ary = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        
        //数据处理
        self.dic = [NSMutableDictionary dictionaryWithCapacity:0];
        
        for (NSString * str in ary)
        {
            NSMutableArray * modelAry = [@[] mutableCopy];
            for (JwCompanys * model in _allArr)
            {
                if ([[model.name getFirstLetter] isEqualToString:str])
                {
                    [modelAry addObject:model];
                }
            }
            if (modelAry.count != 0) {
                NSDictionary * smallDic = @{str : modelAry};
                [self.dic addEntriesFromDictionary:smallDic];
                [_firstArr addObject:str];
            }
            
            
        }
        
        
        [self createList];
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        
    }];
    //所有公司
    /*
    [self.dataService get_CompanysWithType:@"1,2" success:^(NSArray *lists)
    {
        for (JwCompanys * model in lists)
        {
            [_allArr addObject:model];
        }
        
        NSArray * ary = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        
        //数据处理
        self.dic = [NSMutableDictionary dictionaryWithCapacity:0];
        
        for (NSString * str in ary)
        {
            NSMutableArray * modelAry = [@[] mutableCopy];
            for (JwCompanys * model in _allArr)
            {
                if ([[model.name getFirstLetter] isEqualToString:str])
                {
                    [modelAry addObject:model];
                }
            }
            if (modelAry.count != 0) {
                NSDictionary * smallDic = @{str : modelAry};
                [self.dic addEntriesFromDictionary:smallDic];
                [_firstArr addObject:str];
            }
            
            
        }
        
        
        [self createList];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
        
    }];
    
    */
    
    
}

- (void)createList
{
    
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(self.view.frame.size.width-25, 30, 25.0, self.view.frame.size.height-64 - 30)];
    //    indexBar.backgroundColor = [UIColor redColor];
    indexBar.textColor = [UIColor colorWithRed:61/255.0 green:163/255.0  blue:255/255.0  alpha:1.0];
    indexBar.textFont = [UIFont systemFontOfSize:12];
    [indexBar setIndexes:_firstArr];
    //   indexBar.backgroundColor = [UIColor cyanColor];
    //    [indexBar setTextColor:[UIColor redColor]];
    indexBar.delegate = self;
    [self.view addSubview:indexBar];
    
}
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title{
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    
}
-(void)shuju
{
    self.groupsTitle = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    self.contentsRow = @[@"日本",@"韩国",@"美国",@"南非",@"英国",@"加拿大"];
    
}
-(void)setUI
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, (kScreenW - 2)/3*2+1+30)];
    self.headView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_headView];
    
    
    self.hotLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    self.hotLab.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1.0];
    self.hotLab.font = [UIFont systemFontOfSize:12];
    self.hotLab.text = @"    热门公司";
    [self.headView addSubview:_hotLab];
    
    
    [self.headView addSubview:self.collectionView];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"completeCell"];
    self.tableView.tableHeaderView = _headView;
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _firstArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        NSString * key = self.firstArr[section];
    
    return [[self.dic objectForKey:key] count];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * key = self.firstArr[indexPath.section];
    NSArray * ary = [self.dic objectForKey:key];

 JwCompanys * model = ary[indexPath.row];

WHproductSearchTableViewController * produceSearch = [[WHproductSearchTableViewController alloc]init];
produceSearch.company_id = model.id;
produceSearch.groupsArr = self.groupArr;
produceSearch.isSelectP = self.isSelects;
produceSearch.contentDic = self.contentDict;
produceSearch.fuzhiDic = self.fuzhiDict;
[self.navigationController pushViewController:produceSearch animated:YES];


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    completeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"completeCell" forIndexPath:indexPath];
    
    NSString * key = self.firstArr[indexPath.section];
    NSArray * ary = [self.dic objectForKey:key];
    JwCompanys *model = ary[indexPath.row];
    cell.headImage.contentMode = UIViewContentModeScaleAspectFit;//图片自适应
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"leixing"]] ;
    cell.titleLab.text = model.name;
    
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //OrderCityModer *order = self.countryArr[section];
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    myView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0  blue:241/255.0  alpha:1.0];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 30)];
    myLab.backgroundColor = [UIColor clearColor];
    myLab.text = _firstArr[section];
    myLab.font = [UIFont systemFontOfSize:16];
    myLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0  blue:0/255.0  alpha:1.0];
    
    [myView addSubview:myLab];
    
    
    
    return myView;
}
#pragma mark - 返回cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark - 创建collectionView并设置代理
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        //  flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部大小
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_hotLab.frame) , kScreenW, (kScreenW - 2)/3*2+1) collectionViewLayout:flowLayout];
        //修改线条颜色
        _collectionView.backgroundColor = [UIColor grayColor];
        
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((kScreenW - 2)/3, (kScreenW - 2)/3);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumLineSpacing = 1;
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumInteritemSpacing = 1;
        
        
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 , 0, 0);//上左下右
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[insuranceCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        //[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        //        _collectionView.backgroundColor = [UIColor redColor];
        //自适应大小
        //_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        
    }
    return _collectionView;
}
#pragma mark - UICollectionView delegate dataSource
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
    
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    insuranceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    [cell sizeToFit];
    WHhotcompany *model = _hotNameArr[indexPath.row];
    cell.completeImage.contentMode = UIViewContentModeScaleAspectFit;//图片自适应
    [cell.completeImage sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"leixing"]] ;
    cell.completeLab.text = model.short_name;
    
    
    //    //cell.layer.borderColor = [UIColor colorWithRed:118/255.0 green:118/255.0  blue:118/255.0  alpha:1.0].CGColor;
    //
    //    //cell.layer.borderWidth=0.3;
    //    cityOtherModer *model = _myCarr[indexPath.row];
    //    cell.cheseLab.text = model.name;
    //
    //    //如果collect是选中状态则设置为不选中状态
    //    for (id obj in cell.subviews)
    //    {
    //        if ([obj isKindOfClass:[UIImageView class]])
    //        {
    //
    //            [obj removeFromSuperview];
    //            [_temporaryArr removeAllObjects];
    //        }
    //    }
    
    return cell;
}

#pragma mark UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选择%ld",(long)indexPath.item);
    
    
//    
//    UIImageView *seleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 24)];
//    seleView.image = [UIImage imageNamed:@"xzfwcx-2"];
//    
//    
//    JwCompanys *model = _hotNameArr[indexPath.row];
//    
//    
//    
//    WHinstruTypeTableViewController * instru = [[WHinstruTypeTableViewController alloc]init];
//    instru.companyid = model.id;
//    [self.navigationController pushViewController:instru animated:YES];
    
//
//    __weak WHselectCompanyViewController * myself = self;
//
//    
//    WHproductSearchTableViewController *VC = [[WHproductSearchTableViewController alloc] init];
//    
//    JwCompanys * model = _hotNameArr[indexPath.row];
//    
//    
////    
////    VC.company_id = selectCompany.id;
//    VC.company_id = model.id;
//
//    VC.groupsArr = self.groupArr;
//    VC.isSelectP = self.isSelects;
//    VC.contentDic = self.contentDict;
//    VC.fuzhiDic = self.fuzhiDict;
//    
//    VC.myBlock5 = ^(NSString * name1,NSMutableArray * groupsArr1,BOOL isSelectP1)
//    {
//        
//        
//        myself.myBlock4(name1,groupsArr1,isSelectP1);
//        
//        
//    };
    
    
       
    //[self.navigationController pushViewController:VC animated:YES];

}



+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
