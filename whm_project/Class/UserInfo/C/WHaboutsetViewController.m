//
//  WHaboutsetViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/2.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaboutsetViewController.h"

@interface WHaboutsetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableV;


@end
@implementation WHaboutsetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"清除缓存";
    [self set_p];
}

-(void)set_p
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableV.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self.view addSubview:_tableV];

    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    if (section == 0) {
//        return 1;
//    }
//    else
//    {
//        return 1;
//    }
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        if (indexPath.row == 0 )
        {
            cell.textLabel.text = @"清除缓存";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
        }
        
        
    }
    
    
    return cell;
}
//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger size=[[SDImageCache sharedImageCache]getSize];
//    NSLog(@"缓存===========%@",[WBYRequest fileSizeOfLength:size]);
    
    [WBYRequest showMessage:[NSString stringWithFormat:@"清除缓存%@",[WBYRequest fileSizeOfLength:size]]];
    
    [[SDImageCache sharedImageCache] clearDisk];
    
    
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
