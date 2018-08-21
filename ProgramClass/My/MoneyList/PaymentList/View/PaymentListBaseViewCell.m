//
//  PaymentListBaseViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PaymentListBaseViewCell.h"

@implementation PaymentListBaseViewCell
{
    UILabel *m_NameLab;
    UILabel *m_TimeLab;
    UILabel *m_MoneyLab;
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 67;
        
        m_NameLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, DIF_SCREEN_WIDTH/5*3, 13)];
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
            make.top.bottom.centerY.equalTo(strongSelf);
            make.right.equalTo(self.contentView).offset(-12);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(NSDictionary *)model
{
    [m_NameLab setText:model[@"name"]];
    [m_TimeLab setText:model[@"time"]];
    [m_MoneyLab setAttributedText:model[@"money"]];
}
@end
