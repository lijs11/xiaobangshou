//
//  KKWeixinNewsViewCell.m
//  小帮手
//
//  Created by Kenny.li on 16/5/21.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKWeixinNewsViewCell.h"
#import "UIImageView+WebCache.h"
#import "KKWeixinNewsModel.h"
@interface KKWeixinNewsViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *yuleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation KKWeixinNewsViewCell


- (void)setModel:(KKWeixinNewsModel *)model{
    
    [self.picView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"zhangjie"]];
    self.titleLabel.text = model.title;
    self.yuleLabel.text = model.desc;
        
}






- (void)awakeFromNib {
    
    
}


@end
