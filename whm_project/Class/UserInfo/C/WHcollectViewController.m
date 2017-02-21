//
//  WHcollectViewController.m
//  whm_project
//
//  Created by 王义国 on 17/2/4.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHcollectViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHcoverCollectTableViewCell.h"
#import "WHcompanyCollectTableViewCell.h"
#import "WHnewscollectTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHcompany.h"
#import "WHnews.h"
#import "WHproductList.h"


@interface WHcollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIButton * myCompany;
@property(nonatomic,strong)UIButton * myNews;
@property(nonatomic,strong)UIButton * myCover;
@property(nonatomic,strong)UITableView * TableCompany;
//
@property(nonatomic,strong)UITableView * TableNews;
@property(nonatomic,strong)UITableView * TableCover;

//
@property(nonatomic,strong)NSMutableArray * companyArry;
@property(nonatomic,strong)NSMutableArray * newsArry;
@property(nonatomic,strong)NSMutableArray * coverArry;

//
@property(nonatomic,strong)NSString * newsId;
@property(nonatomic,strong)NSString * companyId;
@property(nonatomic,strong)NSString * coverId;





@end

@implementation WHcollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setTup];
    
    self.title = @"我的收藏";
    

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self quretDate];
}

-(void)setTup
{
    self.myCompany = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myCompany.frame = CGRectMake(20, 0, 40, 30);
    [self.myCompany setTitle:@"公司" forState:(UIControlStateNormal)];
    [self.view addSubview:_myCompany];
    [self.myCompany addTarget:self action:@selector(myCompanyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.myNews = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myNews.frame = CGRectMake(kScreenWitdh * 0.4, 0, CGRectGetWidth(self.myCompany.frame), CGRectGetHeight(self.myCompany.frame));
    [self.myNews setTitle:@"咨询" forState:(UIControlStateNormal)];
    [self.view addSubview:_myNews];
    [self.myNews addTarget:self action:@selector(myNewsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.myCover = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myCover.frame = CGRectMake(kScreenWitdh-CGRectGetWidth(self.myCompany.frame)-20, 0, CGRectGetWidth(self.myCompany.frame), CGRectGetHeight(self.myCompany.frame));
    [self.myCover setTitle:@"险种" forState:(UIControlStateNormal)];
    [self.view addSubview:_myCover];
    [self.myCover addTarget:self action:@selector(myCoverAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

-(void)quretDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getcompanyWithUid:@""
                                   type:@"company"
                                success:^(NSArray *lists) {
                                    [hud hide:YES];
                                    
                                    [self.companyArry addObjectsFromArray:lists];
                                    [self.TableCompany reloadData];
                                    
                                } failure:^(NSError *error) {
                                    [hud hide:YES];
                                    [JGProgressHelper showError:@"你还没有收藏任何公司"];
                                    
                                }];

    
        [self.dataService getnewsWithUid:@""
                                type:@"news"
                             success:^(NSArray *lists) {
                                 [hud hide:YES];
                                 
                                 self.newsArry = [NSMutableArray arrayWithArray:lists];
                                 NSLog(@"====%@",self.newsArry);
                                 
                                 [self.TableNews reloadData];
                                 
                             } failure:^(NSError *error) {
                                 [hud hide:YES];
                                 [JGProgressHelper showError:@"你还没有收藏任何咨询内容"];
                                 
                             }];
    
  
    [self.dataService getcollectWithUid:@""
                                   type:@"product"
                                success:^(NSArray *lists) {
                                    [hud hide:YES];
                                    self.coverArry = [NSMutableArray arrayWithArray:lists];
                                    [self.TableCover reloadData];
                                    
                                } failure:^(NSError *error) {
                                    [hud hide:YES];
                                    [JGProgressHelper showError:@"你还没有收藏任何险种"];
                                    
                                }];
    


    
}

//公司
-(void)myCompanyAction:(UIButton *)sender
{

    [self.TableCover removeFromSuperview];
    [self.TableNews removeFromSuperview];
    self.TableCompany.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.TableCompany = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWitdh, kScreenHeight -64 -40) style:(UITableViewStylePlain)];
    
    self.TableCompany.delegate = self;
    self.TableCompany.dataSource = self;
    [self.TableCompany registerClass:[WHcompanyCollectTableViewCell class] forCellReuseIdentifier:@"cellCompany"];
    self.TableCompany.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self.view addSubview:_TableCompany];
    
    

    
}
//咨询
-(void)myNewsAction:(UIButton *)sender
{
    [self.TableCompany removeFromSuperview];
    
    [self.TableCover removeFromSuperview];
      self.TableNews = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWitdh, kScreenHeight - 64 - 40) style:(UITableViewStylePlain)];
    self.TableNews.delegate = self;
    self.TableNews.dataSource = self;
    self.TableNews.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.TableNews registerClass:[WHnewscollectTableViewCell class] forCellReuseIdentifier:@"cellNews"];

    self.TableNews.backgroundColor =  [UIColor colorWithHex:0xF5F7F9];
    
    [self.view addSubview:_TableNews];


  
}
//险种
-(void)myCoverAction:(UIButton *)sender
{
    
    [self.TableCompany removeFromSuperview];
    [self.TableNews removeFromSuperview];
    
    self.TableCover= [[UITableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWitdh, kScreenHeight - 64 - 40) style:(UITableViewStylePlain)];
    self.TableCover.delegate = self;
    self.TableCover.dataSource = self;
    self.TableCover.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.TableCover registerClass:[WHcoverCollectTableViewCell class] forCellReuseIdentifier:@"cellCover"];
     self.TableCover.backgroundColor =  [UIColor colorWithHex:0xF5F7F9];
     [self.view addSubview:_TableCover];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (tableView == self.TableCompany) {
        return self.companyArry.count;
    }
    
    if (tableView == self.TableNews) {
        return self.newsArry.count;
     
    }
        return self.coverArry.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.TableCompany) {
        WHcompanyCollectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellCompany" forIndexPath:indexPath];
        WHcompany * model = self.companyArry[indexPath.row];
        [cell.myLogo sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell.myTitlaber.text = model.short_name;
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
        
        NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
        
        cell.timeLaber.text = [s1 substringToIndex:11];
        cell.contentView.backgroundColor = [UIColor redColor];
        return cell;
    }
    else if (tableView == self.TableNews)
    {
        WHnewscollectTableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"cellNews" forIndexPath:indexPath];
        WHnews * model = self.newsArry[indexPath.row];
        [cell.myImg sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
        cell.myTit.text = model.title;
        NSString * s2 = @"阅读";
        cell.readNum.text = [model.count stringByAppendingString:s2];
        NSString * s4 = @"类型:";
        
        if (model.soucre == nil) {
            model.soucre =@"行业新闻";
        }
        cell.styLaber.text = [s4 stringByAppendingString:model.soucre];
        NSString * s5 = model.created_time;
        cell.timeLaber.text = [s5 substringToIndex:11];
       

        return cell;
    }
    else
    {
        WHcoverCollectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellCover" forIndexPath:indexPath];
        
        WHproductList * model = self.coverArry[indexPath.row];
        [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        cell.titLaber.text = model.short_name;
        cell.ageTitle.text = model.limit_age;
        if ([model.ins_type isEqualToString:@"1"]) {
            cell.seyTitle.text = @"团体";

        }
        if ([model.ins_type isEqualToString:@"2"]) {
            cell.seyTitle.text = @"个人";
        }
        
        
        
        
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
        
        NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
        
        cell.timeLaber.text = [s1 substringToIndex:11];
        
       
        NSInteger stateM = [model.is_main integerValue];
        switch (stateM) {
            case 1:
                cell.myImg.image =[UIImage imageNamed:@"p_zhu"];
                break;
            case 2:
                cell.myImg.image = [UIImage imageNamed:@"p_huangfu"];
                break;
            case 3:
                cell.myImg.image = [UIImage imageNamed:@"p_group"];
                break;
                
            default:
                break;
        }
        
        return cell;

    }
   
}


//编辑删除事件
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//制定编辑的样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.TableCompany) {
        WHcompany * model = self.companyArry[indexPath.row];
        self.companyId = model.id;
        
    }
    if (tableView == self.TableNews) {
        WHnews * model = self.newsArry[indexPath.row];
        self.newsId = model.id;
    }
    
    else
    {
        WHproductList * model = self.coverArry[indexPath.row];
        self.coverId = model.id;
    }
    
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if (tableView == self.TableNews) {
        UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            WHnews * model = self.newsArry[indexPath.row];
            self.newsId = model.id;
            id hud = [JGProgressHelper showProgressInView:self.view];
            [self.userService delcollectWithUid:@"" type_id:self.newsId type:@"news" success:^{
                [hud hide:YES];
                [JGProgressHelper showSuccess:@"取消收藏成功"];
                [self.TableNews reloadData];
                
            } failure:^(NSError *error) {
                [hud hide:YES];
                [JGProgressHelper showError:@"取消收藏失败"];
            }];
            [self.newsArry removeObjectAtIndex:indexPath.row];
            
            NSArray * temp = [NSArray arrayWithObject:indexPath];
            //更新ui
            
            [tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
            [tableView setEditing:NO animated:YES];
            
            
        }];
        
        NSArray * arr = @[layTopRowAction1];
        return arr;

    }
    
    if (tableView == self.TableCompany) {
        UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            WHcompany * model = self.companyArry[indexPath.row];
            self.companyId = model.id;
            id hud = [JGProgressHelper showProgressInView:self.view];
            [self.userService delcollectWithUid:@"" type_id:self.companyId type:@"company" success:^{
                [hud hide:YES];
                [JGProgressHelper showSuccess:@"取消收藏成功"];
                [self.TableCompany reloadData];
                
            } failure:^(NSError *error) {
                [hud hide:YES];
                [JGProgressHelper showError:@"取消收藏失败"];
            }];
            [self.companyArry removeObjectAtIndex:indexPath.row];
            
            NSArray * temp = [NSArray arrayWithObject:indexPath];
            //更新ui
            
            [ tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
            [tableView setEditing:NO animated:YES];
            
            
        }];
        
        NSArray * arr = @[layTopRowAction1];
        return arr;

    }
    else
    {
        UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            WHproductList * model = self.coverArry[indexPath.row];
            self.coverId = model.id;
            id hud = [JGProgressHelper showProgressInView:self.view];
            [self.userService delcollectWithUid:@"" type_id:self.coverId type:@"product" success:^{
                [hud hide:YES];
                [JGProgressHelper showSuccess:@"取消收藏成功"];
                [self.TableCover reloadData];
                
            } failure:^(NSError *error) {
                [hud hide:YES];
                [JGProgressHelper showError:@"取消收藏失败"];
            }];
            [self.coverArry removeObjectAtIndex:indexPath.row];
            
            NSArray * temp = [NSArray arrayWithObject:indexPath];
            //更新ui
            
            [ tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
            [tableView setEditing:NO animated:YES];
            
            
        }];
    
    NSArray * arr = @[layTopRowAction1];
    return arr;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
