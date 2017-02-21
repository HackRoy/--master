//
//  WHintroViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHintroViewController.h"
#import "WHcompanyDetail.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"


@interface WHintroViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * scw;
@property(nonatomic,strong)NSString * s1 ;



@end

@implementation WHintroViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self requData];
    
    
}

-(void)requData
{
     id hud = [JGProgressHelper showProgressInView:self.view];
     [self.dataService get_company_detailWithCom_id:self.company_id uid:@"" success:^(NSArray *list) {
         [hud hide:YES];
         for (WHcompanyDetail * model in list) {
             self.s1 = model.descriptionJw;
            // NSLog(@"pppppppp%@",self.s1);
             
              [self loadWithURLString:self.s1];
         }
      
     } failure:^(NSError *error) {
         [hud hide:YES];
         [JGProgressHelper showError:@""];
         
     }];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor grayColor];
    self.scw.delegate = self;
    
    self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0 ,kScreenWitdh, kScreenHeight*0.65 -64 )];
   
    [self.view addSubview:_scw];

    
}

-(void)loadWithURLString:(NSString *)urlStr
{
    NSString  * content = [self.s1 stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",kScreenWitdh-16,kScreenWitdh-16,kScreenWitdh-16];
    //
    
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    //self.scw = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"00%@",contentTwo);
    
    [_scw loadHTMLString:html baseURL:nil];
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
