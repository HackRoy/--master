//
//  WBYdailirenViewController.m
//  whm_project
//  Created by apple on 17/1/17.
//  Copyright © 2017年 chenJw. All rights reserved.
#import "WBYdailirenViewController.h"
#import "MJRefresh.h"
#import "WHnearAgentTableViewCell.h"
#import "DaiLiRenLuJingViewController.h"
#import "WHLookforViewController.h"
#import "PickView.h"
#import "FujinViewController.h"
#import "completeTableViewCell.h"
#import "NSString+PinYin.h"
#import "CMIndexBar.h"
#import "WHministaViewController.h"

@interface WBYdailirenViewController ()<UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>
{
    UIView * gongsiView;
    UITableView * gongsiTab;
    CMIndexBar *indexBar;
    UITableView * myTab;
    NSMutableArray * allArr;
    NSArray * jinweiduArr;
    NSInteger numindex;
    NSString * tel;
    UIView *_chooseCityView;
    NSMutableArray * agongsiArray;
    NSMutableArray * _firstArr;
}
@property (nonatomic, strong) PickView * cityPickerView;
@property (nonatomic,strong)NSMutableDictionary * dic;
@end

@implementation WBYdailirenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatLeftTtem];
    _cityPickerView = [[PickView alloc] init];
    _cityPickerView.backgroundColor= wWhiteColor;
    numindex = 1;
    allArr = [NSMutableArray array];
    agongsiArray = [NSMutableArray array];
    _firstArr = [NSMutableArray array];
    self.dic = [NSMutableDictionary dictionary];
    self.title = @"附近代理人";
    
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ditudao"] style:(UIBarButtonItemStylePlain) target:self action:@selector(lujing)];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    [self requestleiBieDateDatalng:stringOne latStr:stringTwo proStr:@"" cityStr:@"" countyStr:@"" comId:@""];
    
    [self creatupView];
    
    [self requestBaoXianGongSi];
    
}

-(void)lujing
{
    FujinViewController * mapList = [[FujinViewController alloc]init];
    
    [self.navigationController pushViewController:mapList animated:YES];
}


-(void)creatupView
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 40)];
    
    [self.view addSubview:upView];
    
    NSArray * litArr = @[@"省/市/区",@"类别"];
    for (NSInteger i = 0; i<litArr.count; i++)
    {
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(i * wScreenW/2,0, wScreenW/2, 35);
        quxiaoBtn.tag = 1313 + i;
        [quxiaoBtn setTitle:litArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(dianji:) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:quxiaoBtn];
        
        UIButton * xiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        xiaoBtn.frame = CGRectMake(wScreenW/2 - 26, 10, 15, 15);
        xiaoBtn.tag = 3030 + i;
        [xiaoBtn setImage:[UIImage imageNamed:@"arrowT"] forState:UIControlStateNormal];
        [xiaoBtn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateSelected];
        [quxiaoBtn addSubview:xiaoBtn];
        
    }
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2, 0,0.8, 35)];
    lab.backgroundColor = wGrayColor;
    [upView addSubview:lab];
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 34,wScreenW, 0.8)];
    lab1.backgroundColor = wGrayColor;
    [upView addSubview:lab1];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH - 64 - 35) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    myTab.tag = 500;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[WHnearAgentTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.rowHeight = 90;
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTab addHeaderWithTarget:self action:@selector(headerRereshing)];
    [myTab addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self.view addSubview:myTab];
    
}

#pragma mark===点击省市区

-(void)dianji:(UIButton *)btn
{
    btn.selected = !btn.selected;
    UIButton * aBtn = [self.view viewWithTag:3030];
    UIButton * bBtn = [self.view viewWithTag:3031];
    if (btn.tag == 1313)
    {
        
//        [shaixuanView removeFromSuperview];
        
        [gongsiView removeFromSuperview];
        if (btn.selected == YES)
        {
             [self creatpickvie];
            aBtn.selected = YES;
            bBtn.selected = NO;
//            [self creatFenLei];
        }else
        {
            [_cityPickerView hiddenPickerView];
            aBtn.selected = NO;
//            [feileibgView removeFromSuperview];
        }
        
    }
    if (btn.tag == 1314)
    {
//        [feileibgView removeFromSuperview];
        
         [_cityPickerView hiddenPickerView];
        
        if (btn.selected == YES)
        {
            bBtn.selected = YES;
            aBtn.selected = NO;
            [self cratShaiXuanGongsi];

        }else
        {
            [gongsiView removeFromSuperview];
            bBtn.selected = NO;
//            [shaixuanView removeFromSuperview];
        }
    }
 }

#pragma mark===请求公司
-(void)requestBaoXianGongSi
{
//    get_companys
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kb/get_companys"] forKey:@"kb"];
    [dic setObject:@"1,2" forKey:@"type"];
    [dic setObject:@"" forKey:@"keyword"];
    [dic setObject:@"1" forKey:@"p"];
    [dic setObject:@"100" forKey:@"pagesize"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_companys" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             [_firstArr removeAllObjects];
             [agongsiArray removeAllObjects];
             for (DataModel * data in model.data)
             {
                 [agongsiArray addObject:data];
             }
             NSArray * array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
             for (NSString * str in array)
             {
                 NSMutableArray * modelAry = [@[] mutableCopy];
                 for (DataModel * data in agongsiArray)
                 {
                     if ([[data.name getFirstLetter] isEqualToString:str])
                     {
                         [modelAry addObject:data];
                     }
                 }
                 if (modelAry.count !=0)
                 {
                     NSDictionary * smallDic = @{str : modelAry};
                     [self.dic addEntriesFromDictionary:smallDic];
                     [_firstArr addObject:str];
                     
                 }
                 
             }
         }
         [gongsiTab reloadData];
     } failure:^(NSError *error)
     {
     } isRefresh:NO];
}


#pragma mark==公司筛选
-(void)cratShaiXuanGongsi
{
    gongsiView = [[UIView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH -64-35)];
    [self.view addSubview:gongsiView];
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64 - 35) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.tag = 1000;
    gongsiTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [gongsiTab registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [gongsiView addSubview:gongsiTab];
   
    [self createList];
    
    
}
- (void)createList
{
    
    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(wScreenW-25, 30, 25.0, wScreenH - 40 - 35 - 60- 50)];
    //        indexBar.backgroundColor = [UIColor redColor];
    indexBar.textColor = [UIColor colorWithRed:61/255.0 green:163/255.0  blue:255/255.0  alpha:1.0];
    indexBar.textFont = [UIFont systemFontOfSize:12];
    [indexBar setIndexes:_firstArr];
    indexBar.delegate = self;
    [gongsiView addSubview:indexBar];
    
}
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    [gongsiTab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSLog(@"=%ld===%@",(long)index,title);
}

-(void)creatpickvie
{
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
    UIButton * aBtn = [self.view viewWithTag:1313];
    UIButton * xiaoaBtn = [self.view viewWithTag:3030];
    UIButton * xiaobBtn = [self.view viewWithTag:3031];
    
    xiaoaBtn.selected = NO;
    xiaobBtn.selected = NO;
    if ([sender.titleLabel.text isEqualToString:@"确定"])
    {
        
        aBtn.titleLabel.text = [NSString stringWithFormat:@"%@",_cityPickerView.qu];
        
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:_cityPickerView.idprovence.length>1?_cityPickerView.idprovence:@"" cityStr:_cityPickerView.idcity.length>1?_cityPickerView.idcity:@"" countyStr:_cityPickerView.idarea.length>1?_cityPickerView.idarea:@"" comId:@""];
    }
    [_cityPickerView hiddenPickerView];
    
}
#pragma mark===加载

-(void)headerRereshing
{
    
    UIButton * aBtn = [self.view viewWithTag:1313];
    
    aBtn.titleLabel.text =@"省/市/区";
    numindex = 1 ;
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    [self requestleiBieDateDatalng:stringOne latStr:stringTwo proStr:@"" cityStr:@"" countyStr:@"" comId:@""];
    //    [self creatRequest];
    [myTab headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    UIButton * aBtn = [self.view viewWithTag:1313];

    aBtn.titleLabel.text =@"省/市/区";
    numindex ++ ;
    //    [self creatRequest];
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    NSString * stringOne = [ud valueForKey:@"one"];
    NSString * stringTwo = [ud valueForKey:@"two"];
    
    [self requestleiBieDateDatalng:stringOne latStr:stringTwo proStr:@"" cityStr:@"" countyStr:@"" comId:@""];

    [myTab footerEndRefreshing];
    
}


#pragma mark===tab代理事件数据源事件

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 500)
    {
        return allArr.count;
    }else
    {
        NSString * key = _firstArr[section];
        return [[self.dic objectForKey:key] count];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 1000)
    {
        return _firstArr.count;
    }else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 500)
    {
        WHnearAgentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [_cityPickerView hiddenPickerView];
        [cell.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
        
        DataModel * dataMod = allArr[indexPath.row];
        cell.nameLaber.text = dataMod.data.name.length >2?dataMod.data.name:@"未知";
        [cell.myImage sd_setImageWithURL:[NSURL URLWithString:dataMod.data.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Jw_user"]];
        
        if ([dataMod.data.sex isEqualToString: @"2"])
        {
            cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
        }else
        {
            cell.sexImg.image = [UIImage imageNamed:@"test_male"];
        }
        cell.mapImg.image = [UIImage imageNamed:@"maple"];
        cell.telImg.image = [UIImage imageNamed:@"tel"];
        cell.telLaber.text = dataMod.data.mobile;
        cell.companyLaber.text = dataMod.data.com_name;
        cell.addressLaber.text  = dataMod.data.job_address.length > 2?dataMod.data.job_address:@"未知地址";
        
        
        if ([dataMod.dist floatValue] <1000)
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfM",[dataMod.dist floatValue]];
        }else
        {
            cell.mapLaber.text = [NSString stringWithFormat:@"%.2lfKM",[dataMod.dist floatValue]/1000];
        }
        cell.telBut.tag = 50 + indexPath.row;
        [cell.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.myImage.tag = 3300 + indexPath.row;
        [cell.myImage addTarget:self action:@selector(onClickUILable:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;

        
    }else
    {
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * data = arry[indexPath.row];
        
        completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:data.logo] placeholderImage:[UIImage imageNamed:@"leixing"]];
        cell.titleLab.text =  data.short_name?data.short_name:data.name;
        return cell;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //OrderCityModer *order = self.countryArr[section];
    UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wScreenW, 30)];
    myView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0  blue:241/255.0  alpha:1.0];
    
    UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 100, 30)];
    myLab.backgroundColor = [UIColor clearColor];
    myLab.text = _firstArr[section];
    myLab.font = [UIFont systemFontOfSize:16];
    myLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0  blue:0/255.0  alpha:1.0];
    
    [myView addSubview:myLab];
    
    return myView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 1000)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 500)
    {
        DataModel * dataMod = allArr[indexPath.row];
        DaiLiRenLuJingViewController * map = [[DaiLiRenLuJingViewController alloc] init];
        map.p_myImg = dataMod.data.avatar.length > 2?dataMod.data.avatar:@"";
        map.p_myName = dataMod.data.name.length >2?dataMod.data.name:@"未知";
        NSString * strLab = [dataMod.data.com_name stringByAppendingString:dataMod.data.profession?dataMod.data.profession:@""];
        NSString * strWork = [strLab stringByAppendingString:dataMod.data.work_time.length>1?dataMod.data.work_time:@""];
        map.p_myPro = [strWork stringByAppendingString:dataMod.data.service_area?dataMod.data.service_area:@""];
        map.p_mySex = dataMod.data.sex?dataMod.data.sex:@"";
        map.p_myMobile = dataMod.data.mobile?dataMod.data.mobile:@"";
        map.p_myAge = dataMod.data.age?dataMod.data.age:@"";
        map.pjopAddress = dataMod.data.job_address;
        
        if (dataMod.location.coordinates.count>1)
        {
            map.pjingdu = dataMod.location.coordinates[0];
            map.pweidu = dataMod.location.coordinates[1];
        }else
        {
            map.pweidu = @"";
            map.pweidu = @"";
        }
        [self.navigationController pushViewController:map animated:YES];
    }else
    {
        UIButton  * btn = [self.view viewWithTag:1314];
        btn.selected = NO;
        UIButton * bBtn = [self.view viewWithTag:3031];
        bBtn.selected = NO;
        NSString * key = _firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        
        DataModel * data = arry[indexPath.row];
        [self requestleiBieDateDatalng:@"" latStr:@"" proStr:@"" cityStr:@"" countyStr:@"" comId:data.id.length>=1?data.id:@""];
        [gongsiView removeFromSuperview];
    }
 }

//图片点击事件
-(void)onClickUILable:(UIButton *)sender
{
    DataModel * data = allArr[sender.tag - 3300];
   WHministaViewController * look = [[WHministaViewController alloc]init];
    look.StrAgentId = data.id;
    look.selectDiffent = @"1";
    [self.navigationController pushViewController:look animated:YES];
}

-(void)telAction:(UIButton *)btn
{
    DataModel * data = allArr[btn.tag - 50];
    
    if (data.data.mobile.length >8)
    {
        tel = data.data.mobile;
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        
        [view show];
        
    }else
    {
        [WBYRequest showMessage:@"无法获取电话"];
        return;
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

-(void)requestleiBieDateDatalng:(NSString*)lng   latStr:(NSString * )alatStr  proStr:(NSString *)proStr  cityStr:(NSString *)cityStr countyStr:(NSString *)countyStr comId:(NSString *)comId
{
     NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:lng forKey:@"lng"];
    [dic setObject:[WBYRequest jiami:@"kb/get_near_agent"] forKey:@"kb"];
    [dic setObject:alatStr forKey:@"lat"];
    [dic setObject:@"" forKey:@"city_name"];

    [dic setObject:proStr forKey:@"province"];
    [dic setObject:cityStr forKey:@"city"];
    [dic setObject:countyStr forKey:@"county"];
    
    [dic setObject:comId forKey:@"com_id"];
    [dic setObject:@"agent" forKey:@"type"];

    [dic setObject:@"20000" forKey:@"distance"];
    [dic setObject:@"" forKey:@"map"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"15" forKey:@"pagesize"];

    [WBYRequest wbyPostRequestDataUrl:@"kb/get_near_agent" addParameters:dic success:^(WBYReqModel *model)
    {
        
        if ([model.err isEqualToString:TURE])
        {
            if (numindex == 1)
            {
                [allArr removeAllObjects];
            }
            [allArr addObjectsFromArray:model.data];
            
        }
        if (model.data.count==0)
        {
            
            [WBYRequest showMessage:@"没有更多数据"];
        }
        
        [myTab reloadData];
        
    } failure:^(NSError *error) {
        
    } isRefresh:NO];
    
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
