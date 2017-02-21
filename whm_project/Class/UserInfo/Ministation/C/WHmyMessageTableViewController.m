//
//  WHmyMessageTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyMessageTableViewController.h"
#import "WHmyMessageTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WHreplymessageViewController.h"
//刷新数据
#import "MJRefresh.h"



@interface WHmyMessageTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)WHmyMessageTableViewCell * cell;

@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * ID;
//刷新定义页数
@property(nonatomic,assign)NSInteger numindex;



@end

@implementation WHmyMessageTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //请求数据
    //[self requestData];
    [self setupRefresh];
    
}
//刷新
-(void)setupRefresh
{
    [self.tableV addHeaderWithTarget:self action:@selector(headerRereshing) dateKey:@"thable"];
    [self.tableV headerBeginRefreshing];
    [self.tableV addFooterWithTarget:self action:@selector(footerRefreshing )];
    
}
//下拉刷新
-(void)headerRereshing
{
    self.numindex = 1 ;
    //self.numindex ++;
    [self requestData];
}
//上拉加载
-(void)footerRefreshing
{
    
    self.numindex ++ ;
    if (self.dataArry.count <= 10) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
    [self requestData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self setupUI];

}
// 请求数据
-(void)requestData
{
  id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getmessageWithRes_uid:@""
                                       uid :@""
                                          p:[NSString stringWithFormat:@"%ld",self.numindex]
                                   pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 10]
                                    success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry =[ NSMutableArray arrayWithArray:lists];
                                        [self.tableV headerEndRefreshing];
                                        [self.tableV footerEndRefreshing];
       // NSLog(@"%@",self.dataArry);
        [self.tableV reloadData];
        
    } failure:^(NSError * error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"失败"];
    }];
 
}
#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"我的留言";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    
    [self.tableV registerClass:[WHmyMessageTableViewCell class] forCellReuseIdentifier:@"cell"];
    
     _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.dataArry.count;
    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHmyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataArry[indexPath.row];
//    cell.titLaber.text = @"你好吗傻逼傻逼大傻逼";
//    cell.nameLaber.text = @"傻逼";
//    cell.addressLaber.text = @"郑州市";
//    cell.statuLaber.text = @"未回复";
    //cell.timeLaber.text = @"2016/10/29";
    

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//选中数据
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"qq");
    
    WHgetmessage *model = self.dataArry[indexPath.row];
    self.ID = model.id;
    NSLog(@"%@",self.ID);
    

   WHreplymessageViewController * replymes =[[WHreplymessageViewController  alloc]init];
    replymes.IDS = self.ID;
   [self.navigationController pushViewController:replymes  animated:NO];
  
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
