//
//  WLeiXingViewController.m
//  whm_project
//
//  Created by apple on 17/1/5.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WLeiXingViewController.h"
#import "WHcredEntViewController.h"


@interface WLeiXingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * tiArr;
    NSArray * shuziArr;
}

@end

@implementation WLeiXingViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tiArr = @[@"保险公司-人身险",@"保险公司-财产险",@"专业中介结构-代理公司",@"专业中介结构-经纪公司",@"专业中介机构-评估公司",@"保险专业中介"];
    shuziArr = @[@"1",@"2",@"9",@"10",@"11",@"29"];
    
    self.navigationItem.title = @"公司类型";
    [self creatLeftTtem];
    
    [self creatmyui];
    
}
-(void)creatmyui
{
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0,wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [myTab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:myTab];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tiArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = tiArr[indexPath.row];
    cell.textLabel.textColor = wGrayColor2;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.allBlock(tiArr[indexPath.row] ,shuziArr[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
