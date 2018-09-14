//
//  MyPerformaceMemberViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/6.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyPerformaceMemberViewCell.h"

@implementation MyPerformaceMemberViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_customNameLab;
    UILabel *m_MoneyLab;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(67);
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 43, 43)];
        [m_LeftIcon setCenterY:self.cellHeight/2];
        [self.contentView addSubview:m_LeftIcon];
        
        m_MoneyLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), self.cellHeight)];
        [m_MoneyLab setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_MoneyLab setCenterY:self.cellHeight/2];
        [m_MoneyLab setTextColor:DIF_HEXCOLOR(@"#ff5000")];
        [m_MoneyLab setFont:DIF_DIFONTOFSIZE(18)];
        [m_MoneyLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_MoneyLab];
        
        m_customNameLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+DIF_PX(12), 0, m_MoneyLab.left-m_LeftIcon.right-DIF_PX(12*2), self.cellHeight)];
        [m_customNameLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_customNameLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:m_customNameLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}


- (void)loadData:(MyPerformanceMemberDetailModel *)model
{
    [m_LeftIcon sd_setImageWithURL:[NSURL URLWithString:model.productUrl]
                  placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_customNameLab setText:[NSString stringWithFormat:@"%@ %@",model.borrowerName,model.brokerPhone]];
    [m_MoneyLab setText:[model.insuranceMoney stringByAppendingString:@"元"]];
}
@end
