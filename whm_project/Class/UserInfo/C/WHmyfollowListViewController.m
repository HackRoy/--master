//
//  WHmyfollowListViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyfollowListViewController.h"
#import "MacroUtility.h"
#import "WHmyfollowListTableViewCell.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WHgetfollowList.h"
#import <UIImageView+WebCache.h>
#import "WHwantMessageViewController.h"
#import "WHministaViewController.h"
#import "WBYRequest.h"
@interface WHmyfollowListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHmyfollowListTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * tel ;
@property(nonatomic,strong)NSString * followId;
@property(nonatomic,strong)NSString * follName;


@end

@implementation WHmyfollowListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requestData];
}
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getfollowWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self setupUI];
}

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"我的关注";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHmyfollowListTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHmyfollowListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WHgetfollowList * model = self.dataArry[indexPath.row];
    self.followId = model.id;
    self.follName = model.name;
    
    
    //[cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    [cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];

    cell.nameLaber.text = model.name;
    if ([model.sex isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];
    }else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
    }
    cell.ageLaber.text = model.age;
    if (model.work_time == nil) {
        model.work_time = @"";
    }
    if (model.profession == nil) {
        model.profession = @"";
    }
    if (model.service_area == nil) {
        model.service_area = @"";
    }
    if (model.company == nil) {
        model.company = @"";
    }
    NSString * strLab = [model.company stringByAppendingString:model.profession];
    NSString * strWork = [strLab stringByAppendingString:model.work_time];
    NSString * strArea = [strWork stringByAppendingString:model.service_area];
    cell.myLaber.text = strArea;
    [cell.mesBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    cell.mesBut.tag = 100 + indexPath.row;
    [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    cell.telBut.tag = 100 + indexPath.row;
    [cell.telBut addTarget:self action:@selector(telButAction:) forControlEvents:(UIControlEventTouchUpInside )];
    [cell.mesBut addTarget:self action:@selector(mesButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
    
}
//短信事件
-(void)mesButAction:(UIButton *)sender
{
   
        WHwantMessageViewController * wantMes = [[WHwantMessageViewController alloc]init];
        wantMes.res_uid = self.followId;
        wantMes.name = self.follName;
        [self.navigationController pushViewController:wantMes animated:YES];
        

    
}

//电话事件
-(void)telButAction:(UIButton *)sender
{
    WHgetfollowList * model = self.dataArry[sender.tag - 100];
    self.tel = model.mobile;
    
    if (![self valiMobile:model.mobile] ) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [view show];
    }
    
    else
    {
        [JGProgressHelper showError:@"该电话号码不符合要求"];
    }
    
    
    
    
}

- (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}


//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}
//编辑删除事件
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//制定编辑的样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//删除事件
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        WHgetfollowList * model = self.dataArry[indexPath.row];
        self.followId = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delfollowWithID:self.followId
                                      uid:@""
                                  success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"取消关注成功"];
            [self.tableV reloadData];
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注失败"];
            
        }];
        
        [self.dataArry removeObjectAtIndex:indexPath.row];
        
        NSArray * temp = [NSArray arrayWithObject:indexPath];
        //更新ui
        
        [ tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
        [tableView setEditing:NO animated:YES];

        
    }];
    
    NSArray * arr = @[layTopRowAction1];
    return arr;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if ([self.StrFod isEqualToString:@"1"]) {
    WHministaViewController * sta = [[WHministaViewController alloc]init];
    sta.StrAgentId = self.followId;
    
    [self.navigationController pushViewController:sta animated:YES];
         
     }else
     {
         [JGProgressHelper showError:@"普通用户不具有微站的权利"];
     }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
