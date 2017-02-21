//
//  WHrelationTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrelationTableViewController.h"
#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface WHrelationTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)NSString *  strID;
@property(nonatomic,strong)NSString * strLaber;


@end

@implementation WHrelationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"选择关系";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    
    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableV];
 
    self.navigationItem .rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(left:)];


}
-(void)left:(UIBarButtonItem *)sender
{
    if (self.strLaber != nil && self.strID != 0) {
        self.mblock2 (self.strLaber,self.strID);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  kScreenHeight * 0.081;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"本人";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];

        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"丈夫";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"妻子";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }

        if (indexPath.row == 3) {
            cell.textLabel.text = @"父亲";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"母亲";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = @"儿子";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 6) {
            cell.textLabel.text = @"女儿";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 7) {
            cell.textLabel.text = @"祖父";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 8) {
            cell.textLabel.text = @"祖母";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 9) {
            cell.textLabel.text = @"外祖父";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 10) {
            cell.textLabel.text = @"外祖母";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        if (indexPath.row == 11) {
            cell.textLabel.text = @"其他";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        

        
    }
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        self.strID = @"0";
        self.strLaber = @"本人";
    }
    if (indexPath.row == 1) {
        self.strID = @"1";
        self.strLaber = @"丈夫";
    }
    if (indexPath.row == 2) {
        self.strID = @"2";
        self.strLaber = @"妻子";
    }
    if (indexPath.row == 3) {
        self.strID = @"3";
        self.strLaber = @"父亲";
    }
    if (indexPath.row == 4) {
        self.strID = @"4";
        self.strLaber = @"母亲";
    }
    if (indexPath.row == 5) {
        self.strID = @"5";
        self.strLaber = @"儿子";
    }
    if (indexPath.row == 6) {
        self.strID = @"6";
        self.strLaber = @"女儿";
    }
    if (indexPath.row == 7) {
        self.strID = @"7";
        self.strLaber = @"祖父";
    }
    if (indexPath.row == 8) {
        self.strID = @"8";
        self.strLaber = @"祖母";
    }
    if (indexPath.row == 9) {
        self.strID = @"9";
        self.strLaber = @"外祖父";
    }
    if (indexPath.row == 10) {
        self.strID = @"10";
        self.strLaber = @"外祖母";
    }
    if (indexPath.row == 11) {
        self.strID = @"11";
        self.strLaber = @"其他";
    }

    
    
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
