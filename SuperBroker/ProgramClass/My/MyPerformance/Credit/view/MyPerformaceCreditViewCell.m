//
//  MyPerformaceCreditViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/6.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyPerformaceCreditViewCell.h"

@implementation MyPerformaceCreditViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_ProductNameLab;
    UILabel *m_customNameLab;
    UILabel *m_customMoneyLab;
    UILabel *m_MoneyLab;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(87);
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 50, 50)];
        [m_LeftIcon setCenterY:self.cellHeight/2];
        [self.contentView addSubview:m_LeftIcon];
        
        m_MoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), self.cellHeight)];
        [m_MoneyLab setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_MoneyLab setCenterY:self.cellHeight/2];
        [m_MoneyLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [m_MoneyLab setFont:DIF_DIFONTOFSIZE(18)];
        [m_MoneyLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_MoneyLab];
        
        m_ProductNameLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+14, m_LeftIcon.top, m_MoneyLab.left-m_LeftIcon.right-20, 20)];
        [m_ProductNameLab setFont:DIF_UIFONTOFSIZE(15)];
        [m_ProductNameLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:m_ProductNameLab];
        
        m_customMoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(m_ProductNameLab.left, m_ProductNameLab.bottom+5, m_ProductNameLab.width, 15)];
        [m_customMoneyLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_customMoneyLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.contentView addSubview:m_customMoneyLab];
        
        m_customNameLab = [[UILabel alloc] initWithFrame:CGRectMake(m_customMoneyLab.left, m_customMoneyLab.bottom+5, m_customMoneyLab.width, 15)];
        [m_customNameLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_customNameLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.contentView addSubview:m_customNameLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(MyPerformanceCreditDetailModel *)model
{
    [m_LeftIcon sd_setImageWithURL:[NSURL URLWithString:model.productUrl]
                  placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_ProductNameLab setText:model.productName];
    NSString *customMoney = [NSString stringWithFormat:@"贷款金额：%@元",model.orderAmount];
    if (model.orderType.integerValue == 80)
    {
        customMoney = [NSString stringWithFormat:@"期待金额：%@元",model.orderAmount];
    }
    [m_customMoneyLab setText:customMoney];
    [m_customNameLab setText:[NSString stringWithFormat:@"贷款人：%@",model.borrowerName]];
    [m_MoneyLab setText:[model.insuranceMoney stringByAppendingString:@"元"]];
}

@end
