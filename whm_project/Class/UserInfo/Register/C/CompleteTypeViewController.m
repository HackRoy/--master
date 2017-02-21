//
//  CompleteTypeViewController.m
//  whm_project
//
//  Created by YiTu8 on 2016/10/27.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "CompleteTypeViewController.h"


#define kScreenW [[UIScreen mainScreen] bounds].size.width
@interface CompleteTypeViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *NameArr;
@property (nonatomic,strong)NSArray *IdArr;
@end

@implementation CompleteTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _NameArr = [NSArray arrayWithObjects:@"保险公司--人身险",@"保险公司--财产险",@"专业中介机构--代理公司",@"专业中介机构--代经纪公司",@"专业中介机构--公告公司", nil];
    _IdArr = [NSArray arrayWithObjects:@"1",@"2",@"9",@"10",@"11", nil];
    [self creatUI];
    self.title = @"公司类型";
    
}

-(void)creatUI
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark - 返回sections
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

#pragma mark - 返回rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _NameArr.count;
    
}
#pragma mark - tableview事件
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    
    cell.textLabel.text = _NameArr[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate completeName:_NameArr[indexPath.row] completeId:_IdArr[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
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
