//
//  SpecialNewsViewTextCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/19.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewTextCell.h"

@implementation SpecialNewsViewTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 145;
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, DIF_SCREEN_WIDTH-24, 35)];
        [self.title setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.title setFont:DIF_UIFONTOFSIZE(15)];
        [self.title setNumberOfLines:0];
        [self.title setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.title];
        
        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(12, self.title.bottom+10, DIF_SCREEN_WIDTH-24, 50)];
        [self.detail setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.detail setFont:DIF_UIFONTOFSIZE(12)];
        [self.detail setNumberOfLines:0];
        [self.detail setLineBreakMode:NSLineBreakByCharWrapping];
        [self.contentView addSubview:self.detail];
        
        self.company = [[UILabel alloc] initWithFrame:CGRectMake(12, self.detail.bottom+10, DIF_SCREEN_WIDTH-24, 15)];
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
    [self.title setText:model.title];
    [self.detail setText:model.summary];
    [self.company setText:[NSString stringWithFormat:@"%@   %@阅读",model.author, model.hits]];
}

@end
