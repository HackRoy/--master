//
//  WHreplymessageViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHreplymessageViewController.h"
#import "WHgetmessageDetall.h"
#import "WHreplymessage.h"
#import "JGProgressHelper.h"




#import "MacroUtility.h"


@interface WHreplymessageViewController ()

@property(nonatomic,strong)WHreplymessage * rep;

@property(nonatomic,strong)NSMutableArray * dataArry;

//回复
@property(nonatomic,strong)NSString * StrID;
@property(nonatomic,strong)NSString * req_uid;
@property(nonatomic,strong)NSString * res_uid;
@property(nonatomic,strong)NSString * message_id;
@property(nonatomic,strong)NSString * city_name;
@property(nonatomic,strong)NSString * req_name;

@end

@implementation WHreplymessageViewController

-(void)loadView
{
    self.rep = [[WHreplymessage alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =_rep;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //请求数据
    [self requestData];
    
}
// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getmessagedetailWithId:self.IDS uid:@"" success:^(NSArray *getdetals) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:getdetals];
        NSLog(@"%@",self.dataArry);

        for (WHgetmessageDetall * model in self.dataArry) {
            NSLog(@"%@",model);
            self.rep.titLaber.text = model.message;
            self.rep.nameLaber.text = model.req_name;
            NSString * s1 = @"来自 ";
            self.rep.addressLaber.text = [s1 stringByAppendingString:model.city_name];
            //时间戳处理
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
            NSString * s2 = [NSString stringWithFormat:@"%@",confromTimesp];
            NSString * s3 = [s2 stringByAppendingString: model.create_time];
            self.rep.timeLaber.text = [s3 substringToIndex:11];
            
            //
            for (WHgetmessageDetall * reModel in model.reply) {
                self.rep.repDetText.text = reModel.message;
                NSLog(@"%@",reModel.message);
                
                self.StrID = reModel.id;
                NSLog(@"%@",self.StrID);
                self.req_uid = reModel.req_uid;
                self.res_uid = reModel.res_uid;
                self.city_name = reModel.city_name;
                self.req_name = reModel.req_name;
                self.message_id = reModel.message_id;
            }
         
        }
       
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的留言";
    [self.rep.delBut addTarget:self action:@selector(delButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.rep.repBut addTarget:self action:@selector(repButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//删除留言回复
-(void)delButAction:(UIButton * )sender
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.userService delmessageWithId:self.StrID uid:@"" success:^{
        [hud hide:YES];
        [JGProgressHelper showSuccess:@"删除留言回复成功"];
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"删除回复失败"];
        
    }];
    
    
}

//立即回复成功
-(void)repButAction:(UIButton *)sender
{
    if (self.rep.myTextView.text != 0) {
        
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService savemessageWithReq_uid:self.req_uid
                                     res_uid:self.res_uid
                                         uid:@""
                                     message:self.rep.myTextView.text
                                  message_id:self.message_id
                                   city_name:self.city_name
                                    req_name:self.req_name
                                     success:^{
                     
                                         [hud hide:YES];
                                         [JGProgressHelper showSuccess:@"回复成功"];
                                         
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"回复失败"];

        
    }];
    }else
    {
        [JGProgressHelper showError:@"请填写内容"];
    }

    
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
