//
//  JwLookForController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwLookForController.h"
#import "UIColor+Hex.h"
#import "WHgetprofirst.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHpelicyTableViewController.h"
#import "WHpayTableViewController.h"
#import "WHhistoryTableViewController.h"
#import <UIImageView+WebCache.h>
#import "WHpowSearTableViewController.h"

#import "JwRela.h"
#import "JwUserCenter.h"
#import "JwLoginController.h"
//出生日期选择
#import "ASBirthSelectSheet.h"
#import "WHKNetWorkUtils.h"


#import "iflyMSC/iflyMSC.h"
#import "IATConfig.h"
#import "GSMacros.h"
#import "GSFilterView.h"
#import "SouSuoViewController.h"
#import "WBYGongsisousuoViewController.h"


@interface JwLookForController ()<UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UISearchBarDelegate,IFlyRecognizerViewDelegate,DKFilterViewDelegate>
{
    UIActionSheet *sheet;
    UILabel * alab;
}
//searchBar
@property (nonatomic, strong) UISearchBar * searchBar;

@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//带界面的识别对象
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;//录音器，用于音频流识别的数据传入
@property (nonatomic,strong) GSFilterView *filterView;
@property(nonatomic,strong)NSArray * remenArray;

@property(nonatomic,strong)NSMutableArray * idArr;


// 最大的UIScrollview
@property (nonatomic, strong) UIScrollView *bigScrollV;
// 搜索View
@property (nonatomic, strong) UIView *searchView;
// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;
@property (nonatomic, strong) CALayer *segmentLineLayer;
// 横向的UIScrollview
@property (nonatomic, strong) UIScrollView *horScrollV;
// 纵向的UIScrollview2 --- 筛选条件
@property (nonatomic, strong) UIScrollView *conditionScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *essentialScrollV;

@property(nonatomic,strong)NSMutableArray * dataArry;

@property(nonatomic,strong)UIImageView * image;
//@property(nonatomic,strong)UITextField * searText;
@property(nonatomic,strong)UIImageView * searImg;
@property(nonatomic,strong)UIButton * shaiBut;
@property(nonatomic,strong)UIButton * baseBut;
@property(nonatomic,strong)UIView * myview;
//
@property(nonatomic,strong)UILabel * myLaber1;
@property(nonatomic,strong)UITextField * myText1;
@property(nonatomic,strong)UITextField * myText2;
@property(nonatomic,strong)UILabel * myText3;
@property(nonatomic,strong)UILabel * myText4;
@property(nonatomic,strong)UIButton * serchBut;
//基本信息
@property(nonatomic,strong)UIImageView * basImg;
@property(nonatomic,strong)UILabel * basText1;
@property(nonatomic,strong)UILabel * basText2;
@property(nonatomic,strong)UILabel * basText3;
@property(nonatomic,strong)UILabel * basText4;

@property(nonatomic,strong)NSString * blockMyText3;
@property(nonatomic,strong)NSString * blockMyText4;



@end

@implementation JwLookForController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
 
//    self.navigationItem.titleView.hidden = YES;
    
_searchBar.text = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self wbyUpTextApp];
    
    _remenArray = [NSArray array];
    _idArr = [NSMutableArray array];
    [self creatRequest];
    [self creatUI];
}



-(void)wbyUpTextApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil)
    {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //设置版本号
    currentVersion = [currentVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (currentVersion.length==2) {
        currentVersion  = [currentVersion stringByAppendingString:@"0"];
    }else if (currentVersion.length==1){
        currentVersion  = [currentVersion stringByAppendingString:@"00"];
    }
    
    appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    if (appStoreVersion.length==2) {
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"0"];
    }else if (appStoreVersion.length==1){
        appStoreVersion  = [appStoreVersion stringByAppendingString:@"00"];
    }
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertController *alercConteoller = [UIAlertController alertControllerWithTitle:@"有新版本出现" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",dic[@"version"]] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //此处加入应用在app store的地址，方便用户去更新，一种实现方式如下
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
            [[UIApplication sharedApplication] openURL:url];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alercConteoller addAction:actionYes];
        [alercConteoller addAction:actionNo];
        
        [self presentViewController:alercConteoller animated:YES completion:nil];
        
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}
#pragma mark===修改
-(void)creatUI
{
    
    UIImageView * myImg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW/4,100, 200, 77)];
    myImg.center = CGPointMake(self.view.center.x,80);
    myImg.image = [UIImage imageNamed:@"kuaibaoLog"];
    [self.view addSubview:myImg];
    
       self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(30, CGRectGetMaxY(myImg.frame) + 40,wScreenW - 60, 35)];
       _searchBar.backgroundImage = [[UIImage imageNamed:@"1-3-长条首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _searchBar.keyboardType = UIKeyboardAppearanceDefault;
        _searchBar.placeholder = @"请输入搜索内容";
    
        _searchBar.delegate = self;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.barStyle = UIBarStyleDefault;
       _searchBar.layer.borderColor=[UIColor colorWithRed:195.0/255 green:196.0/255 blue:197.0/255 alpha:1.0].CGColor;
       _searchBar.layer.borderWidth=0.6;
        [self.view addSubview:_searchBar];
    
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame) - 30 - 2, CGRectGetMaxY(myImg.frame) + 40 + 5, 25, 25);
    [myBtn setImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
    [myBtn addTarget:self action:@selector(onClickMyBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:myBtn];
    
    alab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(_searchBar.frame) , wScreenW - 60, 35)];
    alab.text = @"热门搜索";
    alab.font = [UIFont systemFontOfSize:10.0f];
    alab.textColor = wGrayColor;
    [self.view addSubview:alab];
    
    UILabel * downlab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(alab.frame), wScreenW - 60, 0.6)];
    downlab.backgroundColor = wGrayColor;
    [self.view addSubview:downlab];
   
    
}

#pragma mark===点击热门搜索

- (void)didClickAtModel:(DKFilterModel *)data
{
    WBYGongsisousuoViewController * wby = [WBYGongsisousuoViewController new];
    wby.mySte = _remenArray[data.tag-110];
    
    wby.mgId = _idArr[data.tag - 110];
    
   [self.navigationController pushViewController:wby animated:NO];
    
}

-(void)onClickMyBtn
{
    [_searchBar resignFirstResponder];
    
    
    
//    [self.navigationController pushViewController:[SouSuoViewController new] animated:YES];
    [self changeOnclick];
}

-(void)changeOnclick
{
    if(_iflyRecognizerView == nil)
    {
        [self initRecognizer ];
    }
    
    //[_textView setText:@""];
    // [_textView resignFirstResponder];
    
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
     SouSuoViewController * sousuo =  [SouSuoViewController new];
    
    if (_searchBar.text.length > 1)
    {
        sousuo.str = _searchBar.text;
     }
     [self.navigationController pushViewController:sousuo animated:NO];
    
    
    NSLog(@"====%@",result);
}


- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"===%@",error);
    
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar == _searchBar)
    {
       [self.navigationController pushViewController:[SouSuoViewController new] animated:YES];
        
        return NO;
    }
    return YES;
}


-(void)creatRequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"hot"];
    [dic setObject:[WBYRequest jiami:@"kb/get_keyword"] forKey:@"kb"];
    NSMutableArray * arr = [NSMutableArray array];
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_keyword" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            for (DataModel * mod in model.data)
            {
                [arr addObject:mod.name?mod.name:@""];
                [_idArr addObject:mod.mongo_id?mod.mongo_id:@""];
            }
            _remenArray = [NSArray arrayWithArray:arr];
//            _idArr = [NSArray arrayWithArray:<#(nonnull NSArray *)#>];
            
            
        }
        
        DKFilterModel * checkModel = [[DKFilterModel alloc] initElement:_remenArray ofType:DK_SELECTION_SINGLE];
        checkModel.style = DKFilterViewStyle1;

        
        self.filterView = [[GSFilterView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(alab.frame),wScreenW-30, 200)];
        
        self.filterView.delegate = self;
       
        
        [self.filterView setFilterModels:@[checkModel]];
        
        [self.view addSubview:self.filterView];
        [self.filterView.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    } isRefresh:NO];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
