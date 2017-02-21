//
//  RegisterTwoViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "registerTwoTableViewCell.h"
#import "ChooseCompleteViewController.h"
#import "InsuranceViewController.h"
#import "CompleteTypeViewController.h"
#import "WHorganization.h"
#import "JGProgressHelper.h"
#import "JwLoginController.h"

#import "WLeiXingViewController.h"
#import "MyRenZhengTableViewCell.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
@interface RegisterTwoViewController ()<UITableViewDelegate,UITableViewDataSource,completeDelegate,completeInsDelegate>
{
    NSArray * imgArr;
    NSArray * tfTextArr;
    
}
//completeDelegate
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,strong)NSString *compName;
@property (nonatomic,strong)NSString *compId;
//类型
@property (nonatomic,strong)NSString *leixingcompName;
@property (nonatomic,strong)NSString *leixingcompId;



//@property (nonatomic,strong)NSString *compOtherId;
//@property (nonatomic,strong)NSString *compOtherName;


@property (nonatomic,strong)NSString *institutionsName;//机构
@property (nonatomic,strong)NSString *institutionsId;//机构id
@property (nonatomic,strong)NSString *institutionsAddress;//机构地址

@end

@implementation RegisterTwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:74/255.0 green:108/255.0 blue:246/255.0 alpha:0.5];
    

    imgArr = @[@"leixing",@"gongsi",@"jigou",@"dizhi"];
    tfTextArr = @[@"请选择公司类型",@"请选择保险公司名称",@"请选择保险公司",@"公司地址自动带入"];
    [self setUI];
    self.title = @"注册";
    
}
-(void)setUI
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenW , 40)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *promptLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 12.5, kScreenW - 30, 25)];
    promptLab.text = @"快保家不会再任何地方泄露用户的个人信息";
    promptLab.textColor = [UIColor colorWithRed:148/255.0 green:149/255.0 blue:150/255.0 alpha:1.0];
    promptLab.textAlignment = 1;
    promptLab.font = [UIFont systemFontOfSize:10];
    promptLab.backgroundColor = [UIColor clearColor];
    
    [headView addSubview:promptLab];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 80)];
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.frame = CGRectMake(50, 40, kScreenW - 100, 40);
    registBtn.layer.cornerRadius = 20;
    [registBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registBtn.backgroundColor = [UIColor colorWithRed:74/255.0 green:108/255.0 blue:246/255.0 alpha:1.0];
    [registBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:registBtn];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, wScreenH - 64 - 50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[MyRenZhengTableViewCell class] forCellReuseIdentifier:@"regCell"];
    self.tableView.tableHeaderView = headView;
    self.tableView.tableFooterView = bgView;

    
    
}
//提交注册代理人
-(void)registerBtnAction
{
//    leixingcompId
    if (self.leixingcompId.length >= 1)
    {
        if (self.compId.length >= 1)
        {
            if ( self.institutionsId.length >= 1)
            {
                    id hud = [JGProgressHelper showProgressInView:self.view];
                    [self.userService registWithName:self.name mobile:self.mobile captcha:self.captcha pwd:self.pwd type:@"1" company_id:self.compId  org_id:self.institutionsId exhibition_no:@"" nickname:@"" work_time:@"" id_number:@"" profession:@"" specialize_in:@"" address:self.institutionsAddress success:^(JwUser *user)
                        {
                        [hud hide:YES];
                        [JGProgressHelper showSuccess:@"代理人用户注册成功"];
                        JwLoginController  * login = [[JwLoginController alloc]init];
                        [self.navigationController pushViewController:login animated:YES];
                
                    } failure:^(NSError *error)
                        {
                        [hud hide:YES];
                        [JGProgressHelper showError:@"注册失败"];
                    }];
              }else
            {
                [WBYRequest showMessage:@"请选择分公司"];
            }
            }else
        {
            [WBYRequest showMessage:@"请选择公司名字"];
        }
        
    }else
    {
        [WBYRequest showMessage:@"请选择公司类型"];
    }
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyRenZhengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"regCell"];
    
    cell.mText.tag = 130 + indexPath.row;
    cell.mText.enabled = NO;
    cell.lImg.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.mText.placeholder =tfTextArr[indexPath.row];
    cell.mText.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak RegisterTwoViewController * mySelf = self;

    UITextField * tf = [self.view viewWithTag:130 + indexPath.row];
    if (indexPath.row == 0 )
    {
        WLeiXingViewController * leixing = [WLeiXingViewController new];
        leixing.allBlock = ^(NSString  * muStr,NSString * shuStr )
        {
            mySelf.leixingcompId = shuStr;
            mySelf.leixingcompName = muStr;
            tf.text = muStr;
        };
        
        [self.navigationController pushViewController:leixing animated:YES];
  
    }
   else if (indexPath.row == 1)
    {
        if (self.leixingcompId == nil)
        {
            [WBYRequest showMessage:@"请选择公司类型"];
            return;
        }
        else
        {
            InsuranceViewController *insuranceVC = [[InsuranceViewController alloc] init];
            insuranceVC.delegate = self;
            insuranceVC.completeId = self.leixingcompId;
            
        
            [self.navigationController pushViewController:insuranceVC animated:YES];
        }
    }else if (indexPath.row == 2)
    {
        if (self.compName == nil)
        {
            [WBYRequest showMessage:@"公司不能为空"];
            return;

        }
        else
        {
            ChooseCompleteViewController *chooseVC = [[ChooseCompleteViewController alloc] init];
            chooseVC.delegate  = self;
            chooseVC.cId =  self.compId ;
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
        
    }else if(indexPath.row == 3)
    {
        if (self.compName == nil)
        {
            
            [WBYRequest showMessage:@"公司不能为空"];
            return;

        }
        else
        {
            ChooseCompleteViewController *chooseVC = [[ChooseCompleteViewController alloc] init];
            chooseVC.delegate  = self;
            chooseVC.cId =  self.compId ;
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
        
    }
    
    
     [mySelf.tableView reloadData];
    
}


-(void)clickAction:(UIButton *)sender
{
    __weak RegisterTwoViewController * mySelf = self;

    if (sender.tag == 101)
    {
        
        WLeiXingViewController * leixing = [WLeiXingViewController new];
        leixing.allBlock = ^(NSString  * muStr,NSString * shuStr )
        {
//            NSLog(@"====%@====%@",muStr,shuStr);
            
            mySelf.leixingcompId = shuStr;
            mySelf.leixingcompName = muStr;
            
            [mySelf.tableView reloadData];
        };
        
        [self.navigationController pushViewController:leixing animated:YES];
        
    }
    if (sender.tag == 102)
    {
        if (self.leixingcompId == nil)
        {
            UIAlertView *alview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司类型不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                        [alview show];
        }
        else
        {
            InsuranceViewController *insuranceVC = [[InsuranceViewController alloc] init];
            insuranceVC.delegate = self;
            insuranceVC.completeId = self.leixingcompId;
            [self.navigationController pushViewController:insuranceVC animated:YES];
        }
        
    }
    if (sender.tag == 103)
    {
        if (self.compName == nil)
        {
            UIAlertView *alview = [[UIAlertView alloc]initWithTitle:@"提示" message:@"公司不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                       [alview show];
        }
        else
        {
            ChooseCompleteViewController *chooseVC = [[ChooseCompleteViewController alloc] init];
            chooseVC.delegate  = self;
            chooseVC.cId =  self.compId ;
            [self.navigationController pushViewController:chooseVC animated:YES];
        }
       
    }
}

-(void)comNamepleteId:(NSString *)cId completeName:(NSString *)cName
{
    UITextField * tf = [self.view viewWithTag:130 + 1];
    tf.text = cName;
    self.compId  = cId;
    self.compName = cName;
    [self.tableView reloadData];
}

-(void)institutions:(WHorganization *)instModel
{
    UITextField * tf = [self.view viewWithTag:130 + 2];
    UITextField * tf1 = [self.view viewWithTag:130 + 3];

    tf.text = instModel.name;
    tf1.text = instModel.address;
    
    self.institutionsName = instModel.name;
    self.institutionsId = instModel.id;
    self.institutionsAddress = instModel.address;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
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
