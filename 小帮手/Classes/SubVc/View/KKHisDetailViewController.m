//
//  KKHisDetailViewController.m
//  小帮手
//
//  Created by Kenny.li on 16/5/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKHisDetailViewController.h"
#import "KKHistoryModel.h"
#import "UIImageView+WebCache.h"
@interface KKHisDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pic;
@property (weak, nonatomic) IBOutlet UITextView *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *chineseTime;

@end

@implementation KKHisDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setModel:self.model];
}


- (void)setModel:(KKHistoryModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.title;
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"shuji2"]];
    self.textLabel.text = model.des;
    self.timeLable.text = [NSString stringWithFormat:@"%@-%@-%@",model.year,model.month,model.day];
    self.chineseTime.text = model.lunar;   
 //   NSLogg(@"self.chineseTime.text--%@ model.lunar--%@",self.chineseTime.text,model.lunar);
}




@end
