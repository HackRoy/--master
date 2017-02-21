//
//  WHhospitalTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHhospitalTableViewController.h"
#import "MacroUtility.h"
#import "WHhospitalTableViewCell.h"
#import "CityTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHhospital.h"
#import <UIImageView+WebCache.h>
//
#import "JwCompanys.h"
#import "completeTableViewCell.h"
#import "MJRefresh.h"
#import "WBYHostilJiGouViewController.h"
#import "WBYSuoYouYiYuanViewController.h"

@interface WHhospitalTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property(nonatomic,strong)WHhospitalTableViewCell * cell;
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)NSString * tel;
//导航栏数据
//导航栏数据
@property (nonatomic,strong)UIView *cityChooseBackView;//弹出框
@property (nonatomic,strong)UIButton *myAddressBtn;
@property (nonatomic,strong)UIButton *myCategoryBtn;


@property (nonatomic,strong)UILabel *titleLab;//上部标题
@property (nonatomic,strong)UITableView *provinceTableView;//省
@property (nonatomic,strong)UITableView *cityTableView;//市
@property (nonatomic,strong)UITableView *areaTableView;//区

@property (nonatomic,strong)NSMutableArray *provenceArr;//存放省的数组
@property (nonatomic,strong)NSMutableArray *cityArr;//存放市的数组
@property(nonatomic,strong)NSMutableArray * areaArr;

@property (nonatomic,strong)UIImageView *arrowProImage;

@property (nonatomic,strong)UIImageView *arrowCartogyImage;
//
@property(nonatomic,strong)NSMutableArray * dataArry;
//
@property (nonatomic,strong)NSMutableArray *allArr;
@property (nonatomic,strong)NSMutableArray *areaIdArr;
//
@property(nonatomic,strong)UITableView * companyTableView;//公司筛选
@property(nonatomic,strong)NSMutableArray * companyArr;
@property(nonatomic,strong)UIView * companyBackView; //公司试图
@property(nonatomic,strong)NSString * companyID;

@property(nonatomic,strong)UIView * titleView;
@property(nonatomic,assign)NSInteger numindex;

@end

@implementation WHhospitalTableViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

     [self data];
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
    [self quartDate];
    
    [self.tableV headerEndRefreshing];
    [self.tableV footerEndRefreshing];
}
//上拉加载
-(void)footerRefreshing
{
    self.numindex ++ ;
    if (self.dataArry.count <= 10)
    {
        [self.tableV footerEndRefreshing];
    }
    else
    {
        [self quartDate];
    }
    [self.tableV headerEndRefreshing];
    [self.tableV footerEndRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArry = [NSMutableArray array];

    _provenceArr = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _areaArr = [NSMutableArray array];
    _allArr = [NSMutableArray array];
   
    _areaIdArr = [NSMutableArray array];

    [self quartDate];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"arealist" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    self.allArr = [dict objectForKey:@"arealist"];
    
    [self selectProvenceIndex:0 cityIndex:0];
    
    self.title = @"定点医院";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ditudao"] style:(UIBarButtonItemStylePlain) target:self action:@selector(aa:)];
    [self setPopUI];
}
-(void)data
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_CompanysWithType:@"1,2" success:^(NSArray *lists)
    {
        [hud hide:YES];
        self.companyArr = [NSMutableArray arrayWithArray:lists];
        [self.companyTableView reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
    }];
}


//数据请求处理
-(void)quartDate
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_hospitalWithlat:stringTwo
                                      lng:stringOne
                                 province:@""
                                     city:@""
                                   county:@""
                                 distance:@"10000.00"
                                      map:@""
                                        p:[NSString stringWithFormat:@"%ld",self.numindex]
                                 pagesize:[NSString stringWithFormat:@"%ld",self.numindex * 15]
                                  success:^(NSArray *lists)
    {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
                                      [self.tableV headerEndRefreshing];
                                      [self.tableV footerEndRefreshing];
        [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"没有数据"];
        
    }];
}

#pragma mark 重新写的处理方法
-(void)selectProvenceIndex:(NSInteger)provenceIndex cityIndex:(NSInteger)cityIndex
{
       NSMutableArray *temporaryAreaArr = [NSMutableArray array];
    
    for (NSDictionary *dic in _allArr)
    {
        [self.provenceArr addObject:[dic objectForKey:@"area_name"]];
        
    }
    
    NSDictionary *cityDic  = _allArr[provenceIndex];
    for (NSDictionary *tempDic in [cityDic objectForKey:@"child"])
    {
        [_cityArr addObject:[tempDic objectForKey:@"area_name"]];
        [temporaryAreaArr addObject:tempDic];
        
    }
    
    NSDictionary *myDic  = temporaryAreaArr[cityIndex];
    for (NSDictionary *areaDic in [myDic objectForKey:@"child"])
    {
        [_areaArr addObject:[areaDic objectForKey:@"area_name"]];
        [_areaIdArr addObject:[areaDic objectForKey:@"area_id"]];
    }
}

-(void)setPopUI
{
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * address = [ud stringForKey:@"address"];

    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, kScreenWitdh, kScreenHeight - 64-35) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
    [self.tableV registerClass:[WHhospitalTableViewCell class] forCellReuseIdentifier:@"cell"];
    //
    self.myAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myAddressBtn.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame)/2-0.5, 30);
    [self.myAddressBtn setTitle:[NSString stringWithFormat:@"%@",address] forState:UIControlStateNormal];
    [self.myAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myAddressBtn addTarget:self action:@selector(myaddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.myAddressBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myAddressBtn];
    
    self.arrowProImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.myAddressBtn.frame) - 30, CGRectGetHeight(self.myAddressBtn.frame)/2 - 10, 20, 20)];
    self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
    [self.myAddressBtn addSubview:_arrowProImage];
    
    self.myCategoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myCategoryBtn.frame = CGRectMake(CGRectGetMaxX(self.myAddressBtn.frame) + 1, 0,CGRectGetWidth(self.view.frame)/2-0.5, 30);
    [self.myCategoryBtn setTitle:@"类别" forState:UIControlStateNormal];
    [self.myCategoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myCategoryBtn addTarget:self action:@selector(myCategoryBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.myCategoryBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myCategoryBtn];
    
    
    self.arrowCartogyImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.myAddressBtn.frame) - 30, CGRectGetHeight(self.myAddressBtn.frame)/2 - 10, 20, 20)];
    //self.arrowProImage.backgroundColor = [UIColor redColor];
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrowT.png"];
    [self.myCategoryBtn addSubview:_arrowCartogyImage];
    
    
    
    
    _cityChooseBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 94)];
    _cityChooseBackView.backgroundColor = [UIColor whiteColor];
    _cityChooseBackView.hidden = YES;
    [self.view addSubview:_cityChooseBackView];
    
    
    //省
    self.provinceTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.provinceTableView.delegate = self;
    self.provinceTableView.dataSource = self;
    self.provinceTableView.tableFooterView = [UIView new];
    self.provinceTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_provinceTableView];
    [self.provinceTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ProlistCell"];
    
    
    //市
    self.cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceTableView.frame), 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.cityTableView.delegate = self;
    self.cityTableView.dataSource = self;
    self.cityTableView.tableFooterView = [UIView new];
    self.cityTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_cityTableView];
    self.cityTableView.hidden = YES;
    
    [self.cityTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"CitylistCell"];
    
    
    //区
    self.areaTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityTableView.frame), 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.tableFooterView = [UIView new];
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_areaTableView];
    self.areaTableView.hidden = YES;
    
    [self.areaTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ArealistCell"];
    
    
    
}
//右边点击事件
-(void)aa:(UIBarButtonItem *)sender
{
    WBYSuoYouYiYuanViewController * suoyou = [WBYSuoYouYiYuanViewController new];
    [self.navigationController pushViewController:suoyou animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 省市点击事件
-(void)myaddressBtnAction
{
    //UIView *backView = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    _cityChooseBackView.hidden = NO;
    
    self.arrowProImage.image = [UIImage imageNamed:@"arrow.png"];
}
#pragma mark 类别点击事件
-(void)myCategoryBtnAction
{
    NSLog(@"点击了类别筛选");
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrow.png"];
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh , 35)];//allocate titleView
    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    
    [_titleView setBackgroundColor:color];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWitdh* 0.7, 35);
    searchBar.backgroundColor = color;
    //searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    
    searchBar.placeholder = @"请输入关键词";
    [_titleView addSubview:searchBar];
    
    //Set to titleView
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = _titleView;
    NSLog(@"点击了类别筛选");
    self.arrowCartogyImage.image = [UIImage imageNamed:@"arrow.png"];
    self.companyBackView  = [[UIView alloc]init];
    self.companyBackView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 94);
    self.companyBackView.backgroundColor = [UIColor whiteColor];
    //self.companyBackView.hidden = YES;
    [self.view addSubview:_companyBackView];
    self.companyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_companyBackView.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    self.companyTableView.tableFooterView = [UIView new];
    self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.companyBackView addSubview:_companyTableView];
    
    [self.companyTableView registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"CompanyCell"];

}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_productWithCompany_id:@"" keyword:searchBar.text  sex:@"" characters_insurance:@"" period:@"" cate_id:@"" pay_period:@"" rate:@"" insured:@"" birthday:@"" yearly_income:@"" debt:@"" rela_id:@"" p:@"1" pagesize:@"10" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.companyArr = [NSMutableArray arrayWithArray:lists];
        [self.companyTableView reloadData];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"没有获取到数据"];
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _provinceTableView)
    {
        return _provenceArr.count;
    }
    else if(tableView == _cityTableView)
    {
        return _cityArr.count;
    }
    else  if (tableView == _tableV) {
        return self.dataArry.count;
    }
    else if (tableView == _companyTableView)
    {
        return _companyArr.count;
    }

    else
    {
        return _areaArr.count;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _provinceTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProlistCell" forIndexPath:indexPath];
        cell.titLab.text = self.provenceArr[indexPath.row];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    else if (tableView == _companyTableView)
    {
        completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CompanyCell" forIndexPath:indexPath];
        JwCompanys * model = self.companyArr[indexPath.row];
        
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell.titleLab.text = model.name;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }

    else if(tableView == _cityTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitylistCell" forIndexPath:indexPath];
        cell.titLab.text = self.cityArr[indexPath.row];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    else if (tableView == _tableV)
    {
        WHhospitalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        WHhospital * model = self.dataArry[indexPath.row];
        cell.titLaber.text = model.name;
        cell.addressLaber.text = model.address;
        cell.mapLaber.text = model.distance;
        cell.telLaber.text = model.tel;
        
        [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
        cell.mapImg.image = [UIImage imageNamed:@"maple"];
        cell.telBut.tag = 100 + indexPath.row;
        [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
               cell.telImg.image = [UIImage imageNamed:@"tel"];
     
        return cell;
        
    }
    else
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArealistCell" forIndexPath:indexPath];
        cell.titLab.text = self.areaArr[indexPath.row];
        // NSLog(@"000%@", indexPath);
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }

    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger myIntag;
    if (tableView == _provinceTableView)
    {
        self.cityTableView.hidden = NO;
        //这里面根据不同的省的id   改变_cityArr数组的数据，并刷新cityTableView
        //JwAreass * area = self.provenceArr[indexPath.row];
        
        [self selectProvenceIndex:indexPath.row cityIndex:0];
        myIntag = indexPath.row;
        [self.cityTableView reloadData];
    }
    else if (tableView == _companyTableView)
    {
        self.titleView.hidden = YES;
        self.companyBackView.hidden = YES;
        JwCompanys * model = self.companyArr [indexPath.row];
        self.companyID = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.dataService gethospitalWithCom_id:self.companyID
                                       province:@""
                                           city:@""
                                         county:[NSString stringWithFormat:@"%@",self.areaIdArr[indexPath.row]]
                                       distance:@"1000.00"
                                            map:@"1"
                                        success:^(NSArray *lists)
        {
                                            [hud hide:YES];
                                             self.dataArry = [NSMutableArray arrayWithArray:lists];
                                            NSLog(@"%@",[[lists firstObject ]objectForKey:@"info"]);
                                            [self.tableV reloadData];
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"没有数据"];
        }];

    }
    else if(tableView ==_cityTableView)
    {
        NSInteger provinceIndex =  _provinceTableView.indexPathForSelectedRow.row;
        [self selectProvenceIndex:provinceIndex cityIndex:indexPath.row];
        [self.areaTableView reloadData];
        
        
        self.areaTableView.hidden = NO;
        //这里要根据你取出市的id，重新请求数据，然后弹出区的tableview。
        
    }
    else if (tableView == _tableV)
    {
  
        
        DataModel * mod = self.dataArry[indexPath.row];
        WBYHostilJiGouViewController * wby = [WBYHostilJiGouViewController new];
          wby.myDataModel = mod ;
        [self.navigationController pushViewController:wby animated:YES ];
        
    }
    else
    {
        
        self.cityChooseBackView.hidden = YES;
        [self.myAddressBtn setTitle:self.areaArr[indexPath.row] forState:UIControlStateNormal];
        
        //改变小箭头
        self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
        //这里要根据你取出区的id，重新请求数据，然后刷新下方的tableview
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.dataService get_hospitalWithlat:@"" lng:@"" province:@"" city:@"" county:[NSString stringWithFormat:@"%@",self.areaIdArr[indexPath.row]] distance:@"10.00" map:@""p: @"" pagesize:@""  success:^(NSArray *lists) {
            [hud hide:YES];
            self.dataArry = [NSMutableArray arrayWithArray:lists];
            [self.tableV reloadData];
            
        } failure:^(NSError *error)
        {
            [hud hide:YES];
            [JGProgressHelper showError:@""];
            
            
        }];
        
    }
}

//电话事件
-(void)telAction:(UIButton *)sender
{
    WHhospital * hospit = self.dataArry[sender.tag - 100];
    self.tel = hospit.tel;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableV) {
        return 100;
    }
    if (tableView == _companyTableView) {
        return 60;
    }
    return 40;
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
