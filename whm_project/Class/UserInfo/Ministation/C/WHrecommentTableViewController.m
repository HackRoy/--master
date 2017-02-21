//
//  WHrecommentTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrecommentTableViewController.h"
#import "WHrecommentTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "HmSelectCompanyController.h"
//刷新数据
#import "MJRefresh.h"
#import "WHinsuranceViewController.h"

@interface WHrecommentTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WHrecommentTableViewCell * cell;

@property (nonatomic, strong) UITableView *tableV;

@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * recId;
//刷新定义页数
@property(nonatomic,assign)NSInteger numindex;



@end

@implementation WHrecommentTableViewController

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
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewSafeAction:)];

   
}

-(void)addNewSafeAction:(UIBarButtonItem * )sender
{
//      HmSelectCompanyController * company = [[HmSelectCompanyController alloc]init];
//      company.addTend = @"1";
//     [self.navigationController pushViewController:company animated:YES];
    
    WHinsuranceViewController * insure = [[WHinsuranceViewController alloc]init];
    [self.navigationController pushViewController:insure animated:YES];
}

// 请求数据
-(void)requestData
{
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getrecWithAgent_uid:@""
                                      uid:(@"")
                                        p:[NSString stringWithFormat:@"%ld",self.numindex]
                                 pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 10]
                                  success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
                                      [self.tableV headerEndRefreshing];
                                      [self.tableV footerEndRefreshing];
        [self.tableV reloadData];
        
    } failure:^(NSError * error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
}

-(void)setupUI
{
    self.title = @"推荐险种";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor =  [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableV registerClass:[WHrecommentTableViewCell class] forCellReuseIdentifier:@"cell"];
    
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

    return self.dataArry.count;
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHrecommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    cell.myImage.image = [UIImage imageNamed:@"test_head"];
//    cell.titLaber.text = @"泰康人寿组合附加保险公司";
//    cell.yearLaber.text = @"投保年龄:0-66周岁";
//    cell.statuLaber.text = @"产品类型:两全保险";
//    cell.timeLaber.text = @"2016-09-01 09:10:20";
    cell.model = self.dataArry[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
}//删除事件
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      WHgetrec * model = self.dataArry[indexPath.row];
        self.recId  = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delrecWithUid:@""
                                    pid:self.recId success:^{
                                        [hud hide:YES];
                                        [JGProgressHelper showSuccess:@"取消成功"];
                                        [self.tableV reloadData];
                                        
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消失败"];
            
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
