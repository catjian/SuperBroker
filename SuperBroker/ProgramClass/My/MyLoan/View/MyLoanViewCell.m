//
//  MyLoanViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyLoanViewCell.h"

@implementation MyLoanViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_ProductNameLab;
    UILabel *m_customNameLab;
    UILabel *m_customMoneyLab;
    UILabel *m_MoneyLab;
    UILabel *m_StatusLab;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(104);
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 16, 50, 50)];
        [m_LeftIcon.layer setCornerRadius:5];
        [m_LeftIcon.layer setMasksToBounds:YES];
        [m_LeftIcon.layer setBorderWidth:1];
        [m_LeftIcon.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.contentView addSubview:m_LeftIcon];
        
        m_StatusLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), self.cellHeight)];
        [m_StatusLab setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_StatusLab setCenterY:self.cellHeight/2];
        [m_StatusLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [m_StatusLab setFont:DIF_DIFONTOFSIZE(13)];
        [m_StatusLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_StatusLab];
        
        m_ProductNameLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+14, m_LeftIcon.top, m_StatusLab.left-m_LeftIcon.right-20, 20)];
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
        
        m_MoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(m_customNameLab.left, m_customNameLab.bottom+5, m_customNameLab.width, 15)];
        [m_MoneyLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_MoneyLab setTextColor:DIF_HEXCOLOR(@"ff5000")];
        [self.contentView addSubview:m_MoneyLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(MyloadListDetailModel *)model
{
    [m_LeftIcon sd_setImageWithURL:[NSURL URLWithString:model.productUrl]
                  placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_ProductNameLab setText:model.productName];
    [m_customMoneyLab setText:[NSString stringWithFormat:@"期待金额：%@元",model.expectAmount]];
    [m_customNameLab setText:[NSString stringWithFormat:@"贷款人：%@",model.borrowerName]];
    [m_MoneyLab setText:[NSString stringWithFormat:@"推广奖励%@元",model.generalizeAmount]];
    [m_StatusLab setText:model.orderStatusName];
    NSString *colorStr = @"333333";
    if (model.orderStatus.integerValue==13||model.orderStatus.integerValue==83)
    {
        colorStr = @"ff5000";
    }
    if (model.orderStatus.integerValue==15) {
        colorStr = @"017aff";
    }
    [m_StatusLab setTextColor:DIF_HEXCOLOR(colorStr)];
}

@end
