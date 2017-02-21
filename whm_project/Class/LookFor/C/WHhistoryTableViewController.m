//
//  WHhistoryTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHhistoryTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHhistoryTableViewCell.h"
#import "WHgetproducedetalViewController.h"
#import "WCPXQViewController.h"
#import "MJRefresh.h"
#import "JwUserCenter.h"
#import "JwLoginController.h"

@interface WHhistoryTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)UIButton * searBut;
@property(nonatomic,strong)WHhistoryTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * proID;
@property(nonatomic,strong)NSString * keyWord;
//刷新定义页数
@property(nonatomic,assign)NSInteger numindex;

@end

@implementation WHhistoryTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   // [self quartData];
    
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
    [self quartData];
}
//上拉加载
-(void)footerRefreshing
{
    self.numindex ++ ;

    if (self.dataArry.count < 10) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
       [self quartData];
    }
}

-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@""
                                        keyword:@""
                                            sex:@""
                           characters_insurance:@""
                                         period:@""
                                        cate_id:@""
                                     pay_period:@""
                                           rate:@""
                                        insured:@""
                                       birthday:@""
                                  yearly_income:@""
                                           debt:@""
                                        rela_id:@""
                                              p:[NSString stringWithFormat:@"%ld",self.numindex]
                                       pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 10]
                                        success:^(NSArray *lists) {
                                            [hud hide:YES];
                                            
                                            self.dataArry = [NSMutableArray arrayWithArray:lists];
                                            [self.tableV headerEndRefreshing];
                                            [self.tableV footerEndRefreshing];

                                            NSLog(@"%@",self.dataArry);
                                            [self.tableV reloadData];
                                            
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        
    }];
    
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 布局
    [self setupUI];
    
    [self.tableV registerClass:[WHhistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark -- 布局
-(void)setupUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
    //
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    searchBar.backgroundColor = color;
   // searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"请输入关键词";
    [titleView addSubview:searchBar];
//    self.searBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.searBut.frame = CGRectMake(kScreenWitdh * 0.71, 0, kScreenWitdh*0.2, 35);
//    [self.searBut setTitle:@"搜索" forState:(UIControlStateNormal)];
//    [self.searBut setTintColor:[UIColor whiteColor]];
//    [titleView addSubview:_searBut];
    
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHhistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.model = self.dataArry[indexPath.row];
    
    return cell;
}

#pragma mark ===修改过后

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([JwUserCenter sharedCenter].uid != nil) {
        
    
    WHgetproduct * model = self.dataArry[indexPath.row];
    
    WCPXQViewController * produce = [WCPXQViewController new];
    produce.pro_id = model.id;
    produce.productModel = model;
    [self.navigationController pushViewController:produce animated:YES];
    
//    self.proID = model.id;
//    WHgetproducedetalViewController * produce = [[WHgetproducedetalViewController alloc]init];
//    produce .pro_id = self.proID;
//    [self.navigationController pushViewController:produce animated:YES];
        
    }
    else
    {
        [JGProgressHelper showError:@"请登录账号"];
                JwLoginController * login = [[JwLoginController alloc]init];
                [self.navigationController pushViewController:login animated:YES];
    }
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%@",searchBar.text);
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@"" keyword:searchBar.text  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:@"1" pagesize:@"10" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
        
        
    } failure:^(NSError *error)
    {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
