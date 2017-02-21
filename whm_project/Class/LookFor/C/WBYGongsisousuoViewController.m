//
//  WBYGongsisousuoViewController.m
//  whm_project
//
//  Created by apple on 17/1/11.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYGongsisousuoViewController.h"
#import "BaoXianXiangQingTableViewCell.h"
#import "MJRefresh.h"
#import "completeTableViewCell.h"
#import "NSString+PinYin.h"
#import "CMIndexBar.h"
#import "WCPXQViewController.h"
#import "JwLoginController.h"

@interface WBYGongsisousuoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>
{
    UITableView * myTab;
    NSMutableArray * allArr;
    NSInteger numindex;

    UITableView *tableV1;
    UITableView *tableV2;
    UIView * feileibgView;
    
    NSMutableArray * feileiArr;
    NSMutableArray * feileiArr1;
    NSMutableArray * feileiArr2;
    NSMutableArray * mypidArr;
    NSMutableArray * idArr;

    NSString * mypid;
    NSString * myid;
    
    UIView * shaixuanView;
    UIView * downView;
    UIView * gongsiView;

    UITableView * gongsiTab;
    CMIndexBar *indexBar;
    NSMutableArray * ageArray;
    NSMutableArray * ageIdArray;

}

@property (nonatomic, strong) UISearchBar * searchBar;

@property (strong, nonatomic) NSMutableArray * allcompanyArr;
@property (strong, nonatomic) NSMutableArray * firstArr;
//@property (strong, nonatomic) NSArray *suoyinDataSource;/**<索引数据源*/
//@property (strong, nonatomic) NSArray * baoxiangDataSource;


@property (nonatomic,strong)NSMutableDictionary * dic;

@end

@implementation WBYGongsisousuoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    numindex =  1;
    allArr = [NSMutableArray array];
    
    feileiArr = [NSMutableArray array];
    feileiArr1 = [NSMutableArray array];
    feileiArr2 = [NSMutableArray array];
    mypidArr = [NSMutableArray array];
    idArr = [NSMutableArray array];
    
    _allcompanyArr = [NSMutableArray array];
    _firstArr = [NSMutableArray array];
//    _suoyinDataSource = [NSArray array];
//    _baoxiangDataSource = [NSArray array];
    
    ageArray = [NSMutableArray arrayWithObjects:@"不限", nil];
    ageIdArray = [NSMutableArray arrayWithObjects:@"", nil];
    
    //[ageArray addObject:@"不限"];
    
    self.dic = [NSMutableDictionary dictionary];

    
    
    if (_mgId.length > 3)
    {
        
       [self requestData:@"" companyid:@"" mongoid:_mgId cateid:@"" age:@"" ids:@""];
        
    }else
    {
        [self requestData:_mySte companyid:@"" mongoid:@"" cateid:@"" age:@"" ids:@""];
    }
    
    [self requestAge];
    [self requestBaoXianGongSi];
    [self requestFenLei];
    [self creatTitView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationItem setHidesBackButton:YES];
    numindex =  1;
}
-(void)creatTitView
{
     _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(20, 20,wScreenW-40, 38)];
     _searchBar.backgroundImage = [[UIImage imageNamed:@"1-3-长条首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
//      _searchBar.placeholder = @"请输入搜索内容";
      _searchBar.delegate = self;
      _searchBar.text = _mySte;
    
//    for (UIView *view in customSearchBar.subviews) {
//        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 1) {
//            if ( [[view.subviews objectAtIndex:1] isKindOfClass:[UITextField class]]) {
//                UITextField *textField = (UITextField *)[view.subviews objectAtIndex:1];
//                [textField setClearButtonMode:UITextFieldViewModeNever];    // 不需要出现clearButton
//            }
//            break;
//        }
//    }
      self.navigationItem.titleView = _searchBar;
    
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW - 60, 13 ,1, 18)];
        lab.backgroundColor = wGrayColor;
        [_searchBar addSubview:lab];
    
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(CGRectGetMaxX(lab.frame)+5,6, 30, 30);
        [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor forState:UIControlStateNormal];
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
        [quxiaoBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
        quxiaoBtn.tag= 33333;
        quxiaoBtn.hidden = YES;

        [_searchBar addSubview:quxiaoBtn];
    
         [self creatTab];
}

-(void)creatTab
{
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 40)];
    
    [self.view addSubview:upView];
    
    NSArray * litArr = @[@"分类",@"筛选"];
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
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [myTab registerClass:[BaoXianXiangQingTableViewCell class] forCellReuseIdentifier:@"cell"];
    
        myTab.rowHeight = 80;
    [myTab addHeaderWithTarget:self action:@selector(headerRereshing)];
    [myTab addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    [self.view addSubview:myTab];
    
}

-(void)headerRereshing
{
    numindex = 1 ;
        
    [self requestData:_searchBar.text?_searchBar.text:@"" companyid:@"" mongoid:@"" cateid:@"" age:@"" ids:@""];
    
    [myTab headerEndRefreshing];
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
//    [self creatRequest];
    
    [self requestData:_searchBar.text?_searchBar.text:@"" companyid:@"" mongoid:@"" cateid:@"" age:@"" ids:@""];
    [myTab footerEndRefreshing];
    
}
#pragma mark===代理tab

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView.tag == 3000)
    {
      return   _firstArr.count;
        
    }else
    {
      return 1;
     }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 500)
    {
        return allArr.count;

    }else if (tableView.tag == 1000)
    {
        return feileiArr1.count;
    }else if (tableView.tag == 3000)
    {
        NSString * key = self.firstArr[section];
        return [[self.dic objectForKey:key] count];
    }
    else
    {
        return feileiArr2.count + 1;
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
    if (tableView.tag == 3000)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 500)
    {
        DataModel * data = allArr[indexPath.row];
        BaoXianXiangQingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        [cell.lImg sd_setImageWithURL:[NSURL URLWithString:data.img.length>8?data.img:data.logo]];
        
        cell.upLab.text = data.name;
        cell.midL.text = [NSString stringWithFormat:@"投保年龄:%@",data.limit_age_name.length > 1?data.limit_age_name:@"暂无"];  //limit_age_name
        cell.midR.text = [NSString stringWithFormat:@"产品类型:%@",data.pro_type_code_name.length >1 ?data.pro_type_code_name:@"暂无"];
        
        NSArray * arr = [data.sign componentsSeparatedByString:@","];
        
        if (arr.count == 1)
        {
            cell.downR.text = arr[0];
            cell.downR1.hidden= YES;
        }else
        {
            cell.downR.text = arr[0];
            cell.downR1.text = arr[1];
        }
        return cell;
        
        
    }
    else if (tableView.tag == 1000)
    {
        static NSString *cellId = @"identify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = wGrayColor2;
        cell.textLabel.text = feileiArr1[indexPath.row];
        
        return cell;
    }
    if (tableView.tag == 2000)
    {
        static NSString *cellId2 = @"cell22";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
        
        if (!cell2)
        {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
        }
        if (indexPath.row == 0)
        {
            cell2.textLabel.text = @"全部";
            
            
        }else
        {
            cell2.textLabel.text = feileiArr2[indexPath.row - 1];
        }
        cell2.textLabel.font = [UIFont systemFontOfSize:12];
        cell2.textLabel.textColor = wGrayColor2;
         return cell2;

    }
    
    if (tableView.tag == 3000)
    {
    NSString * key = self.firstArr[indexPath.section];
    NSArray * arry = [self.dic objectForKey:key];
    DataModel * data = arry[indexPath.row];

    completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
        
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:data.logo] placeholderImage:[UIImage imageNamed:@"leixing"]];
    cell.titleLab.text = data.short_name;
        
        return cell;
    }
    
    return nil;
}

-(void)quxiao
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark===搜索


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:NO];
//    [searchBar resignFirstResponder];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:33333];
    
    if (searchText.length < 1)
    {
        btn.hidden = NO;
    }else
    {
        btn.hidden = YES;
    }
    
    
    
}

-(void)dianjishaixuan
{
     shaixuanView = [[UIView alloc] initWithFrame:CGRectMake(0, 35, wScreenW, wScreenH - 64 - 35)];
    shaixuanView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shaixuanView];
    
    UIView * upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 35)];
    
    [shaixuanView addSubview:upView];
    
    NSArray * litArr = @[@"年龄阶段",@"保险公司"];
    for (NSInteger i = 0; i<litArr.count; i++)
    {
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(i * wScreenW/2,0, wScreenW/2, 34);
        quxiaoBtn.tag = 6666 + i;
        [quxiaoBtn setTitle:litArr[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
        [upView addSubview:quxiaoBtn];
    }
    
    UILabel * myaLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, wScreenW/2, 1)];
    myaLab.tag = 8888;
    myaLab.backgroundColor = wBlue;
    [upView addSubview:myaLab];
    
    [self creatNianlingDownView];
    
}

-(void)creatNianlingDownView
{
    downView = [[UIView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH - 40-64-35)];
    [shaixuanView addSubview:downView];
    
    CGFloat ww = (wScreenW - 5*6)/4;
    
    for (NSInteger i = 0; i< ageArray.count; i++)
    {
        NSInteger aa = i%4;
        NSInteger bb = i/4;
        UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        quxiaoBtn.frame = CGRectMake(6 + (ww + 6)*aa,16 + (16 + 30)*bb, ww, 30);
        quxiaoBtn.tag = 5858 + i;
        [quxiaoBtn setTitle:ageArray[i] forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        [quxiaoBtn setTitleColor:wWhiteColor forState:UIControlStateSelected];
        
        if (i == 0)
        {
            quxiaoBtn.selected = YES;
            quxiaoBtn.backgroundColor = wBlue;
        }
        quxiaoBtn.layer.masksToBounds = YES;
        quxiaoBtn.layer.borderColor = wGrayColor2.CGColor;
        quxiaoBtn.layer.borderWidth = 0.6;
        quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [quxiaoBtn addTarget:self action:@selector(nianling:) forControlEvents:UIControlEventTouchUpInside];
        [downView addSubview:quxiaoBtn];
        
    }
 
}

#pragma mark==公司筛选
-(void)cratShaiXuanGongsi
{
    gongsiView = [[UIView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH - 40-64-35)];
    [shaixuanView addSubview:gongsiView];
    
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64 -40-35) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.tag = 3000;
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [gongsiTab registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"comcell"];
    [gongsiView addSubview:gongsiTab];
    
    [self createList];
    
}

#pragma mark===请求公司
-(void)requestBaoXianGongSi
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kb/get_pro_com"] forKey:@"kb"];
    [dic setObject:_mySte.length>3?_mySte:@"" forKey:@"keyword"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_pro_com" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            [_firstArr removeAllObjects];
            
            [_allcompanyArr removeAllObjects];
            for (DataModel * data in model.data)
            {
                [_allcompanyArr addObject:data];
            }
              NSArray * array = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"Q",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
            for (NSString * str in array)
            {
                NSMutableArray * modelAry = [@[] mutableCopy];
                for (DataModel * data in _allcompanyArr)
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
    } failure:^(NSError *error) {
        
    } isRefresh:NO];
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
    NSLog(@"=%ld===%@",index,title);
    
}




#pragma mark

#pragma mark===点击事件 分类 筛选

-(void)dianji:(UIButton *)btn
{
    btn.selected = !btn.selected;
    UIButton * aBtn = [self.view viewWithTag:3030];
    UIButton * bBtn = [self.view viewWithTag:3031];
    
    if (btn.tag == 1313)
    {
        [shaixuanView removeFromSuperview];
        
        if (btn.selected == YES)
        {
            aBtn.selected = YES;
            bBtn.selected = NO;
            [self creatFenLei];
        }else
        {
            aBtn.selected = NO;
            [feileibgView removeFromSuperview];
        }
    }
    if (btn.tag == 1314)
    {
        [feileibgView removeFromSuperview];
        
        if (btn.selected == YES)
        {
            bBtn.selected = YES;
            aBtn.selected = NO;
            [self dianjishaixuan];
            
        }else
        {
            bBtn.selected = NO;
            [shaixuanView removeFromSuperview];
        }
    }
    
}

-(void)shaixuan:(UIButton * )btn
{
    
    UILabel * lab = [self.view viewWithTag:8888];
    lab.center = CGPointMake(btn.center.x,btn.center.y + 17);
    
    if (btn.tag == 6666)
    {
        [gongsiView removeFromSuperview];
        [self creatNianlingDownView];
    }
    else
    {
        [downView removeFromSuperview];
        [self cratShaiXuanGongsi];
 
    }
}


-(void)nianling:(UIButton * )btn
{
    btn.selected = !btn.selected;
    
    UIButton  * btn1 = [self.view viewWithTag:1314];
    UIButton * bBtn = [self.view viewWithTag:3031];
    
    btn1.selected = NO;
    bBtn.selected = NO;
    
    for (NSInteger i = 0; i < 7; i++)
    {
        UIButton * abTn = [self.view viewWithTag:5858 + i];
        abTn.selected = NO;
        abTn.backgroundColor = wWhiteColor;
    }
    btn.selected = YES;
    btn.backgroundColor = wBlue;
    
    [shaixuanView removeFromSuperview];
    
    [self requestData:_mySte companyid:@"" mongoid:@"" cateid:@"" age:ageIdArray[btn.tag - 5858] ids:@""];
    
    
    /*
    NSString * myStr ;
    if (btn.tag == 5858)
    {
       myStr = @"";
    }else if (btn.tag == 5859)
    {
     myStr = @"0,1,2,3";
        
    }else if (btn.tag == 5858 + 2)
    {
        myStr = @"4,5,6,7,8,9,10,11,12,13,14,15,16,17";
        
    }else if (btn.tag == 5858 +3)
    {
    myStr = @"18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50";
        
    }else if (btn.tag == 5858 +4)
    {
        myStr = @"51,52,53,54,55,56,57,58,59,60";
        
    }else if (btn.tag == 5858 + 5)
    {
        myStr = @"61";
    }
    
    */
    
   
    
}
#pragma mark====请求解析
-(void)requestData:(NSString *)keyWord companyid:(NSString *)company mongoid:(NSString *)aId cateid:(NSString *)cate age:(NSString *)Aage ids:(NSString *)ids
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:keyWord forKey:@"keyword"];
    [dic setObject:[WBYRequest jiami:@"kb/get_pros"] forKey:@"kb"];
    [dic setObject:company forKey:@"company_id"];
    [dic setObject:aId forKey:@"mongo_id"];
    [dic setObject:cate forKey:@"cate_id"];
    [dic setObject:Aage.length<1?@"":Aage forKey:@"age"];
    [dic setObject:ids forKey:@"ids"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"30" forKey:@"pagesize"];
  
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_pros" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            if (numindex == 1)
            {
                [allArr removeAllObjects];
            }
            [allArr addObjectsFromArray:model.data];
            
            if (model.data.count < 1)
            {
                [WBYRequest showMessage:@"没有更多数据"];
            }
            
        }
        [myTab reloadData];
//        [WBYRequest showMessage:model.info];
        
    } failure:^(NSError *error) {
        
    } isRefresh:YES];
    
}

-(void)creatFenLei
{
    
    feileibgView = [[UIView alloc] initWithFrame:CGRectMake(0,35, wScreenW, wScreenH-64-35)];
    
    [self.view addSubview:feileibgView];
    tableV1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreenW/2, wScreenH-64-35) style:UITableViewStylePlain];
    tableV1.delegate = self;
    tableV1.dataSource = self;
    
    tableV1.separatorStyle = UITableViewCellSeparatorStyleNone;

    tableV1.tag = 1000;
    [feileibgView addSubview:tableV1];
    
    tableV2 = [[UITableView alloc]initWithFrame:CGRectMake(wScreenW/2, 0, wScreenW/2, wScreenH-64-35) style:UITableViewStylePlain];
    tableV2.delegate = self;
    tableV2.tag = 2000;
    tableV2.dataSource = self;
    tableV2.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    [feileibgView addSubview:tableV2];
    
   [self tableView:tableV1 didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [tableV1 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([JwUserCenter sharedCenter].uid == nil) {
        [JGProgressHelper showError:@"请登录您的账号"];
        JwLoginController * login = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
    else
    {
    
    UITableView * atb = [self.view viewWithTag:2000];
    
    if (tableView.tag == 500)
    {
        DataModel * mymod = allArr[indexPath.row];
        WCPXQViewController * wcp = [WCPXQViewController new];
        wcp.dataModel = mymod;
        
        [self.navigationController pushViewController:wcp animated:YES];
    }
    if (tableView.tag == 1000)
    {
        if (mypidArr.count >=1)
        {
            mypid = mypidArr[indexPath.row];
            [feileiArr2 removeAllObjects];
            for (DataModel * mod in feileiArr)
            {
                if ([mod.p_id isEqualToString:mypid])
                {
                    [feileiArr2 addObject:mod.name];
                    [idArr addObject:mod.id];
                }
            }
            
            [atb reloadData];
         }
        
        
    }
    if (tableView.tag == 2000)
    {
        UIButton  * btn = [self.view viewWithTag:1313];
        btn.selected = NO;
        
        UIButton * aBtn = [self.view viewWithTag:3030];
        aBtn.selected = NO;
        
        [feileibgView removeFromSuperview];
        
        if (indexPath.row == 0)
        {
           [self requestData:_mySte companyid:@"" mongoid:@"" cateid:mypid age:@"" ids:@""];
        }else
        {
             [self requestData:_mySte companyid:@"" mongoid:@"" cateid:idArr[indexPath.row - 1] age:@"" ids:@""];
        }
        
    }
    
    if (tableView.tag == 3000)
    {
        
        UIButton  * btn = [self.view viewWithTag:1314];
        btn.selected = NO;
        UIButton * bBtn = [self.view viewWithTag:3031];
        bBtn.selected = NO;
        NSString * key = self.firstArr[indexPath.section];
        NSArray * arry = [self.dic objectForKey:key];
        DataModel * data = arry[indexPath.row];
        
      [self requestData:_mySte companyid:data.id.length>=1?data.id:@"" mongoid:@"" cateid:@"" age:@"" ids:@""];
        
        [shaixuanView removeFromSuperview];
    }
    
    }
    
}

-(void)requestFenLei
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kb/get_app_cate"] forKey:@"kb"];
    
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_app_cate" addParameters:dic success:^(WBYReqModel *model)
     {
         
         [feileiArr1 removeAllObjects];
         [feileiArr removeAllObjects];
         
         if ([model.err isEqualToString:TURE])
         {
             [feileiArr addObjectsFromArray:model.data];
             
             for (DataModel * data in model.data)
             {
                 if ([data.p_id isEqualToString:@"1"] || [data.p_id isEqualToString:@"2"])
                    {
                        [feileiArr1 addObject:data.name];
                        
                        [mypidArr addObject:data.id];
                    }
             }
          }
         
         [tableV2 reloadData];
         
    } failure:^(NSError *error)
     {
        
    } isRefresh:NO];
    
    
}


-(void)requestAge
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[WBYRequest jiami:@"kb/get_age_group"] forKey:@"kb"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_age_group" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {            
            for (DataModel * data in model.data)
            {
                [ageArray addObject:data.name];
                [ageIdArray addObject:data.id];
            }
        }
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
