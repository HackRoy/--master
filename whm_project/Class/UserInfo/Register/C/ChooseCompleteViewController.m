//
//  ChooseCompleteViewController.m
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import "ChooseCompleteViewController.h"
#import "ChooseTableViewCell.h"
#import "JGProgressHelper.h"
#import "JwAreass.h"
#import "JwDataService.h"
#import "WHorganization.h"
#import "MJRefresh.h"
#import "PickView.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height


@interface ChooseCompleteViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger numindex;
    NSInteger pageIndex;
    UIView *_chooseCityView;
    UIAlertView * alertView;

}
@property (nonatomic, strong) PickView * cityPickerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *lineLab;
@property (nonatomic,strong)UILabel *titLab;


@property (nonatomic,strong)UIView *provinceView;
@property (nonatomic,strong)UIView *cityView;
@property (nonatomic,strong)UIView *areaView;

@property (nonatomic,strong)UIButton *provinceBtn;
@property (nonatomic,strong)UIButton *cityBtn;
@property (nonatomic,strong)UIButton *areaBtn;

@property (nonatomic,strong)UIImageView *provinceImage;
@property (nonatomic,strong)UIImageView *cityImage;
@property (nonatomic,strong)UIImageView *areaImage;

@property (nonatomic,strong)NSMutableArray *allArr;//全部数据
@property (nonatomic,strong) NSMutableArray  *proTimeList;//全部省
@property (nonatomic,strong) NSMutableArray  *proTimeListId;//全部省


@property (nonatomic,strong)NSMutableArray  *cityAllArr;//城市的全部数据(包括id什么的)
@property (nonatomic,strong)NSMutableArray *cityArr;//省内的城市
@property (nonatomic,strong)NSMutableArray *cityArrId;//省内的城市Id

@property (nonatomic,strong)NSMutableArray  *areaAllArr;//区的全部数据(包括id)
@property (nonatomic,strong)NSMutableArray  *areaArr;//全部区
@property (nonatomic,strong)NSMutableArray  *areaArrId;//全部区id

@property (nonatomic,strong)NSMutableArray *listArr;



@property (nonatomic,strong)UIPickerView *pickerView ;


@property (nonatomic,strong)UIPickerView *mycityPickerView;

@property (nonatomic,strong)UIPickerView *areaPickerView;

@end

@implementation ChooseCompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _allArr = [NSMutableArray array];
    _cityAllArr = [NSMutableArray array];
    _areaAllArr = [NSMutableArray array];
    _listArr = [NSMutableArray array];

    _proTimeList = [NSMutableArray array];
     _proTimeListId = [NSMutableArray array];
    _cityArr = [NSMutableArray array];
    _cityArrId = [NSMutableArray array];
    _areaArr = [NSMutableArray array];
     _areaArrId = [NSMutableArray array];
    
    _cityPickerView = [[PickView alloc] init];
    _cityPickerView.backgroundColor= wWhiteColor;
    numindex = 1;
    pageIndex = 20;
    
    self.title = @"分支机构";
    [self requestleiBieDateDatalngproStr:@"" cityStr:@"" countyStr:@""];

    [self creatTable];
    
    
}
-(void)creatTable
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, wScreenH - 64-40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    [self.tableView footerEndRefreshing];
    
    [self.view addSubview:_tableView];
    
    [self.tableView registerClass:[ChooseTableViewCell class] forCellReuseIdentifier:@"chooseCell"];
    
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0,wScreenH - 64 - 40, wScreenW, 40)];
    
    [self.view addSubview:aView];
    
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:[NSString stringWithFormat:@"请选择省/市/区"] forState:UIControlStateNormal];
    zhifu.titleLabel.font = [UIFont systemFontOfSize:14];
    zhifu.frame = CGRectMake(20, 2.5, wScreenW - 40, 35);
    [zhifu setTitleColor:wWhiteColor forState:UIControlStateNormal];
    zhifu.backgroundColor = wBlue;
    zhifu.layer.masksToBounds = YES;
    zhifu.layer.cornerRadius = 12;
    zhifu.tag = 33333;
    [zhifu addTarget:self action:@selector(xuandiqu) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:zhifu];
    
    
}

-(void)xuandiqu
{
    [self creatpickvie];
}

-(void)creatpickvie
{
    
    alertView = [[UIAlertView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
    
    alertView.backgroundColor = wGrayColor;
    alertView.alpha = 0.5;
    [self.view addSubview:alertView];
    
    [UIView animateWithDuration:0.3f animations:^{
        _chooseCityView.frame = CGRectMake(-2, self.view.frame.size.height - 240, self.view.frame.size.width+4, 40);
    }];
    
    [_cityPickerView showInView:self.view];
    
    
    
    
    _chooseCityView = [[UIView alloc]initWithFrame:CGRectMake(0,0,wScreenW, 40)];
    _chooseCityView.backgroundColor = [UIColor whiteColor];
    _chooseCityView.layer.borderColor = [UIColor whiteColor].CGColor;
    _chooseCityView.layer.borderWidth = 0.6f;
    
    
    [_cityPickerView addSubview:_chooseCityView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(12, 0, 40, 40);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:cancelButton];
    
    UIButton *chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButton.frame = CGRectMake(self.view.frame.size.width - 50, 0, 40, 40);
    [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
    chooseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [chooseButton setTitleColor:wBlue forState:UIControlStateNormal];
    [chooseButton addTarget:self action:@selector(pickerviewbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseCityView addSubview:chooseButton];
}

- (void)pickerviewbuttonclick:(UIButton *)sender
{
    UIButton * aBtn = [self.view viewWithTag:33333];
       if ([sender.titleLabel.text isEqualToString:@"确定"])
    {
        
        
        [aBtn setTitle:[NSString stringWithFormat:@"%@/%@/%@",_cityPickerView.sheng, _cityPickerView.shi,_cityPickerView.qu] forState:UIControlStateNormal];
        
//        aBtn.titleLabel.font = [UIFont systemFontOfSize:10];
//        aBtn.titleLabel.text = [NSString stringWithFormat:@"%@/%@",_cityPickerView.shi,_cityPickerView.qu];
        
//        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" comId:@""];
        
        [self requestleiBieDateDatalngproStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@""];
        
    }
    
    [alertView removeFromSuperview];
    [_cityPickerView hiddenPickerView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [alertView removeFromSuperview];

    [_cityPickerView hiddenPickerView];
}


-(void)requestleiBieDateDatalngproStr:(NSString *)proStr  cityStr:(NSString *)cityStr countyStr:(NSString *)countyStr
{
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[WBYRequest jiami:@"kb/get_organization"] forKey:@"kb"];
    [dic setObject:self.cId?self.cId:@"" forKey:@"com_id"];
    [dic setObject:@"" forKey:@"city_name"];
    [dic setObject:proStr forKey:@"province"];
    [dic setObject:cityStr forKey:@"city"];
    [dic setObject:countyStr forKey:@"county"];
    [dic setObject:stringTwo forKey:@"lat"];
    [dic setObject:stringOne forKey:@"lng"];
    [dic setObject:@"10000.00" forKey:@"distance"];
    [dic setObject:@"" forKey:@"map"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:[NSString stringWithFormat:@"%ld",pageIndex] forKey:@"pagesize"];
    
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_organization" addParameters:dic success:^(WBYReqModel *model)
    {
        [_listArr removeAllObjects];

        
        if ([model.err isEqualToString:TURE])
        {
            if (numindex == 1)
            {
                [_listArr removeAllObjects];
            }
            
            [_listArr addObjectsFromArray:model.data];
            
        }
        
        if (model.data.count == 0)
        {
            [WBYRequest showMessage:@"此地区暂无机构"];
        }
        
        
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    } isRefresh:YES];
    
}








////////////////////////////////////////////////////
-(void)getData
{
    id hud = nil;
    hud = [JGProgressHelper showProgressInView:self.view];
   [self.userService get_all_areaWithsuccess:^(NSArray *areas) {
       [hud hide:YES];
       //取出省
       
       for (JwAreass *area in areas)
       {
           [_proTimeList addObject:area.area_name];
           [_proTimeListId addObject:area.area_id];
           
           //处理空数组
           if (area.child.count == 0)
           {
               [self creatTable];
               [self creatUI];

               return ;
           }
           else
           {
               [_allArr addObject:area.child];
           }
          
           
       }
   } failure:^(NSError *error)
    {
       
       [hud hide:YES];
       [JGProgressHelper showError:nil inView:self.view];
   }];
    
    
    
}
-(void)getListWithId:(NSString *)comId cityName:(NSString *)cityName provinceId:(NSString *)pId cityId:(NSString *)cId countryId:(NSString *)countryId
{
    //列表信息
    
    [_listArr removeAllObjects];//清空
    [self.dataService get_OrganizationWithCom_id:comId city_name:cityName province:pId city:cId county:countryId success:^(NSArray *lists) {
        
        for (WHorganization *model in lists)
        {
            [_listArr addObject:model];
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error)
    {
        
        
    }];
}


-(void)creatUI
{
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 100 -64, kScreenW, 100)];
    self.backView.backgroundColor  = [UIColor colorWithRed:67/255.0 green:98/255.0 blue:224/255.0 alpha:1.0];
    [self.view addSubview:_backView];
    
    self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2 - 50, 25, 100, 1)];
    self.lineLab.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:_lineLab];
    
    self.titLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW/2-20, 15, 40, 20)];
    self.titLab.backgroundColor = [UIColor colorWithRed:67/255.0 green:98/255.0 blue:224/255.0 alpha:1.0];
    self.titLab.text = @"筛选";
    self.titLab.textAlignment = NSTextAlignmentCenter;
    self.titLab.textColor = [UIColor whiteColor];
    self.titLab.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:_titLab];
    
    
    self.provinceView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, (kScreenW - 30)/3, 30)];
    self.provinceView.backgroundColor = [UIColor whiteColor];
    self.provinceView.layer.cornerRadius = 15;
    [self.backView addSubview:_provinceView];
    
    self.cityView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) + 5, 50, (kScreenW - 30)/3, 30)];
    self.cityView.backgroundColor = [UIColor whiteColor];
    self.cityView.layer.cornerRadius = 15;
    [self.backView addSubview:_cityView];
    
    
    self.areaView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_cityView.frame) + 5, 50, (kScreenW - 30)/3, 30)];
    self.areaView.backgroundColor = [UIColor whiteColor];
    self.areaView.layer.cornerRadius = 15;
    [self.backView addSubview:_areaView];
    
    
    self.provinceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.provinceBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.provinceBtn setTitle:_proTimeList[0] forState:UIControlStateNormal];
    self.provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.provinceBtn addTarget:self action:@selector(provinceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.provinceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.provinceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.provinceView addSubview:_provinceBtn];
    
    
    self.cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cityBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.cityBtn setTitle:@"请选择" forState:UIControlStateNormal];
    self.cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cityBtn addTarget:self action:@selector(cityBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cityBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.cityView addSubview:_cityBtn];
    
    
    self.areaBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.areaBtn.frame = CGRectMake(5, 3, CGRectGetWidth(_provinceView.frame) - 10, 30- 3 - 3);
    [self.areaBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [self.areaBtn addTarget:self action:@selector(areaBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.areaBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.areaBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.areaBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.areaView addSubview:_areaBtn];
    
    
    self.provinceImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_provinceBtn.frame) + 3, 8, 18)];
    self.provinceImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    //self.provinceImage.backgroundColor = [UIColor redColor];
    [self.provinceView addSubview:_provinceImage];
    
    
    self.cityImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_cityBtn.frame) + 3, 8, 18)];
    self.cityImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    
    [self.cityView addSubview:_cityImage];

    self.areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_provinceView.frame) - 30, CGRectGetMinY(_areaBtn.frame) + 3, 8, 18)];
    self.areaImage.image = [UIImage imageNamed:@"tjzh-2@3x"];
    //self.provinceImage.backgroundColor = [UIColor redColor];
    [self.areaView addSubview:_areaImage];

    // 选择框
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_provinceView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150 - 64 , CGRectGetWidth(_provinceView.frame), 200)];
    _pickerView.backgroundColor = [UIColor grayColor];
    // 显示选中框
    _pickerView.showsSelectionIndicator=YES;
    _pickerView.layer.cornerRadius = 5;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    _pickerView.hidden = YES;
    
    //选择框2
//    _mycityPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_cityView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150- 64 , CGRectGetWidth(_cityView.frame), 200)];
//    _cityPickerView.backgroundColor = [UIColor grayColor];
//    // 显示选中框
//    _cityPickerView.showsSelectionIndicator=YES;
//    _cityPickerView.layer.cornerRadius = 5;
//    _cityPickerView.dataSource = self;
//    _cityPickerView.delegate = self;
//    [self.view addSubview:_cityPickerView];
//    _cityPickerView.hidden = YES;
    
    
    //选择框3
    _areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_areaView.frame), kScreenH -CGRectGetHeight(_backView.frame) - 150- 64 , CGRectGetWidth(_areaView.frame), 200)];
    _areaPickerView.backgroundColor = [UIColor grayColor];
    // 显示选中框
    _areaPickerView.showsSelectionIndicator=YES;
    _areaPickerView.layer.cornerRadius = 5;
    _areaPickerView.dataSource = self;
    _areaPickerView.delegate = self;
    [self.view addSubview:_areaPickerView];
    _areaPickerView.hidden = YES;
    
}

//选择框
#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (pickerView == _pickerView)
    {
        return [_proTimeList count];
    }
//    else if (pickerView == _cityPickerView)
//    {
//        return [_cityArr count];
//    }
    else
    {
        return [_areaArr count];
    }
}


#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return CGRectGetWidth(_provinceView.frame);
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   
    
    if (pickerView == _pickerView)
    {
        NSString  *_proTimeStr = [_proTimeList objectAtIndex:row];
        
        [_provinceBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        
        _pickerView.hidden = YES;
        //刷新值
        [self getListWithId:self.cId cityName:@"" provinceId:[_proTimeListId objectAtIndex:row] cityId:@"" countryId:@""];
        
          //取出对应的区
        _cityAllArr = _allArr[row];
        [_areaAllArr removeAllObjects];
        [_cityArr removeAllObjects];
        for (JwAreass *city in _cityAllArr) {
           
            [_cityArr addObject:city.area_name];
            [_cityArrId addObject:city.area_id];
            [_areaAllArr addObject:city.child];
        }
//        [_cityPickerView reloadAllComponents];
        

    }
    else if (pickerView == _mycityPickerView)
    {
        NSString  *_proTimeStr = [_cityArr objectAtIndex:row];
        
        [_cityBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        _mycityPickerView.hidden = YES;
        //刷新值
        [self getListWithId:self.cId cityName:@"" provinceId:@""cityId:[_cityArrId objectAtIndex:row] countryId:@""];
        
        NSArray *arr = _areaAllArr[row];
        [_areaArr removeAllObjects];
        for (JwAreass *area in arr) {
            [_areaArr addObject: area.area_name];
            [_areaArrId addObject: area.area_id];
        }
        [_areaPickerView reloadAllComponents];
        
    }
    else
    {
        NSString  *_proTimeStr = [_areaArr objectAtIndex:row];
        
        [_areaBtn setTitle:_proTimeStr forState:UIControlStateNormal];
        _areaPickerView.hidden = YES;
        //刷新值
        [self getListWithId:self.cId cityName:@"" provinceId:@""cityId:@"" countryId:[_areaArrId objectAtIndex:row]];
    }
    
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     
    if (pickerView == _pickerView)
    {
        return [_proTimeList objectAtIndex:row];
    }
    else if (pickerView == _mycityPickerView)
    {
        return [_cityArr objectAtIndex:row];
    }
    else
    {
       return [_areaArr objectAtIndex:row];
    }
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    numindex = 1 ;
}
-(void)headerRereshing
{
    numindex = 1 ;
    
    [self requestleiBieDateDatalngproStr:@"" cityStr:@"" countyStr:@""];
    
    [self.tableView headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    
    [self requestleiBieDateDatalngproStr:@"" cityStr:@"" countyStr:@""];
    
    [self.tableView footerEndRefreshing];
    
}







-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chooseCell"];    
    WHorganization *model = _listArr[indexPath.row];    
    cell.addressLab.text = model.name;
    
   return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_delegate institutions:_listArr[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)provinceBtnAction
{

    _pickerView.hidden = NO;
    
}

-(void)cityBtnAction
{
    NSLog(@"点击了市");
    _mycityPickerView.hidden = NO;
}

-(void)areaBtnAction
{
    NSLog(@"点击了区");
    _areaPickerView.hidden = NO;
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
