//
//  HmPhysicalGroupCell.m
//  whm_project
//
//  Created by zhaoHm on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmPhysicalGroupCell.h"
#import "MacroUtility.h"

@implementation HmPhysicalGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化
        
       
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (IBAction)deleteGroup:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    NSLog(@"sbsbsb");
    
    
    
    
}

@end
