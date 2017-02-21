//
//  WHnewsTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/4.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnewsTableViewController.h"
#import "WHnewscollectTableViewCell.h"
#import "UIColor+Hex.h"
#import "MacroUtility.h"
#import "WHnews.h"
#import "JGProgressHelper.h"
#import <UIImageView+WebCache.h>

@interface WHnewsTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WHnewscollectTableViewCell * cell;
@property(nonatomic,strong)UITableView * tableV ;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)NSString * ids;
@end

@implementation WHnewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self qureDate];
    
}
-(void)qureDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
       [self.dataService getnewsWithUid:@""
                                   type:@"news"
                                success:^(NSArray *lists) {
                                    [hud hide:YES];
                                    self.dataArry = [NSMutableArray arrayWithArray:lists];
                                    [self.tableV reloadData];
                                    
                                } failure:^(NSError *error) {
                                    [hud hide:YES];
                                    //[JGProgressHelper showError:@"你还没有收藏任何咨询内容"];
                                    
                                }];
    
}

-(void)setUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    
    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self.view addSubview:_tableV];
    [self.tableV registerClass:[WHnewscollectTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHnewscollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    WHnews * model = self.dataArry[indexPath.row];
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
        WHnews * model = self.dataArry[indexPath.row];
        self.ids = model.id;
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService delcollectWithUid:@"" type_id:self.ids type:@"news" success:^{
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
