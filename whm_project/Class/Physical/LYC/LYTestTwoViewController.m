//
//  LYTestTwoViewController.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestTwoViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHtestwoTableViewCell.h"
#import "WHinterests.h"
#import "WHgetreport.h"
#import "WHsecond.h"
#import "JGProgressHelper.h"

@interface LYTestTwoViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property(nonatomic, strong) UITableView *tableV;
@property(nonatomic, strong) WHtestwoTableViewCell * cell1;
@property(nonatomic,strong) UILabel * titLaber;
@property(nonatomic,strong) UILabel * nameLaber;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * myImg;
@property(nonatomic,strong)UIImageView * phoImage;
@property(nonatomic,strong)NSMutableArray * dataArry;
//webview
@property(nonatomic,strong)NSString * s1 ;

@end

@implementation LYTestTwoViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self quretDate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];

    // 布局
    [self setupUI];
    
}
//数据请求
-(void)quretDate
{
   
    
   NSDictionary * infoDic = @{@"pro_id":self.pro_id,@"main_id":@"0",@"is_main_must":@"0", @"insured_amount":self.insured_amount,@"rate":self.rate, @"pay_period":self.pay_period,@"period":self.period,@"payout":@"1"};
    NSError * error = nil;
    
    // NSArray * array = [NSArray array];
    NSArray * array  = @[infoDic];
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString * paramStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.dataArry = [NSMutableArray array];
    
    [self.dataService getsavepolictWithUid:@""
                                   rela_id:self.rela_id
                                      pros:paramStr
                                   success:^(NSArray *lists){
                                       
                                       
                                       WHgetreport * report = [lists firstObject];
                                       for (WHsecond * second in report.second) {
                                           // NSLog(@"%@",second.interests);
                                           [self.dataArry addObjectsFromArray:second.interests];
//
                                           
                                           self.nameLaber.text = second.name;
                                           NSInteger stateM = [second.is_main integerValue];
                                           switch (stateM) {
                                               case 1:
                                                   self.myImg.image =[UIImage imageNamed:@"p_zhu"];
                                                   break;
                                               case 2:
                                                  self.myImg.image = [UIImage imageNamed:@"p_huangfu"];
                                                   break;
                                               case 3:
                                                   self.myImg.image = [UIImage imageNamed:@"p_group"];
                                                   break;
                                                   
                                               default:
                                                   break;
                                           }

                                           
                                       }
                                       [self.tableV reloadData];

                                   }failure:^(NSError *error) {
                                       
                                   }];
    
}

#pragma mark -- 布局
-(void)setupUI
{
    
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, 0, kScreenWitdh, 30);
    self.myView.backgroundColor = [UIColor colorWithHex:0x28D68E];
    [self.view addSubview:_myView];
    
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(kScreenWitdh * 0.4, 0,kScreenWitdh*0.4, 30);
    
    self.titLaber.text = @"具体利益";
    self.titLaber.textColor = [UIColor whiteColor];
    [self.myView addSubview:_titLaber];
    self.myImg = [[UIImageView alloc]init];
    self.myImg.frame = CGRectMake(10, CGRectGetMaxY(self.titLaber.frame), 30, 30);
   // self.myImg.image = [UIImage imageNamed:@"p_zhu"];
    [self.view addSubview:_myImg];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg.frame)+10, CGRectGetMinY(self.myImg.frame), kScreenWitdh * 0.6, 30);
    self.nameLaber.font = [UIFont systemFontOfSize:13.0];
    //self.nameLaber.text = @"泰康健康百分百重大疾病保险";
    self.nameLaber.textColor = [UIColor redColor];
    [self.view addSubview:_nameLaber];
    
    
    
    //
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWitdh, kScreenHeight* 0.45 - 64 ) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
   // [self.tableV  registerNib:[UINib nibWithNibName:@"WHtestwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableV registerClass:[WHtestwoTableViewCell class] forCellReuseIdentifier:@"cell1"];
    
}
//组头部
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return @"被保人权益";
        
    }
    if (1 == section) {
        return @"投保人权益";
    }
    else
    {
        return nil;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if (0 == section) {
        return self.dataArry.count;
 
    }
    
    if (1 == section) {
        return 2;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        
    WHtestwoTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        WHinterests * model = self.dataArry[indexPath.row];
    
    cell.myLaber.text = model.name;
    cell.moneyLaber.text = model.calculation;
    cell.phoImage.image = [UIImage imageNamed:@"wenhao"];
        
    [cell.myBut setBackgroundImage:[UIImage imageNamed:@"p_arrowleft"]  forState:(UIControlStateNormal)];
    return cell ;
    }
    else
    {
        
        WHtestwoTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.textLabel.text = @"";
        return cell;

    }
}
//选中数据cell行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(20, 110, kScreenWitdh - 40, 270)];
//    [self.view addSubview:_scw];
//    self.scw.backgroundColor = [UIColor redColor];
    WHinterests * model = self.dataArry[indexPath.row];

    self.s1 = model.content;
    NSLog(@"++==%@",self.s1);
    
  //  [self loadWithURLString:self.s1];
    
  //
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:self.s1 preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];

    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
      [self presentViewController:alertController animated:true completion:nil];

    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section == 1) {
        return 40;
    }
    return 30;
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
