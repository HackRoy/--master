//
//  WHareaLiveTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHareaLiveTableViewController.h"
#import "MacroUtility.h"
#import "CityTableViewCell.h"
#import "JGProgressHelper.h"


@interface WHareaLiveTableViewController ()<UITableViewDelegate,UITableViewDataSource>
//导航栏数据
@property (nonatomic,strong)UIView *cityChooseBackView;//弹出框
@property (nonatomic,strong)UIButton *myAddressBtn;
@property (nonatomic,strong)UILabel *titleLab;//上部标题
@property (nonatomic,strong)UITableView *provinceTableView;//省
@property (nonatomic,strong)UITableView *cityTableView;//市
@property (nonatomic,strong)UITableView *areaTableView;//区

@property (nonatomic,strong)NSMutableArray *provenceArr;//存放省的数组
@property (nonatomic,strong)NSMutableArray *cityArr;//存放市的数组
@property (nonatomic,strong)NSMutableArray * areaArr;
@property (nonatomic,strong)UIImageView *arrowProImage;
@property (nonatomic,strong)NSMutableArray *allArr;
@property (nonatomic,strong)NSMutableArray *areaIdArr;
@property (nonatomic,strong)NSMutableArray *provIdArr;
@property (nonatomic,strong)NSMutableArray *cityIdArr;


@property (nonatomic,strong)NSString * proStr;
@property (nonatomic,strong)NSString * cityStr;
@property (nonatomic,strong)NSString * areaStr;
@property (nonatomic,strong)NSString * strName;

@property (nonatomic,strong)NSNumber * proStrID;
@property (nonatomic,strong)NSNumber * cityStrID;
@property (nonatomic,strong)NSNumber * areaStrID;
@property (nonatomic,strong)NSString * strNameID;




@end

@implementation WHareaLiveTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择地区";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(right:)];
    
    _provenceArr = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _areaArr = [NSMutableArray array];
    _allArr = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *addressPath = [[NSBundle mainBundle] pathForResource:@"arealist" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:addressPath];
    self.allArr = [dict objectForKey:@"arealist"];
    
    
    
    [self selectProvenceIndex:0 cityIndex:0];
    
    [self setPopUI];


    
}

#pragma mark 重新写的处理方法
-(void)selectProvenceIndex:(NSInteger)provenceIndex cityIndex:(NSInteger)cityIndex
{
    _provenceArr = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _areaArr = [NSMutableArray array];
    _areaIdArr = [NSMutableArray array];
    _provIdArr = [NSMutableArray array];
    _cityIdArr = [NSMutableArray array];
    NSMutableArray *temporaryAreaArr = [NSMutableArray array];
    
    for (NSDictionary *dic in _allArr)
    {
        [self.provenceArr addObject:[dic objectForKey:@"area_name"]];
        [self.provIdArr addObject:[dic objectForKey:@"area_id"]];
        
        
    }
    
    NSDictionary *cityDic  = _allArr[provenceIndex];
    for (NSDictionary *tempDic in [cityDic objectForKey:@"child"])
    {
        [_cityArr addObject:[tempDic objectForKey:@"area_name"]];
        [temporaryAreaArr addObject:tempDic];
        
        [self.cityIdArr addObject:[tempDic objectForKey:@"area_id"]];
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
    
    
    
    //
    self.myAddressBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myAddressBtn.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame)/1-0.5, 30);
    [self.myAddressBtn setTitle:@"选择地区" forState:UIControlStateNormal];
    [self.myAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.myAddressBtn addTarget:self action:@selector(myaddressBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.myAddressBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myAddressBtn];
    
    self.arrowProImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.myAddressBtn.frame) - 30, CGRectGetHeight(self.myAddressBtn.frame)/1 - 10, 20, 20)];
    //self.arrowProImage.backgroundColor = [UIColor redColor];
    self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
    [self.myAddressBtn addSubview:_arrowProImage];
    
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
    self.areaTableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityTableView.frame), 0, CGRectGetWidth(_cityChooseBackView.frame) / 3, CGRectGetHeight(self.view.frame) ) style:UITableViewStylePlain];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    self.areaTableView.tableFooterView = [UIView new];
    self.areaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //    self.ta
    [self.cityChooseBackView addSubview:_areaTableView];
    self.areaTableView.hidden = YES;
    
    [self.areaTableView registerClass:[CityTableViewCell class] forCellReuseIdentifier:@"ArealistCell"];
    
}
#pragma mark 省市点击事件
-(void)myaddressBtnAction
{
    //UIView *backView = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    _cityChooseBackView.hidden = NO;
    
    self.arrowProImage.image = [UIImage imageNamed:@"arrow.png"];
}

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
    
    else
    {
        return _areaArr.count;
        
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _provinceTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProlistCell" forIndexPath:indexPath];
        cell.titLab.text = self.provenceArr[indexPath.row];
        cell.titLab.textAlignment = 1;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
       else if(tableView == _cityTableView)
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitylistCell" forIndexPath:indexPath];
        cell.titLab.text = self.cityArr[indexPath.row];
        cell.titLab.textAlignment = 1;

        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
       else
    {
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArealistCell" forIndexPath:indexPath];
        cell.titLab.text = self.areaArr[indexPath.row];
        cell.titLab.textAlignment = 1;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    
}

#pragma mark 点击事件
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
        
        self.proStr = self.provenceArr[indexPath.row];
        self.proStrID = self.provIdArr[indexPath.row];
//        NSLog(@"==%@",self.proStrID);
        
        [self.cityTableView reloadData];
    }
    else if(tableView ==_cityTableView)
    {
        NSInteger provinceIndex =  _provinceTableView.indexPathForSelectedRow.row;
        [self selectProvenceIndex:provinceIndex cityIndex:indexPath.row];
        [self.areaTableView reloadData];
        
        self.cityStr = self.cityArr [indexPath.row];
        self.cityStrID = self.cityIdArr[indexPath.row];
        self.areaTableView.hidden = NO;
    }
       else
    {
        self.cityChooseBackView.hidden = YES;
        self.areaStr = self.areaArr[indexPath.row];
        self.areaStrID = self.areaIdArr[indexPath.row];
        
        
        NSString * s1 = [[self.proStr stringByAppendingString:@","]stringByAppendingString:self.cityStr];
        self.strName = [[s1 stringByAppendingString:@","]stringByAppendingString:self.areaStr];
        
        NSArray * numArry = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%@",self.proStrID],[NSString stringWithFormat:@"%@",self.cityStrID],[NSString stringWithFormat:@"%@",self.areaStrID], nil];
        
      self.strNameID = [numArry componentsJoinedByString:@","];
     
        [self.myAddressBtn setTitle:[NSString stringWithFormat:@"%@",self.strName] forState:UIControlStateNormal];
        
        //改变小箭头
        self.arrowProImage.image = [UIImage imageNamed:@"arrowT.png"];
        //这里要根据你取出区的id，重新请求数据，然后刷新下方的tableview
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)right:(UIBarButtonItem *)sender
{
    if (self.strName != nil && self.strNameID != nil) {
        self.mblockArea (self.strName , self.strNameID);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}





@end
