//
//  MyIncomeListBaseViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyIncomeListBaseViewCell.h"

@implementation MyIncomeListBaseViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_NameLab;
    UILabel *m_TimeLab;
    UILabel *m_MoneyLab;
    UILabel *m_StateLab;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 67;
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 43, 43)];
        [self.contentView addSubview:m_LeftIcon];
        
        m_NameLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+12, m_LeftIcon.top, DIF_SCREEN_WIDTH/5*3, 13)];
        [m_NameLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_NameLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:m_NameLab];
        
        m_TimeLab = [[UILabel alloc] initWithFrame:CGRectMake(m_NameLab.left, m_NameLab.bottom+24, m_NameLab.width, 10)];
        [m_TimeLab setFont:DIF_UIFONTOFSIZE(10)];
        [m_TimeLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.contentView addSubview:m_TimeLab];
        
        DIF_WeakSelf(self);
        m_MoneyLab = [UILabel new];
        [m_MoneyLab setFont:DIF_UIFONTOFSIZE(18)];
        [m_MoneyLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_MoneyLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_MoneyLab];
        [m_MoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            DIF_StrongSelf
            make.left.equalTo(strongSelf->m_NameLab.mas_right);
            make.centerY.equalTo(strongSelf->m_NameLab);
            make.right.equalTo(self.contentView).offset(-12);
            make.height.mas_offset(18);
        }];
        
        m_StateLab = [UILabel new];
        [m_StateLab setTextAlignment:NSTextAlignmentRight];
        [m_StateLab setFont:DIF_UIFONTOFSIZE(11)];
        [self.contentView addSubview:m_StateLab];
        [m_StateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            DIF_StrongSelf
            make.left.right.equalTo(strongSelf->m_MoneyLab);
            make.centerY.equalTo(strongSelf->m_TimeLab);
            make.height.mas_offset(11);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(NSDictionary *)model
{
//    [m_LeftIcon setImage:[UIImage imageNamed:model[@"icon"]]];
    [m_LeftIcon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]]];
    [m_NameLab setText:model[@"name"]];
    [m_TimeLab setText:model[@"time"]];
    [m_MoneyLab setText:model[@"money"]];
    [m_StateLab setText:model[@"status"]];
}

@end
