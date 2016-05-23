//
//  KKHisTableViewCell.h
//  小帮手
//
//  Created by Kenny.li on 16/5/18.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKHisTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (nonatomic,strong)NSArray *dictArray;
@end
