//
//  WHproductSearchTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/9.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHproductSearchTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHprosearchTableViewCell.h"
#import "WHgetproduct.h"
#import "JwPhysicalController.h"
#import "MJRefresh.h"


@interface WHproductSearchTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)WHprosearchTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * keyWord;
@property(nonatomic,strong)NSString * ids;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * is_main;
@property(nonatomic,assign)NSInteger numindex;
@property(nonatomic,strong)UISearchBar * searchBar;


@end

@implementation WHproductSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 布局
    [self setupUI];
   // self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];
 
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
     //[self setupRefresh];
    
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
    if (self.dataArry.count <10) {
        [self.tableV footerEndRefreshing];
    }
    else
    {
    [self quartData];
        [self seach];
    }
}

//数据请求
-(void)quartData
{
    
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getpolicyprosWithCompany_id:@""
                                          keyword:@""
                                              uid:@""
                                                p:@"1"
                                         pagesize:@"100"
                                          success:^(NSArray *lists) {
        
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
       // [self.tableV headerEndRefreshing];
      //  [self.tableV footerEndRefreshing];
                
                                              [self.tableV reloadData];

    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];

    }];
    
   }

#pragma mark -- 布局
-(void)setupUI
{

    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHprosearchTableViewCell class] forCellReuseIdentifier:@"cell"];
    

    //
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [titleView setBackgroundColor:color];
    
 
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.delegate = self;
    _searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    _searchBar.backgroundColor = color;
    // searchBar.layer.cornerRadius = 18;
    _searchBar.layer.masksToBounds = YES;
    [_searchBar.layer setBorderWidth:8];
    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    _searchBar.placeholder = @"请输入关键词";
    [titleView addSubview:_searchBar];
    
    
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = titleView;
    

     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:(UIBarButtonItemStylePlain) target:self action:@selector(seach)];
}


-(void)seach
{
    [[[UIApplication sharedApplication].delegate window] endEditing:YES];
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@"" keyword:_searchBar.text.length>1 ?_searchBar.text:@""  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:[NSString stringWithFormat:@"%ld",self.numindex] pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 10]
                                        success:^(NSArray *lists) {
                                            [hud hide:YES];
                                            
                                            self.dataArry = [NSMutableArray arrayWithArray:lists];
                                            [self.tableV reloadData];
                                            
                                            
                                        } failure:^(NSError *error) {
                                            [hud hide:YES];
                                            [JGProgressHelper showError:@""];
                                            
                                        }];

}

//选中事件返回
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    WHgetproduct * model = self.dataArry[indexPath.row];
    
    
    self.name = model.name;
    self.ids = model.id;
    self.is_main = model.is_main;

    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.groupsArr];
    if (self.DataToR) {
        self.DataToR(model,arr,self.isSelectP,self.contentDic,self.fuzhiDic,model.id);
    }
    

    [self.navigationController popViewControllerAnimated:YES];
    
        
  
}
- (void)returnDataToRootVC:(void (^)(WHgetproduct *, NSMutableArray *, BOOL, NSMutableDictionary *, NSMutableDictionary *, NSString *))block {
    self.DataToR = block;
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
 
    [[[UIApplication sharedApplication].delegate window]endEditing: YES];
     NSLog(@"%@",searchBar.text);
     id hud = [JGProgressHelper showProgressInView:self.view];
     [self.dataService get_productWithCompany_id:@"" keyword:searchBar.text  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:@"1" pagesize:@"10" success:^(NSArray *lists) {
         [hud hide:YES];
         
         self.dataArry = [NSMutableArray arrayWithArray:lists];
         [self.tableV reloadData];

        
     } failure:^(NSError *error) {
         [hud hide:YES];
         [JGProgressHelper showError:@""];
         
     }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHprosearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.model = self.arry[indexPath.row];
  
    cell.model = self.dataArry[indexPath.row];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
