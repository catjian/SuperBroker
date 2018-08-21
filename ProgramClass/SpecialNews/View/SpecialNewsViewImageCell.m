//
//  SpecialNewsViewImageCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/19.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewImageCell.h"

@implementation SpecialNewsViewImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 95;
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
        
        self.pic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 107, 63)];
        [self.pic setRight:DIF_SCREEN_WIDTH-12];
        [self.pic setCenterY:self.cellHeight/2];
        [self.contentView addSubview:self.pic];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, self.pic.left-27, 35)];
        [self.title setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.title setFont:DIF_UIFONTOFSIZE(15)];
        [self.title setNumberOfLines:0];
        [self.title setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.title];
        
        self.company = [[UILabel alloc] initWithFrame:CGRectMake(12, self.title.bottom+20, DIF_SCREEN_WIDTH-24, 15)];
        [self.company setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.company setFont:DIF_UIFONTOFSIZE(10)];
        [self.company setNumberOfLines:0];
        [self.company setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.company];
    }
    return self;
}

- (void)loadData:(ArticleListDetailModel *)model
{
    [self.pic sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
    [self.title setText:model.title];
    [self.company setText:[NSString stringWithFormat:@"%@   %@阅读",model.author, model.hits]];
}

@end
