//
//  InviteListViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InviteListViewCell.h"

@implementation InviteListViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_NameLab;
    UILabel *m_TimeLab;
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
        
        m_StateLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+12, m_LeftIcon.top, DIF_SCREEN_WIDTH/5*3, 18)];
        [m_StateLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_StateLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:m_StateLab];
        
        m_TimeLab = [[UILabel alloc] initWithFrame:CGRectMake(m_StateLab.left, m_StateLab.bottom+10, m_StateLab.width, 15)];
        [m_TimeLab setFont:DIF_UIFONTOFSIZE(10)];
        [m_TimeLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.contentView addSubview:m_TimeLab];
        
        DIF_WeakSelf(self);
        m_NameLab = [UILabel new];
        [m_NameLab setFont:DIF_UIFONTOFSIZE(15)];
        [m_NameLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_NameLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_NameLab];
        [m_NameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            DIF_StrongSelf
            make.left.equalTo(strongSelf->m_StateLab.mas_right);
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
    [m_LeftIcon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]]
                  placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_NameLab setText:model[@"name"]];
    [m_TimeLab setText:model[@"time"]];
    [m_StateLab setAttributedText:model[@"status"]];
}

@end
