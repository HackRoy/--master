//
//  WBYwdzwViewController.m
//  whm_project
//
//  Created by apple on 17/2/8.
//  Copyright © 2017年 chenJw. All rights reserved.
//
#import "WBYwdzwViewController.h"
#import "MJRefresh.h"
#import "WBYcaiwuTableViewCell.h"
#import "UIColor+Hex.h"
#import "WHgetvited.h"
#import <UIImageView+WebCache.h>
#import "WHjiluTableViewCell.h"
#import "WHzhangwuListTableViewController.h"
#import "MacroUtility.h"
#import "WHtixianViewController.h"
#import "WHshenheViewController.h"
#import "WBYKFPViewController.h"

#import "WHgetcash.h"

@interface WBYwdzwViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * allArray;
    NSArray * myArr;
    NSInteger numindex;
    NSInteger numindex1;

    UIView * caiwuView;
    UITableView *tableV;
    UILabel * moneyNum;
    UILabel * coinNum;
    UITableView * tableB;
    NSMutableArray * jiluArray;
    UIView* customView;
    UILabel * blackLaber;
    
}
@property(nonatomic,strong)UIView * noDateView;
@property(nonatomic,strong)UIImageView * noDateImg;

@property(nonatomic,assign)BOOL isTuiJian;


@end

@implementation WBYwdzwViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    allArray = [NSMutableArray array];
    numindex =  1;
    numindex1 =  1;

    myArr = [NSArray array];
    jiluArray = [NSMutableArray array];
   
    _isTuiJian = YES;
    
    if ([self.strJiLu isEqualToString:@"1"])
    {
//        [self creatRequJilu];
        [self caiwujilu];
        
        [self creatLeftTtem];
        [self creattopView];
    }
    else
    {
    [self creatLeftTtem];
    [self creattopView];
    [self creatRequest];
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
         numindex = 1;
    numindex1 = 1;
}
-(void)headerRereshing
{

//    [self creatRequest];
    
    if (_isTuiJian==YES)
    {    numindex = 1 ;

        [self creatRequest];
        
    }
    else
    {    numindex1 = 1;

        [self caiwujilu];
  
    }
    
    [tableV headerEndRefreshing];
    [tableB headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    if (_isTuiJian==YES)
    {
        numindex ++ ;

        [self creatRequest];
     }
    else
    {
        numindex1 ++;

        [self caiwujilu];
        
    }
    [tableV footerEndRefreshing];
    [tableB footerEndRefreshing];
}

-(void)creattopView
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 22, wScreenW, 44)];
   
    self.navigationItem.titleView = bgView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发票" style:UIBarButtonItemStylePlain target:self action:@selector(fapiao)];
    UIView * litView = [[UIView alloc] initWithFrame:CGRectMake(60, 8, 120, 34-6)];
    [bgView addSubview:litView];
    
    UISegmentedControl*segement=[[UISegmentedControl alloc] initWithItems:@[@"账务",@"记录"]];
    
    segement.frame =CGRectMake(0, 0, 120, 34-6);
    if ([self.strJiLu isEqualToString:@"1"])
    {
        segement.selectedSegmentIndex = 1;
    }
    else
    {
    segement.selectedSegmentIndex=0;
    }
    segement.layer.borderColor=wBlue.CGColor;
    segement.layer.borderWidth=2;
    segement.tintColor = [UIColor whiteColor];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:wBlue,NSForegroundColorAttributeName,
                         [UIFont boldSystemFontOfSize:14],
                         NSFontAttributeName,nil];
    
    [segement setTitleTextAttributes:dic forState:UIControlStateSelected];
    
       NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:wWhiteColor,
                          NSForegroundColorAttributeName,
                          [UIFont boldSystemFontOfSize:14],
                          NSFontAttributeName,nil];
    
    [ segement setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    [segement addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [litView addSubview:segement];
}

-(void)change:(UISegmentedControl*)segment
{
    NSInteger index=segment.selectedSegmentIndex;
    
    [tableB removeFromSuperview];
    [tableV removeFromSuperview];
    

    if (index==0)
    {
        _isTuiJian = YES;
        [self creatRequest];;
    }
    else
    {
        _isTuiJian = NO;
        [self caiwujilu];
    }
    
}

-(void)creatjilu
{
    [tableB removeFromSuperview];
    [tableV removeFromSuperview];
    
    
    if (jiluArray.count >= 1)
    {
    //DataModel * mod = jiluArray[0];
    tableB = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    tableB.delegate = self;
    tableB.dataSource = self;
    [tableB addHeaderWithTarget:self action:@selector(headerRereshing)];
    [tableB addFooterWithTarget:self action:@selector(footerRefreshing)];
    [tableB registerClass:[WHjiluTableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableB setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:tableB];

    }else
    {
        [WBYRequest showMessage:@"没有数据"];
    }
    
}

//数据请求记录

-(void)caiwujilu
{
        id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService caiwujiluWithInvited_uid:[NSString stringWithFormat:@"%ld",numindex1] pagesize:@"10" uid:[JwUserCenter sharedCenter].uid success:^(NSArray * lists)
     {
         [hud hide:YES];
        
         if (numindex1 == 1)
         {
             [jiluArray removeAllObjects];
         }
         
         [jiluArray addObjectsFromArray:lists];
         
         [self creatjilu];
         
         if (jiluArray.count < 1)
         {
             [WBYRequest showMessage:@"没有更多数据"];
             [self noneView];
         }
         [tableB reloadData];
    } failure:^(NSError *error)
    {
        [hud hide:YES];

    }];
    
    
    
}
//-(void)creatRequJilu
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:[WBYRequest jiami:@"kbj/get_finance"] forKey:@"kb"];
//    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
//    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
//    [dic setObject:@"10" forKey:@"pagesize"];
//    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
//    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_finance" addParameters:dic success:^(WBYReqModel *model) {
//        if ([model.err isEqualToString:SAME]) {
//            TONGZHI
//        }
//        if ([model.err isEqualToString:TURE ])
//        {
//            if (numindex == 1)
//            {
//                [jiluArray removeAllObjects];
//            }
//            
//            [jiluArray addObjectsFromArray:model.data];
//            
//            
//            [self creatjilu];
//            
//            if (jiluArray.count < 1)
//            {
//                [WBYRequest showMessage:@"没有更多数据"];
//                [self noneView];
//            }
//        }
//        
//        [tableB reloadData];
//    } failure:^(NSError *error) {
//        
//    } isRefresh:NO];
//    
//    
//}
-(void)noneView
{
     [self.noDateView removeFromSuperview];
    self.noDateView = [[UIView alloc]init];
    self.noDateView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight);
    //self.noDateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodate"]];
    [self.view addSubview:_noDateView];
    self.noDateImg = [[UIImageView alloc]init];
    self.noDateImg.frame = CGRectMake(10, 10, kScreenWitdh-20, kScreenWitdh-40);
    [self.noDateView addSubview:_noDateImg];
    self.noDateImg.image = [UIImage imageNamed:@"nodate"];
   
}

//账务
-(void)creatzhangwu
{
    
    [tableB removeFromSuperview];
    [tableV removeFromSuperview];
    
    
    
    if (allArray.count>=1)
    {
        DataModel * mod = allArray[0];
        myArr = mod.invited;
    
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, (wScreenH-64)/3 )];
        UIImageView * jinQianImg = [[UIImageView alloc]init];
        jinQianImg.frame = CGRectMake(wScreenW * 0.21 , 20, wScreenW * 0.08, wScreenW * 0.08);
        jinQianImg.image = [UIImage imageNamed:@"jinqian"];
        [aView addSubview:jinQianImg];
    moneyNum = [[UILabel alloc]init];
    moneyNum.frame = CGRectMake(wScreenW * 0.1, CGRectGetMaxY(jinQianImg.frame)+10, wScreenW * 0.3, CGRectGetHeight(jinQianImg.frame));
    moneyNum.text = mod.money;
    moneyNum.textColor = [UIColor redColor];
    moneyNum.textAlignment = NSTextAlignmentCenter;
    [aView addSubview:moneyNum];
    UILabel * lab1 = [[UILabel alloc]init];
    lab1.frame = CGRectMake(CGRectGetMidX(moneyNum.frame)+5, 8, 15, 10);
    lab1.text = @"元";
    lab1.textColor = [UIColor colorWithHex:0x666666];
    lab1.font = [UIFont systemFontOfSize:10];
    [moneyNum addSubview:lab1];
    UIButton * tiXianBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    tiXianBut.frame = CGRectMake(wScreenW * 0.15, CGRectGetMaxY(moneyNum.frame)+10, wScreenW * 0.2, CGRectGetHeight(moneyNum.frame));
    [tiXianBut setTitle:@"提现" forState:(UIControlStateNormal)];
        tiXianBut.layer.masksToBounds = YES;
        tiXianBut.layer.cornerRadius = 5;
    [tiXianBut setTintColor:[UIColor whiteColor]];
    tiXianBut.backgroundColor = [UIColor  colorWithHex:0x28D68E];
    tiXianBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [tiXianBut addTarget:self action:@selector(tiXianAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [aView addSubview:tiXianBut];
    UILabel * line1 = [[UILabel alloc]init];
    line1.frame = CGRectMake(wScreenW * 0.5, 10, 1, CGRectGetHeight(aView.frame )-10 -20 );
    line1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [aView addSubview:line1];
    //金币
    UIImageView *coinImg = [[UIImageView alloc]init];
    coinImg.frame = CGRectMake(wScreenW * 0.71, 20, wScreenW * 0.08, wScreenW * 0.08);
    coinImg.image = [UIImage imageNamed:@"coin"];
    [aView addSubview:coinImg];
    coinNum = [[UILabel alloc]init];
    coinNum.frame = CGRectMake(wScreenW * 0.6, CGRectGetMaxY(coinImg.frame)+10, wScreenW * 0.3, CGRectGetHeight(coinImg.frame));
    coinNum.text = mod.coin;
    coinNum.textColor = [UIColor redColor];
    coinNum.textAlignment = NSTextAlignmentCenter;
    [aView addSubview:coinNum];
    UILabel * lab2 = [[UILabel alloc]init];
    lab2.frame = CGRectMake(CGRectGetMaxX(coinNum.frame)-20, CGRectGetMinY(coinNum.frame)+8, 30, 10);
    lab2.text = @"金币";
    lab2.textColor = [UIColor colorWithHex:0x666666];
    lab2.font = [UIFont systemFontOfSize:10];
    [aView addSubview:lab2];
    
    
    UIButton * coinBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    coinBut.frame = CGRectMake(wScreenW * 0.65, CGRectGetMaxY(coinNum.frame)+10, wScreenW * 0.2, CGRectGetHeight(coinNum.frame));
    [coinBut setTitle:@"兑换" forState:(UIControlStateNormal)];
    [coinBut setTintColor:[UIColor whiteColor]];
    coinBut.backgroundColor = [UIColor grayColor];
    coinBut.titleLabel.font = [UIFont systemFontOfSize:13.0];
        coinBut.layer.masksToBounds =  YES;
        coinBut.layer.cornerRadius = 5;
        
    [coinBut addTarget:self action:@selector(coinAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [aView addSubview:coinBut];
    UILabel * line2 = [[UILabel alloc]init];
    line2.frame = CGRectMake(0, CGRectGetMaxY(line1.frame)+10, wScreenW, 1);
    line2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [aView addSubview:line2];
    
        blackLaber = [[UILabel alloc]init];
        blackLaber.frame = CGRectMake(0, CGRectGetMaxY(line2.frame), kScreenWitdh, CGRectGetMaxY(aView.frame)-CGRectGetMaxY(line2.frame));
        blackLaber.backgroundColor= [UIColor colorWithHex:0xD9D9D9];
        [aView addSubview:blackLaber];
        
        
        
        
        tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
            tableV.delegate = self;
            tableV.dataSource = self;
            [tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
            [tableV addFooterWithTarget:self action:@selector(footerRefreshing)];
           [tableV registerClass:[WBYcaiwuTableViewCell class] forCellReuseIdentifier:@"cell"];
           tableV.tableHeaderView =aView;
            tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:tableV];
        
  }
    else
    {
        [tableV removeFromSuperview];
        [WBYRequest showMessage:@"没有数据"];
    }
 }


-(void)coinAction:(UIButton *)sender
{
    
    
    
    NSLog(@"duihuan");
}

-(void)tiXianAction:(UIButton *)sender
{
    WHtixianViewController  *tixian = [[WHtixianViewController alloc]init];
    [self.navigationController pushViewController:tixian animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tableV)
    {
        return myArr.count;
    }
    else
    {
        return jiluArray.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableV)
    {
        return 75;
    }
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tableView == tableV) {

    
    customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, wScreenW, 40.0)];
    
    if (section == 0) {
        
    UIImageView * HdImg = [[UIImageView alloc]init];
    HdImg.frame = CGRectMake(5, 5, 20, 20);
    HdImg.image = [UIImage imageNamed:@"xing"];
    [customView addSubview:HdImg];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero] ;
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    
    headerLabel.textColor = [UIColor lightGrayColor];
    
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    
    headerLabel.frame = CGRectMake(30.0, 5, wScreenW-60, 20.0);
    headerLabel.text = @"我的推荐";
    headerLabel.font = [UIFont systemFontOfSize:12.0];
    
    [customView addSubview:headerLabel];
    
    UILabel * line3 = [[UILabel alloc]init];
    line3.frame = CGRectMake(0, 0, wScreenW, 1);
    line3.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [customView addSubview:line3];
    UILabel * line4 = [[UILabel alloc]init];
    line4.frame = CGRectMake(0, 38, wScreenW, 1);
    line4.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [customView addSubview:line4];
    }
    
    
    return customView;
    }
    else
    {
        [customView removeFromSuperview];
              return nil;
    }
    
}

//滑到顶部隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 44;//这里的高度是设置的sectionView的高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == tableV) {
        return 44.0;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableB)
    {
        WHjiluTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        WHgetcash * model = jiluArray[indexPath.row];        
        
        NSString * a = model.type;
        if ([a isEqualToString:@"1"]) {
            cell.headImg.image = [UIImage imageNamed:@"huoqu"];
            cell.typeLaber.text = @"元";
            cell.daiLiLaber.text = @"推荐代理人已认证";

        }else if ([a isEqualToString:@"2"])
        {
            cell.headImg.image = [UIImage imageNamed:@"jinbi"];
            cell.typeLaber.text = @"金币";
            cell.daiLiLaber.text = @"推荐代理人已认证";

        }
        else if ([a isEqualToString:@"3"])
        {
            cell.headImg.image = [UIImage imageNamed:@"tixian"];
            cell.typeLaber.text = @"元";
        }
        else
        {
            cell.headImg.image = [UIImage imageNamed:@"jinbi"];
            cell.typeLaber.text = @"金币";
            cell.daiLiLaber.text = @"商城消遣使用";

        }
       cell.moneyLaber.text = model.money;
       cell.myTitLaber.text = model.remark;
        
        NSString * timeStr =[WBYRequest timeStr:model.create_time?model.create_time:@""];
        NSString * s1 = @"时间:";
        cell.timeLaber.text = [s1 stringByAppendingString:timeStr];
        NSString * b = model.status;
        if ([b isEqualToString:@"1"]) {
            cell.applyLaber.text = @"";

        }
        if ([b isEqualToString:@"2"]) {
           cell.applyLaber.text = @"提现申请中";
           cell.daiLiLaber.text = @"提现申请中";
       }
        return cell;
        
    }
    else
    {
    
    WBYcaiwuTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WBYtjrListModel * mod= myArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
  //  cell.textLabel.text = @"HELLO";
    cell.nameLaber.text = mod.name;
    NSString * a = mod.sex;
    if ([a isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];

    }
    else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];

    }
    cell.dateLaber.text = mod.birthday;
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    NSString * b = mod.type;
    if ([b isEqualToString:@"0"]) {
        cell.renzhengLaber.text = @"普通用户";
    }
    if ([b isEqualToString:@"1"]) {
        
        if ([mod.status isEqualToString:@"0"]) {
            cell.renzhengLaber.text = @"未认证";
        }
        else if ([mod.status isEqualToString:@"1"])
        {
            cell.renzhengLaber.text = @"已认证";
        }
        else if ([mod.status isEqualToString:@"2"])
        {
            cell.renzhengLaber.text = @"认证驳回";
        }
        else
        {
            cell.renzhengLaber.text = @"审核中";
        }
       
    }
    NSInteger  c = [mod.invited_count integerValue];
    if (c <= 99) {
        cell.tuiJianNum.text = mod.invited_count;

    }
    else
    {
        cell.tuiJianNum.text = @"99+";

    }
    
    if ([mod.mobile isEqualToString:@"0" ]) {
        cell.telLaber.text = @"暂无";
    }
    cell.telLaber.text = mod.mobile? mod.mobile :@"暂无";
        return cell;
    }
    
    
  
}


-(void)fapiao
{
    WBYKFPViewController * kaifp = [[WBYKFPViewController alloc]init];
    [self.navigationController pushViewController:kaifp animated:YES];
    
}

//-(void)myRequest
//{
//    id hud = [JGProgressHelper showProgressInView:self.view];
//    
//    [self.dataService getinvitedWithInvited_uid:[JwUserCenter sharedCenter].uid p:[NSString stringWithFormat:@"%ld",numindex] pagesize:@"10" uid:[JwUserCenter sharedCenter].uid success:^(NSArray *lists)
//    {
//        [hud hide:YES];
//
//        NSLog(@"===%@",lists);
//        
//        for (WHzhanghu *model in lists)
//        {
//           
//            
//            
//            
//        }
//        
//    } failure:^(NSError *error) {
//        [hud hide:YES];
//
//        
//    }];
//    
//    
//}


-(void)creatRequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kbj/get_invited"] forKey:@"kb"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"invited_uid"];
    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"30" forKey:@"pagesize"];
    
    
    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_invited" addParameters:dic success:^(WBYReqModel *model)
    {
        
        if ([model.err isEqualToString:SAME])
        {
            TONGZHI
        }
        if ([model.err isEqualToString:TURE])
        {
            if (numindex == 1)
            {
                [allArray removeAllObjects];
            }
            [allArray addObjectsFromArray:model.data];
            [self creatzhangwu];
            if (myArr.count < 1)
            {
                [WBYRequest showMessage:@"没有更多数据"];
                [tableV removeFromSuperview];
                [self noneView];
            }
        }
        
        [tableV reloadData];
    } failure:^(NSError *error)
    {
        
    } isRefresh:NO];
    
    
    
}

//选中账务里边数据列表
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableV)
    {
        WBYtjrListModel * model= myArr[indexPath.row];
        WHzhangwuListTableViewController * zhangwu = [[WHzhangwuListTableViewController alloc]init];
        zhangwu.invited_ID = model.id;
        zhangwu.StrName = model.name;
        [self.navigationController pushViewController:zhangwu animated:YES];

    }
    else
    {
        WHgetcash * model = jiluArray[indexPath.row];
        
        WHshenheViewController * shenhe = [[WHshenheViewController alloc]init];
//        shenhe.financeID = model.id;
        
        shenhe.model = model;
        [self.navigationController pushViewController:shenhe animated:YES];
        
    }
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
