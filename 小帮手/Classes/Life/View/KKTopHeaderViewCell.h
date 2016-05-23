//
//  KKTopHeaderViewCell.h
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//  顶部天气

#import <UIKit/UIKit.h>
@class KKWeatherModel,KKTopHeaderViewCell;


@protocol KKTopHeaderViewCellDelegate <NSObject>

@optional
-(void)topHeaderViewCellDidSelected:(KKTopHeaderViewCell *)cell;
@end


@interface KKTopHeaderViewCell : UICollectionViewCell
@property (nonatomic,strong)KKWeatherModel *weatherModel;
@property (nonatomic,strong)UINavigationController *navigationCC;
@property (nonatomic,assign) id<KKTopHeaderViewCellDelegate> delegate;
@end
