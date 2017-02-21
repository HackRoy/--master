//
//  SouSuoViewController.m
//  whm_project
//
//  Created by apple on 17/1/6.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "SouSuoViewController.h"
#import "WBYSouSuoTableViewCell.h"
#import "iflyMSC/iflyMSC.h"
#import "IATConfig.h"
#import "GSMacros.h"
#import "WBYGongsisousuoViewController.h"
#import "PlayVcEverLike.h"

@interface SouSuoViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,IFlyRecognizerViewDelegate>
{
    UITableView * myTab;
    NSArray * myArr;
    NSMutableArray * allArr;
    NSString * lishi;
    
    BOOL isSearch;
    
}
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property (nonatomic, strong) UISearchBar * searchBar;

@end

@implementation SouSuoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
   [self.navigationItem setHidesBackButton:YES];
    isSearch = NO;
    
    if (_str)
    {
        _searchBar.text = _str;
        isSearch = YES;
        [self requestData:_str];
    }else
    {
        isSearch = NO;

        myArr = [PlayVcEverLike getVids];
    }
    
    if (lishi.length > 1)
    {
        UIButton * btn = [_searchBar viewWithTag:3333];
        
        btn.hidden = YES;
       _searchBar.text = lishi;
        isSearch = YES;
        [self requestData:lishi];
    }
    else
    {
        isSearch = NO;
        myArr = [PlayVcEverLike getVids];
        
    }
    
    if (myArr.count >=1)
    {
        myTab.tableFooterView.hidden=NO;
  
    }else
    {
        myTab.tableFooterView.hidden=YES;
    }
    [myTab reloadData];
}

#pragma mark===请求
-(void)requestData:(NSString *)str
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"keyword"];
    [dic setObject:[WBYRequest jiami:@"kb/get_keyword"] forKey:@"kb"];
   
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_keyword" addParameters:dic success:^(WBYReqModel *model)
     {
         [allArr removeAllObjects];
         
         if ([model.err isEqualToString:TURE])
         {
             [allArr addObjectsFromArray:model.data];
         }
         else
         {
             [WBYRequest showMessage:model.info];
         }
         myTab.tableFooterView.hidden=YES;

         [myTab reloadData];
         
     } failure:^(NSError *error)
    {
         
     } isRefresh:NO];
    
//    [_searchBar resignFirstResponder];
 }

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    allArr = [NSMutableArray array];
    
    [self writemyUi];
}

-(void)writemyUi
{
    UIView * bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 44)];
    bgview.contentMode=UIViewContentModeScaleAspectFit;
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,wScreenW, 44)];

   _searchBar.placeholder = @"请输入搜索内容";
    _searchBar.delegate = self;
    
    self.navigationItem.titleView = self.searchBar;
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(wScreenW  - 50-30 ,12, 20, 20);
    [myBtn setImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:myBtn];
    
     UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(myBtn.frame), 13 ,1, 18)];
    lab.backgroundColor = wGrayColor;
    [_searchBar addSubview:lab];
    
    UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaoBtn.frame = CGRectMake(CGRectGetMaxX(lab.frame)+5,6,30, 30);
    [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    quxiaoBtn.tag =3333;
    [quxiaoBtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
    quxiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
    [quxiaoBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [_searchBar addSubview:quxiaoBtn];
    
    [self creatTab];
}

-(void)quxiao
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    
    [self changeOnclick];
}

#pragma mark===点击搜索

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    [_searchBar resignFirstResponder];
//    return YES;
//}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    UIButton * btn = [[[UIApplication sharedApplication].delegate window] viewWithTag:3333];
    
    if (_searchBar.text.length < 1)
    {
        btn.hidden = NO;

        isSearch = NO;
        [myTab reloadData];
    }else
    {
        btn.hidden = YES;

        isSearch = YES;
        [self requestData:_searchBar.text];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    isSearch = YES;

     WBYGongsisousuoViewController * wby = [WBYGongsisousuoViewController new];
    [self searchByKeyword:_searchBar.text];
    
    wby.mySte = _searchBar.text;
    lishi = _searchBar.text;
    
    [self.navigationController pushViewController:wby animated:NO];
    
//    [self requestData:_searchBar.text];
//    _searchBar.text = @"";
}

-(void)searchByKeyword:(NSString *)keyWord
{
    [PlayVcEverLike writeToFileDocumentPathByVid:keyWord];
//    [self.searchBar resignFirstResponder];
    myArr = [PlayVcEverLike getVids];
//    myTab.tableFooterView.hidden = NO;

    [myTab reloadData];
}
-(void)creatTab
{
    UIView * bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, wScreenW,360);
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 20, wScreenW, 30);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitle:@"清除历史记录" forState:UIControlStateNormal];
    [btn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(qingchujulu) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
   
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0,wScreenW, wScreenH - 64 ) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    myTab.rowHeight = 40;
    myTab.tableFooterView = bgView;
    
    [myTab registerClass:[WBYSouSuoTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
        [self.view addSubview:myTab];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearch == YES)
    {
        return allArr.count;
        
    }else
    {
        return myArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYSouSuoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (isSearch == NO)
    {
        cell.lImg.image = [UIImage imageNamed:@"search_history"];
        cell.myLab.text = myArr[indexPath.row];
        
            [cell.rbtn removeFromSuperview];
            [cell.rImg removeFromSuperview];
            cell.rImg = [[UIImageView alloc] init];
            cell.rImg.frame = CGRectMake(wScreenW - 30 - 10 , 10, 20, 20);
            cell.rImg.image = [UIImage imageNamed:@"item_jiantou"];
            [cell.contentView addSubview:cell.rImg];
        
    }else
    {
            DataModel * model = allArr[indexPath.row];
            cell.lImg.image = [UIImage imageNamed:@"fangdajing"];
            cell.myLab.text = model.name;

        [cell.rImg removeFromSuperview];
        [cell.rbtn removeFromSuperview];
        
        cell.rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cell.rbtn.frame = CGRectMake(wScreenW - 50-10 , 10, 50, 20);
        [cell.rbtn setTitleColor:wGrayColor2 forState:UIControlStateNormal];
        cell.rbtn.layer.masksToBounds = YES;
        cell.rbtn.layer.cornerRadius = 8;
        cell.rbtn.layer.borderColor = wGrayColor2.CGColor;
        cell.rbtn.layer.borderWidth = 0.6;
        
        [cell.rbtn setTitle:model.type_name forState:UIControlStateNormal];
        cell.rbtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:cell.rbtn];
        
        }
        return cell;
}

-(void)shanchu:(UIButton *)myBtn
{
    [PlayVcEverLike clearVidByVid:myArr[myBtn.tag -1313]];
    myArr = [PlayVcEverLike getVids];
    [myTab reloadData];
}
#pragma mark==清楚所有
-(void)qingchujulu
{
    [PlayVcEverLike clearVids];
    myTab.tableFooterView.hidden = YES;
    myArr = [PlayVcEverLike getVids];
    myTab.tableFooterView.hidden=YES;
    [myTab reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYGongsisousuoViewController * wby = [WBYGongsisousuoViewController new];
    if (isSearch == YES)
    {
        DataModel * data = allArr[indexPath.row];
        wby.mySte = data.name;
        lishi = data.name;
        [self searchByKeyword:data.name];
    }
    else
    {
        wby.mySte = myArr[indexPath.row];
        lishi = myArr[indexPath.row];
        [self searchByKeyword:myArr[indexPath.row]];
    }
    [self.navigationController pushViewController:wby animated:NO];
    

    
}
#pragma mark==语音
-(void)changeOnclick
{
    if(_iflyRecognizerView == nil)
    {
        [self initRecognizer ];
    }
       _searchBar.text = @"";
    //设置音频来源为麦克风
    [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
    //设置听写结果格式为json
    [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
    [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    BOOL ret = [_iflyRecognizerView start];
    if (ret) {
        //        [_startRecBtn setEnabled:NO];
        //        [_audioStreamBtn setEnabled:NO];
        //        [_upWordListBtn setEnabled:NO];
        //        [_upContactBtn setEnabled:NO];
    }
}
/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    NSLog(@"%s",__func__);
    //单例模式，UI的实例
    if (_iflyRecognizerView == nil) {
        //UI显示剧中
        _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //设置听写模式
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
    }
    _iflyRecognizerView.delegate = self;
    
    if (_iflyRecognizerView != nil)
    {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            //设置语言
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
     }
    
}

/**
 有界面，听写结果回调
 resultArray：听写结果
 isLast：表示最后一次
 ****/
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic)
    {
        [result appendFormat:@"%@",key];
    }
    _searchBar.text = [NSString stringWithFormat:@"%@%@",_searchBar.text,result];
    [self searchByKeyword:_searchBar.text];
    NSLog(@"====%@",result);
}
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
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
