//
//  WHcoverageViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcoverageViewController.h"
#import "WHcoverTableViewCell.h"
#import "MacroUtility.h"
#import "WHgetproducedetalViewController.h"
#import "WHcompanyDetail.h"
#import "WHhot_pro.h"
#import "JGProgressHelper.h"
#import "WHJSCollectViewController.h"
#import <UIImageView+WebCache.h>
#import "WHloveagentTableViewCell.h"
#import "WHagent.h"


@interface WHcoverageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHcoverTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)WHloveagentTableViewCell * cell1;
@property(nonatomic,strong)NSMutableArray * peopArry;
@property(nonatomic,strong)NSString * tel;

@end

@implementation WHcoverageViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self quartDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];


    
}
//数据请求
-(void)quartDate
{
    NSLog(@"%@",self.com_id);
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_company_detailWithCom_id:self.com_id
                                               uid:@"" success:^(NSArray * lists){
        [hud hide:YES];
        
        self.dataArry =  [NSMutableArray arrayWithArray:lists];
                                                   WHcompanyDetail * det = [lists firstObject];
                                                   self.dataArry = [NSMutableArray arrayWithArray:det.hot_pro];
                                                   self.peopArry = [NSMutableArray arrayWithArray:det.agent];
                                                   
                                                   
                                                   [self.tableV reloadData];
                                                   
                                                   
                                                   NSLog(@"%@",self.dataArry);
        
      //  NSLog(@"%@",userInfo);
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}


//设计界面
-(void)setupUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWitdh, kScreenHeight *0.6 - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHcoverTableViewCell class] forCellReuseIdentifier:@"cell"];
    //
     [self.tableV registerClass:[WHloveagentTableViewCell class] forCellReuseIdentifier:@"cell1"];

    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return  self.dataArry.count;

    }
    else
    {
        return self.peopArry.count;
    }
  
}

//组头部
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
          return @"推荐险种";
    }
    else
    {
        return @"最受欢迎代理人";
    }
  
}
//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

//数据处理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    
    WHcoverTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WHhot_pro * model = self.dataArry[indexPath.row];

    cell.titLaber.text = model.name;
    cell.ageTitle.text = model.limit_age;
    cell.seyTitle.text = model.pro_type_code_name;
    [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    NSInteger stateM = [model.is_main integerValue];
    switch (stateM) {
        case 1:
            cell.myImg.image =[UIImage imageNamed:@"p_zhu"];
            break;
        case 2:
            cell.myImg.image = [UIImage imageNamed:@"p_huangfu"];
            break;
        case 3:
            cell.myImg.image = [UIImage imageNamed:@"p_group"];
            break;
            
        default:
            break;
    }

    return cell;
    }
    else
    {
        WHloveagentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        //cell.textLabel .text = @"大笨蛋";
        cell.model = self.peopArry[indexPath.row];
        [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
        cell.telBut.tag = 100 + indexPath.row;
        [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    
}

-(void)telAction:(UIButton *)sender
{
    WHagent * model = self.peopArry[sender.tag - 100];
    self.tel = model.mobile;
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];

    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
       
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
