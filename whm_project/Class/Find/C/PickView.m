//
//  PickView.m
//  whm_project
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "PickView.h"

@interface PickView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong)NSMutableArray *provenceArr;//存放省的数组
@property (nonatomic,strong)NSMutableArray *cityArr;//存放市的数组
@property (nonatomic,strong)NSMutableArray * areaArr;

@property (nonatomic,strong)NSMutableArray * selectedArray;

@property (nonatomic, strong) UIPickerView *pickerView;

@end



@implementation PickView

- (instancetype)init
{
    if (self = [super init])
    {
        
        self.selectedArray = [NSMutableArray array];
        self.provenceArr = [NSMutableArray array];
        self.cityArr = [NSMutableArray array];
        self.areaArr = [NSMutableArray array];
         
        
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240);
        self.pickerView = [[UIPickerView alloc]initWithFrame:self.bounds];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        [self addSubview:_pickerView];
          
        NSString *path = [[NSBundle mainBundle]pathForResource:@"allAreafileaaa" ofType:@"plist"];
        NSDictionary *provincedic = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSArray * arr = provincedic[@"data"];
        
        self.provenceArr = [DataModel  arrayOfModelsFromDictionaries:arr error:nil];
        
        DataModel * data = self.provenceArr[0];
        [_cityArr addObjectsFromArray:data.child];
        _idprovence = data.area_id;
        
        childModel * child = data.child[0];
        
        [_areaArr addObjectsFromArray:child.child];
        _idcity = child.area_id;
        
        childOneModel * mod = _areaArr[0];
        _idarea = mod.area_id;
        
        
    }
    
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.provenceArr.count;
        
    }else if (component == 1)
    {
        return self.cityArr.count;
    }else
    {
        return self.areaArr.count;
    }
    return 0;
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, wScreenW/3,40)];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:13];
    label.text=[self pickerView:pickerView titleForRow:row forComponent:component]; // 数据源
    return label;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        DataModel * data = self.provenceArr[row];
        _idprovence = data.area_id;
        _sheng = data.area_name;
        return data.area_name;
        
    }else if (component == 1)
    {
        childModel * mod = self.cityArr[row];
        _idcity = mod.area_id;
        _shi = mod.area_name;
        return mod.area_name;
        
    }else if (component == 2)
    {
        childOneModel * mod = self.areaArr[row];
        _idarea = mod.area_id;
        _qu = mod.area_name;
        return mod.area_name;
    }
    
    return nil;
}

#pragma mark -- UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        [self.selectedArray removeAllObjects];
        [self.cityArr removeAllObjects];
        [self.areaArr removeAllObjects];
        
        DataModel * data = _provenceArr[row];
        
        [self.selectedArray addObjectsFromArray:data.child];
        
        
        [self.cityArr addObjectsFromArray:data.child];
        childModel * mod = data.child[0];
        [self.areaArr addObjectsFromArray:mod.child];
        
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
    }
    else if (component == 1)
    {
        if (self.selectedArray.count == 0 )
        {
            DataModel * data = _provenceArr[0];
            [self.selectedArray addObjectsFromArray:data.child];
        }
        childModel * mod = self.selectedArray[row];
        [self.areaArr removeAllObjects];
        [self.areaArr addObjectsFromArray:mod.child];
        
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    
    NSInteger provinces = [pickerView selectedRowInComponent:0];
    NSInteger city = [pickerView selectedRowInComponent:1];
    NSInteger area = [pickerView selectedRowInComponent:2];
    
    DataModel * data = self.provenceArr[provinces];
    
    _idprovence = data.area_id;
    _sheng = data.area_name;
    if (self.cityArr.count >=1 && self.cityArr.count >= city && city >=0)
    {
        childModel * child = self.cityArr[city];
        _idcity = child.area_id;
        _shi = child.area_name;
    }else
    {
        _idcity = @"";
         _shi = @"";
    }
    if (self.areaArr.count>=1 && self.areaArr.count >= area && area >= 0)
    {
        childOneModel * oneModel = self.areaArr[area];
        _idarea = oneModel.area_id;
        _qu = oneModel.area_name;
        
    }else
    {
        _idarea = @"";
        _qu = @"";
    }
}
#pragma mark -- show and hidden
- (void)showInView:(UIView *)view
{
    
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
}

- (void)hiddenPickerView
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


@end
