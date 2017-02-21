//
//  WBYKFPViewController.m
//  whm_project
//
//  Created by apple on 17/1/19.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYKFPViewController.h"
#import "WBYQFPTableViewCell.h"
#import "WBYfpjcViewController.h"


@interface WBYKFPViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
{
    UITableView * myTab;
    NSString * bian;
    
    UIView * bgView;
}
@end

@implementation WBYKFPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"开发票";
    bian = @"dianzi";
    [self creatLeftTtem];
    [self creatUi];
}
-(void)creatUi
{
    UIView * View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:[NSString stringWithFormat:@"确认提交"] forState:UIControlStateNormal];
    zhifu.frame = CGRectMake(30, 30, wScreenW - 60, 35);
    [zhifu setTitleColor:wWhiteColor forState:UIControlStateNormal];
    zhifu.backgroundColor = wBlue;
    zhifu.layer.masksToBounds = YES;
    zhifu.layer.cornerRadius = 17.5;
    [zhifu addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    
    [View addSubview:zhifu];
    
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    
    myTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTab.tableFooterView = View;
    [myTab registerClass:[WBYQFPTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:myTab];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0)
//    {
//        return 1;
//    }else
//    {
//        return 1;
//    }
    
    return 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYQFPTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
//    cell.myLab.tag = 585858 + indexPath.row;
    
    
    if (indexPath.row == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.myLab.enabled = NO;
        cell.myImg.image = [UIImage imageNamed:@"fapiao1"];
                if ([bian isEqualToString:@"dianzi"])
        {
           cell.myLab.text = @"电子发票";
        }else
        {
           cell.myLab.text = @"纸质发票";
        }
    }
    else
    {
        
        cell.myLab.tag = 56789;
        
        if ([bian isEqualToString:@"dianzi"])
        {
            cell.myLab.placeholder = @"请输入你要发送电子发票的邮箱";
            cell.myImg.image = [UIImage imageNamed:@"fapiao2"];
            
        }else
        {
            cell.myImg.image = [UIImage imageNamed:@"fapiao3"];
            cell.myLab.placeholder = @"请输入你要邮寄纸质发票的地址";
        }
    }
            
       return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"请选择发票类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"电子发票",@"纸质发票", nil];
        [sheet showInView:[[UIApplication sharedApplication].delegate window]];
    }
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        bian = @"dianzi";
    }else
    {
       bian = @"zhizhi";
        
    }
    
    [myTab reloadData];
    
}

-(void)tijiao
{
    [self.view endEditing:YES];
    UITextField * tf = [myTab viewWithTag:56789];
    
    if (tf.text.length < 2)
    {
        
        [WBYRequest showMessage:@"请填写邮箱或地址"];
    }else
    {
        if ([bian isEqualToString:@"dianzi"])
        {
            if ([WBYRequest isEmailAddress:tf.text])
            {
                [self viewtijiao];
            }else
            {
                [WBYRequest showMessage:@"请查看邮箱格式"];
            }
        }else
        {
            [self viewtijiao];
        }
        
    }
}


-(void)viewtijiao
{
    
     bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH)];
    [[[UIApplication sharedApplication].delegate window] addSubview:bgView];
    
    UIView*myView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,135)];
    myView.backgroundColor=[UIColor blackColor];
    myView.alpha=0.6;
    [bgView addSubview:myView];
    
    UIView * midView = [[UIView alloc] initWithFrame:CGRectMake(20, 135, wScreenW - 40, 155)];
    midView.backgroundColor = wWhiteColor;
    [bgView addSubview:midView];
   
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wScreenW - 40, 30)];
    lab.text = @"确认信息";
    lab.textAlignment = 1;
    [midView addSubview: lab];
    
    UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab.frame), wScreenW-40, 0.5)];
    lab1.backgroundColor = wGrayColor;
    [midView addSubview:lab1];
    
    UILabel * xmlab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lab1.frame), 50, 25)];
    xmlab.textColor = wGrayColor;
    xmlab.font = [UIFont systemFontOfSize:14];
    xmlab.textAlignment = 1;
    xmlab.text = @"姓名:";
    [midView addSubview:xmlab];
    
    UILabel * rxmLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(xmlab.frame)+3, CGRectGetMaxY(lab1.frame), 80, 25)];
    rxmLab.font = [UIFont systemFontOfSize:14];
    rxmLab.text = XINGMING;

    [midView addSubview:rxmLab];
    
    UILabel * dzLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xmlab.frame), 50, 60)];
    dzLab.font = [UIFont systemFontOfSize:14];
    dzLab.textColor = wGrayColor;

    if ([bian isEqualToString:@"dianzi"])
    {
        dzLab.text = @"邮箱:";
    }
    else
    {
        dzLab.text = @"地址:";
    }
    
    dzLab.textAlignment = 1;
    
    [midView addSubview:dzLab];
    

    UITextField * tf = [[[UIApplication sharedApplication].delegate window] viewWithTag:56789];
    
    UILabel * rLabDz=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dzLab.frame)+3, CGRectGetMaxY(xmlab.frame), wScreenW-40-50-30, 60)];
    rLabDz.numberOfLines = 0;
    rLabDz.font = [UIFont systemFontOfSize:14];
    rLabDz.text = tf.text;
    
    [midView addSubview:rLabDz];
   
    UILabel * xia = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(rLabDz.frame)+10, wScreenW-40, 0.5)];
    xia.backgroundColor = wGrayColor;
    
    [midView addSubview:xia];
    
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:[NSString stringWithFormat:@"否"] forState:UIControlStateNormal];
    
    [zhifu setTitleColor:wBlue forState:UIControlStateNormal];
    zhifu.frame = CGRectMake(0, CGRectGetMaxY(xia.frame), (wScreenW - 40)/2,30);
    
    [zhifu addTarget:self action:@selector(fou) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:zhifu];

    UILabel * shuLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(zhifu.frame), CGRectGetMaxY(xia.frame), 1, 30)];
    shuLab.backgroundColor =wGrayColor;
    
    [midView addSubview:shuLab];
    
    
    UIButton * shi = [UIButton buttonWithType:UIButtonTypeCustom];
    [shi setTitle:[NSString stringWithFormat:@"是"] forState:UIControlStateNormal];
    [shi setTitleColor:wBlue forState:UIControlStateNormal];
    shi.frame = CGRectMake(CGRectGetMaxX(shuLab.frame), CGRectGetMaxY(xia.frame), (wScreenW - 40)/2,30);
    [shi addTarget:self action:@selector(shi) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:shi];
    
    
    UIView*myView1=[[UIView alloc] initWithFrame:CGRectMake(0,290, wScreenW, wScreenH - 290)];
    myView1.backgroundColor=[UIColor blackColor];
    myView1.alpha=0.6;
    [bgView addSubview:myView1];
    
    UIView * rview= [[UIView alloc] initWithFrame:CGRectMake(0, 135, 20, 155)];
    rview.backgroundColor = [UIColor blackColor];
    rview.alpha =0.6;
    [bgView addSubview:rview];
    
    
    UIView * lview= [[UIView alloc] initWithFrame:CGRectMake(wScreenW-20, 135, 20, 155)];
    lview.backgroundColor = [UIColor blackColor];
    lview.alpha =0.6;
    [bgView addSubview:lview];
    
    
}

-(void)fou
{
    
    [bgView removeFromSuperview];
}

-(void)shi
{
    [bgView removeFromSuperview];

    [self requestData];
    
}


-(void)requestData
{
    
    
    UITextField * tf=[myTab viewWithTag:56789];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kbj/save_bill"] forKey:@"kb"];
    [dic setObject:tf.text forKey:@"address"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];

    if ([bian isEqualToString:@"dianzi"])
    {
        [dic setObject:@"0" forKey:@"type"];
    }else
    {
        [dic setObject:@"1" forKey:@"type"];
    }
    
    __weak WBYKFPViewController * mysel = self;
    [WBYRequest wbyPostRequestDataUrl:@"kbj/save_bill" addParameters:dic success:^(WBYReqModel *model)
    {
        if ([model.err isEqualToString:TURE])
        {
            WBYfpjcViewController * view = [WBYfpjcViewController new];
            view.zhuangtai = bian;
            view.dizhi = tf.text;
            
            [mysel.navigationController pushViewController:view animated:YES];
        }
        
        
        
    } failure:^(NSError *error) {
        
    } isRefresh:NO];
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
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
