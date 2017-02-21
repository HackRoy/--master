//
//  WBYHQGSviewController.m
//  whm_project
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYHQGSviewController.h"
#import "completeTableViewCell.h"
#import "NSString+PinYin.h"
#import "CMIndexBar.h"
#import "MJRefresh.h"

@interface WBYHQGSviewController ()<UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>

{
    UITableView * gongsiTab;
    CMIndexBar *indexBar;
    NSMutableArray * agongsiArray;
    NSMutableArray * _firstArr;
    NSInteger numindex;

}

@property (nonatomic,strong)NSMutableDictionary * dic;

@end

@implementation WBYHQGSviewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"保险公司";
    [self creatLeftTtem];
    
    numindex = 1;

    _firstArr = [NSMutableArray array];
    
    agongsiArray = [NSMutableArray array];
    
    self.dic = [NSMutableDictionary dictionary];
    
    [self requestBaoXianGongSi:_myStr?_myStr:@""];
    [self cratShaiXuanGongsi];
    
}

-(void)cratShaiXuanGongsi
{
   
    gongsiTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    gongsiTab.dataSource = self;
    gongsiTab.delegate =self;
    gongsiTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [gongsiTab registerClass:[completeTableViewCell class] forCellReuseIdentifier:@"comcell"];
    
    
    [self.view addSubview:gongsiTab];
    
   
    
    
}
- (void)createList
{
    
//    indexBar = [[CMIndexBar alloc] initWithFrame:CGRectMake(wScreenW-25, 60, 20, wScreenH  - 120-64)];
//    indexBar.textColor = [UIColor colorWithRed:61/255.0 green:163/255.0  blue:255/255.0  alpha:1.0];
//    indexBar.textFont = [UIFont systemFontOfSize:12];
//    [indexBar setIndexes:_firstArr];
//    indexBar.delegate = self;
//    [self.view addSubview:indexBar];
    
}
- (void)indexSelectionDidChange:(CMIndexBar *)indexBar index:(NSInteger)index title:(NSString *)title
{
    [gongsiTab scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];

}





#pragma mark===加载

-(void)headerRereshing
{
    numindex = 1 ;
  
    [self requestBaoXianGongSi:_myStr?_myStr:@""];
    [gongsiTab headerEndRefreshing];
    
    
}


//下拉
-(void)footerRefreshing
{
    numindex ++ ;
    [self requestBaoXianGongSi:_myStr?_myStr:@""];

    [gongsiTab footerEndRefreshing];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * key = _firstArr[section];
    return [[self.dic objectForKey:key] count];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _firstArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * key = _firstArr[indexPath.section];
    NSArray * arry = [self.dic objectForKey:key];
    DataModel * data = arry[indexPath.row];
    
    completeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"comcell" forIndexPath:indexPath];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:data.logo] placeholderImage:[UIImage imageNamed:@"leixing"]];
    cell.titleLab.text =  data.short_name?data.short_name:data.name;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 30;
}



-(void)requestBaoXianGongSi:(NSString *)str
{
    //    get_companys
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kb/get_companys"] forKey:@"kb"];
    [dic setObject:str forKey:@"type"];
    [dic setObject:@"" forKey:@"keyword"];
    
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    
    [dic setObject:@"1000" forKey:@"pagesize"];
    
    
    
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
             
             [_firstArr addObject:@"#"];

              [self createList];

         }
         if (model.data.count==0)
         {
             [WBYRequest showMessage:@"没有更多数据"];
         }
         
         [gongsiTab reloadData];
     } failure:^(NSError *error)
     {
     } isRefresh:NO];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * key = _firstArr[indexPath.section];
    NSArray * arry = [self.dic objectForKey:key];
    
    DataModel * data = arry[indexPath.row];
    
    
        if (data.id != nil && data.name != nil )
        {
            self.mblock1 (data.id ,data.name);
        }

    
     [self.navigationController popViewControllerAnimated:YES];
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return _firstArr[section];
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    return _firstArr;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    //点击索引，列表跳转到对应索引的行
    // [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index+1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
    [WBYRequest showMessage:title];
    
    
    return index;
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
