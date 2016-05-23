//
//  KKLifeCollectionViewCell.m
//  小帮手
//
//  Created by Kenny.li on 16/5/14.
//  Copyright (c) 2016年 KK. All rights reserved.
//

#import "KKLifeCollectionViewCell.h"

@interface KKLifeCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation KKLifeCollectionViewCell

- (void)awakeFromNib
{
    self.imageView.layer.cornerRadius = 8;
    self.imageView.clipsToBounds = YES;
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)setItem:(KKLifeItem *)item
{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.titleLabel.text = item.title;
}

@end
