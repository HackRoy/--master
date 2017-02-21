//
//  JwBackBaseController.m
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "JwBackBaseController.h"
#import "UIBarButtonItem+Extension.h"

@interface JwBackBaseController ()

@end

@implementation JwBackBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(backBaseAction:) image:@"back" highImage:@"back"];
    
}

- (void)backBaseAction:(UIBarButtonItem *)barButton{
    [self.navigationController popViewControllerAnimated:YES];
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Getter
-(JwDataService *)dataService
{
    _dataService = [[JwDataService alloc] init];
    return _dataService;
}

- (JwUserService *)userService{
    
    _userService = [[JwUserService alloc] init];
    return _userService;
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
