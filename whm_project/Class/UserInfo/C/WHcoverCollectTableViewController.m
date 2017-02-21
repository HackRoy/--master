//
//  WHcoverCollectTableViewController.m
//  whm_project
//
//  Copyright © 2016年 chenJw. All rights reserved.
#import "WHcoverCollectTableViewController.h"
#import "WHcoverCollectTableViewCell.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHproductList.h"
#import "JGProgressHelper.h"
#import <UIImageView+WebCache.h>

@interface WHcoverCollectTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV ;
@property(nonatomic,strong)WHcoverCollectTableViewCell *cell;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * ids;

@end

@implementation WHcoverCollectTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self qureDate];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArry = [NSMutableArray array];
    [self setUI];
}
-(void)qureDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getcollectWithUid:@""
                                   type:@"product"
                                success:^(NSArray *lists)
    {
                                    [hud hide:YES];
        
        [self.dataArry addObjectsFromArray:lists];
        [self.tableV reloadData];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
       // [JGProgressHelper showError:@"你还没有收藏任何险种"];
        
    }];
    
}

-(void)setUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHcoverCollectTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   WHcoverCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WHproductList * model = self.dataArry[indexPath.row];
    [cell.companyImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    
    cell.titLaber.text = model.short_name;
    cell.ageLaber.text = [NSString stringWithFormat:@"投保年龄:%@",model.limit_age];
    cell.styLaber.text = [NSString stringWithFormat:@"产品类型:%@",model.ins_type];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.create_time.doubleValue];
    NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
    cell.timeLaber.text = [s1 substringToIndex:11];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
//删除事件
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        WHproductList * model = self.dataArry[indexPath.row];
        self.ids = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delcollectWithUid:@"" type_id:self.ids type:@"product" success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"取消收藏成功"];
            [self.tableV reloadData];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消收藏失败"];
        }];
        [self.dataArry removeObjectAtIndex:indexPath.row];
        
        NSArray * temp = [NSArray arrayWithObject:indexPath];
        //更新ui
        
        [ tableView  deleteRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationLeft];
        [tableView setEditing:NO animated:YES];
        
        
    }];
    
    NSArray * arr = @[layTopRowAction1];
    return arr;

    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件(只解除的是cell与手势间的冲突，cell以外仍然响应手势)
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"WHcoverCollectTableViewController"])
    {
        return NO;
    }
    
    // 若为UITableView（即点击了tableView任意区域），则不截获Touch事件(完全解除tableView与手势间的冲突，cell以外也不会再响应手势)
    if ([touch.view isKindOfClass:[WHcoverCollectTableViewCell class]])
        {
            return NO;
        }
        
        return YES;
        }

      
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
