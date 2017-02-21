//
//  WHinviteViewController.m
//  whm_project
//
//  Created by 王义国 on 17/1/19.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHinviteViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "UMSocial.h"
#define BASE_REST_URL @"https://www.kuaibao365.com/share/reg/"
#import "JwUserCenter.h"
@interface WHinviteViewController ()<UMSocialUIDelegate,UIWebViewDelegate>
@property(nonatomic,strong)UIImageView * headImg;
@property(nonatomic,strong)UIButton * myButton;
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)NSString * url;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)UIImageView * myImg;
//
@property(nonatomic,strong)UIWebView * scw ;


//@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation WHinviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTepUi];
    
    self.navigationItem.title = @"邀请";
}

-(void)setTepUi
{
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"立即分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(right:)];

    self.scw = [[UIWebView alloc]init];
    self.scw.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight * 0.9);
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"index11.html" withExtension:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.scw loadRequest:request];
    [self.view addSubview:_scw];
    
   //
    self.myButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myButton.frame = CGRectMake(kScreenWitdh*0.15, kScreenHeight* 0.38, kScreenWitdh * 0.7, 46);
    self.myButton.backgroundColor = [UIColor clearColor];
    [self.scw addSubview:_myButton];
    [self.myButton addTarget:self action:@selector(myButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];


}



-(void)right:(UIBarButtonItem *)sender
{
   
    
    
    self.url = [NSString stringWithFormat:@"%@", BASE_REST_URL];
    [UMSocialData defaultData].extConfig.title = @"快保家—保险代理人品牌营销必备神器，快速获客，轻松赚钱。";
    
    
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    //
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"快保家", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"快保家"]
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToTencent]
                                       delegate:self];

}

-(void)myButtonAction:(UIButton *)sender
{
   
    self.url = [NSString stringWithFormat:@"%@%@", BASE_REST_URL,[JwUserCenter sharedCenter].uid];
    [UMSocialData defaultData].extConfig.title = @"快保家—保险代理人品牌营销必备神器，快速获客，轻松赚钱。";
    
    
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    //
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"快保家", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"快保家"]
                                     shareImage:[UIImage imageNamed:@"logo"]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToTencent]
                                       delegate:self];

    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
