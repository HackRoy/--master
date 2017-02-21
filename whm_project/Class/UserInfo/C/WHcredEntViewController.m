//
//  WHcredEntViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHcredEntViewController.h"
#import "WHcredEntView.h"
#import "JGProgressHelper.h"
#import "WHcompanyTableViewController.h"
#import "WHorgselectTableViewController.h"
#import "ZhiFuViewController.h"
#import "MyRenZhengTableViewCell.h"
#import "WLeiXingViewController.h"

#import "WBYHQGSviewController.h"

@interface WHcredEntViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView * myTab;
    NSArray * imgArr;
    NSArray * tiArr;
    NSString * shuzi;
}
@property(nonatomic,strong) WHcredEntView * CE;

@end

@implementation WHcredEntViewController

-(void)creatmyui
{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 220)];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50,50, wScreenW - 100, 35);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:wWhiteColor forState:UIControlStateNormal];
    [btn setBackgroundColor:wBlue];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    [btn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0,0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.tableFooterView = view;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [myTab registerClass:[MyRenZhengTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
    if ([_staues isEqualToString:@"0"])
    {
        myTab.tableFooterView.hidden = NO;
    }else
    {
        myTab.tableFooterView.hidden = YES;
    }
  }

-(void)change
{
//     [self.navigationController pushViewController:[ZhiFuViewController new] animated:YES];
    [self myRequestData];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return imgArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyRenZhengTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lImg.image = [UIImage imageNamed:imgArr[indexPath.row]];
    cell.mText.delegate = self;
    cell.mText.placeholder = tiArr[indexPath.row];
    cell.mText.tag = 1313 + indexPath.row;
    cell.mText.font = [UIFont systemFontOfSize:12];
       //未认证
    if ([self.staues isEqualToString:@"0"])
    {
         cell.mText.enabled = YES;
        
        if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.mText.enabled = NO;
            
        }else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else
    {
         cell.mText.enabled = NO;
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_staues isEqualToString:@"0"])
    {
        UITextField * text2 = [self.view viewWithTag:1313 + 2];
        UITextField * text3 = [self.view viewWithTag:1313 + 3];
        UITextField * text4 = [self.view viewWithTag:1313 + 4];
        if (indexPath.row == 2)
        {
            WLeiXingViewController * leixing = [WLeiXingViewController new];
            leixing.allBlock = ^(NSString * str ,NSString * shu)
            {
                text2.text = str;
                _company_type = shu;

            };
            
            text3.placeholder = @"";
            text4.placeholder = @"";
            text3.text = @"";
            text4.text = @"";
            

            [self.navigationController pushViewController:leixing animated:YES];
        }
        
        if (indexPath.row == 3)
        {
            if (text2.text.length > 3)
            {
                WBYHQGSviewController * company = [[WBYHQGSviewController alloc]init];
                company. mblock1 = ^(NSString * s1 ,NSString * s2)
                {
                    text3.text = s2 ;
                    self.comid = s1 ;
                };
                text4.text = @"";
                text4.placeholder = @"";

                company.myStr = _company_type;
                
                [self.navigationController pushViewController:company animated:YES];
            }
        }
        if (indexPath.row == 4)
        {
            if (text3.text.length > 3)
            {
                WHorgselectTableViewController * orgin = [[WHorgselectTableViewController alloc] init];
                
                orgin.com_id = self.comid;
                orgin. mblock2 = ^(NSString * s1 ,NSString * s2 ,NSString * s3 )
                {
                    text4.text = s2 ;
                    self.CE.beneText.text = s3 ;
                    self.orgId = s1 ;
                };
                [self.navigationController pushViewController:orgin  animated:YES];
            }
            else
            {
                [WBYRequest showMessage:@"请选择保险公司"];
            }
        }
      }
    
    
    }

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"认证信息";
  
    imgArr = @[@"Hm_name.png",@"Hm_card.png",@"leixing",@"Hm_peop",@"Hm_org",@"Hm_address",@"Hm_pefer",@"Wh_like"];
    
    _company_type = _orgId;
//    请选择类型 请选择保险公司 请选择分支机构
    tiArr = @[_xingming.length>2?_xingming:@"",_shenfenzhenghao.length > 10?_shenfenzhenghao:@"",_company_type_name.length>2?_company_type_name:@"请选择类型",_company.length >2?_company:@"请选择保险公司",_org_name.length>2?_org_name:@"请选择分支机构",_gsdz.length>1?_gsdz:@"",_zhiwu.length>1?_zhiwu:@"",_shanchang.length>1?_shanchang:@""];
    
    [self creatmyui];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    return YES;
}

-(void)myRequestData
{
    for (NSInteger i = 0; i < 8; i++)
    {
        UITextField * tf = [self.view viewWithTag:1313 + i];
        if (tf.text.length <= 2)
        {
            tf.text = tf.placeholder;
        }
    }
    UITextField * tf = [myTab viewWithTag: 1313];
    UITextField * tf1 = [myTab viewWithTag: 1313 + 1];
    UITextField * tf5 = [myTab viewWithTag: 1313 + 5];
    UITextField * tf6 = [myTab viewWithTag: 1313 + 6];
    UITextField * tf7 = [myTab viewWithTag: 1313 + 7];

    if ([_company_type intValue] >= 1)
    {
        if (self.comid)
        {
            if (self.orgId)
            {
                if ([WBYRequest isPersonIDCardNumber:tf1.text])
                {
                    if (tf.text.length < 1)
                    {
                        [WBYRequest showMessage:@"姓名不能为空"];
                    }else
                    {
                        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                        [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
                        [dic setObject:self.comid forKey:@"company"];
                        [dic setObject:tf.text forKey:@"name"];
                        [dic setObject:tf1.text forKey:@"cardnumber"];
                        [dic setObject:self.orgId forKey:@"organizationnumber"];
                        [dic setObject:tf7.text forKey:@"point"];
                        [dic setObject:tf5.text forKey:@"address"];
                        [dic setObject:tf6.text forKey:@"job"];
                        [dic setObject:[WBYRequest jiami:@"kbj/save_verify"] forKey:@"kb"];
                        [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
                        __weak WHcredEntViewController * myself = self;
                        [WBYRequest wbyPostRequestDataUrl:@"kbj/save_verify" addParameters:dic success:^(WBYReqModel *model)
                         {
                             if ([model.err isEqualToString:TURE])
                             {
                                 ZhiFuViewController * myZhifu =          [ZhiFuViewController new];
                                 
                                 myZhifu.myDataModel = model.data[0];
                                 [myself.navigationController pushViewController:myZhifu animated:YES];
                             }else
                             {
                                 [WBYRequest showMessage:model.info];
                             }
                         }
                        failure:^(NSError *error)
                         {
                         } isRefresh:YES];
                    }
                }else
                {
                    [WBYRequest showMessage:@"身份证号不正确"];
                }
              }else
            {
                [WBYRequest showMessage:@"请选择分支机构"];
            }
          }else
        {
            [WBYRequest showMessage:@"请选择保险公司"];
        }
    }else
    {
        [WBYRequest showMessage:@"请选择类型"];
    }
    
}




/*-(void)loadView
{
    self.CE = [[WHcredEntView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _CE;
    self.CE.ProNumText.delegate = self;
    self.CE.comNameText.delegate = self;
    self.CE.likeText.delegate = self;
    self.CE.dateText.delegate = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    //Hm_name  Hm_card Hm_peop p_arrowleft Hm_org p_arrowleft Hm_address Hm_pefer  Wh_like
    imgArr = @[@"Hm_name",@"Hm_card",@"Hm_peop",@"Hm_org",@"Hm_address",@"Hm_pefer",@"Wh_like"];
    
   tiArr = @[_xingming,_shenfenzhenghao,@"",@"",_gsdz,_zhiwu,_shanchang];
    
    
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.CE.cleckImg1.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1 ;
    [self.CE.cleckImg1 addGestureRecognizer:tapGesture];
    //self.CE.peopText.enabled = false;
    //self.CE.nameText.enabled = false;
    UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.CE.cleckImg.userInteractionEnabled = YES;
    tapGesture1.numberOfTapsRequired = 1;
    tapGesture1.numberOfTouchesRequired = 1 ;
    [self.CE.cleckImg addGestureRecognizer:tapGesture1];
    
    [self.CE.nextBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

//    [self.CE resignFirstResponder];
    //[self.view endEditing:YES];
    
}
-(void)nextButAction:(UIButton *)sender
{
      [self.navigationController pushViewController:[ZhiFuViewController new] animated:YES];
    
    
    if (self.CE.ProNumText.text != nil) {
        if (self.CE.comNameText.text != nil) {
            if ([WBYRequest isPersonIDCardNumber:self.CE.comNameText.text ] == YES) {
                
            if (self.orgId != nil) {
            
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService save_verifyWithUid:@""
                                 company:self.comid
                                    name:self.CE.ProNumText.text
                              cardnumber:self.CE.comNameText.text
                      organizationnumber:self.orgId
                                   point:self.CE.likeText.text
                                 address:self.CE.beneText.text
                                     job:self.CE.dateText.text
                                 success:^{
                                     [hud hide:YES];
                                     [JGProgressHelper showSuccess:@"保存成功"];
                                     
                                 } failure:^(NSError *error) {
                                     [hud hide:YES];
                                     [JGProgressHelper showError:@"失败"];
                                     
                                 }];
            }
            else
            {
                [JGProgressHelper showError:@"请选择分支机构"];
            }
    }
        
        else
        {
            [JGProgressHelper showError:@"你输入的身份证号格式有误,请核实"];
        }
        }
    else
    {
        [JGProgressHelper showError:@"请输入你的身份证号"];
    }
    }
    
    else
    {
        [JGProgressHelper showError:@"请输入你的真实姓名"];
    }
}

-(void)onClickUILable1:(UITapGestureRecognizer *)sender
{
    if (self.comid  != nil) {
    
    WHorgselectTableViewController * orgin = [[WHorgselectTableViewController alloc]init];
    orgin.com_id = self.comid;
    orgin. mblock2 = ^(NSString * s1 ,NSString * s2 ,NSString * s3 )
    {
        self.CE.nameText.text = s2 ;
        self.CE.beneText.text = s3 ;
        self.orgId = s1 ;
        
    };

    [self.navigationController pushViewController:orgin  animated:YES];
    }
    else
    {
        [JGProgressHelper showError:@"请先选择保险公司"];
    }
}
-(void)onClickUILable:(UITapGestureRecognizer *)sender
{
    WHcompanyTableViewController * company = [[WHcompanyTableViewController alloc]init];
    company. mblock1 = ^(NSString * s1 ,NSString * s2)
    {
        self.CE.peopText.text = s2 ;
        self.comid = s1 ;
        
    };
    
    [self.navigationController pushViewController:company animated:YES];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self.CE.ProNumText resignFirstResponder];
    [self.CE.comNameText resignFirstResponder];
    [self.CE.likeText resignFirstResponder];
    [self.CE.dateText resignFirstResponder];


}
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if ([textField isEqual:self.CE.peopText]) {
////        [self.CE.peopText resignFirstResponder];
//        //self
//        WHcompanyTableViewController * company = [[WHcompanyTableViewController alloc]init];
//        company. mblock1 = ^(NSString * s1 ,NSString * s2)
//        {
//            self.CE.peopText.text = s2 ;
//            self.comid = s1 ;
//            
//        };
//        
//        [self.navigationController pushViewController:company animated:YES];
//        [self.view endEditing:YES];
//
//    }
//}
*/
    
    
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
