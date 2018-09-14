//
//  MessageBaseViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MessageBaseViewCell.h"

@implementation MessageBaseViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_TitleLab;
    UILabel *m_TimeLab;
    UILabel *m_DetailLab;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 50;
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 21, 21)];
        [self.contentView addSubview:m_LeftIcon];
        
        m_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+12, m_LeftIcon.top, DIF_SCREEN_WIDTH/5*3, 18)];
        [m_TitleLab setFont:DIF_UIFONTOFSIZE(15)];
        [m_TitleLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:m_TitleLab];
        
        m_DetailLab = [[UILabel alloc] initWithFrame:CGRectMake(m_DetailLab.left, m_DetailLab.bottom+DIF_PX(6), m_DetailLab.width, 15)];
        [m_DetailLab setFont:DIF_UIFONTOFSIZE(12)];
        [m_DetailLab setTextColor:DIF_HEXCOLOR(@"999999")];
        [self.contentView addSubview:m_DetailLab];
        
        UIImageView *rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右括号"]];
        [rightIcon setCenterY:self.cellHeight/2];
        [rightIcon setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [self.contentView addSubview:rightIcon];
        
        DIF_WeakSelf(self);
        m_TimeLab = [UILabel new];
        [m_TimeLab setFont:DIF_UIFONTOFSIZE(10)];
        [m_TimeLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_TimeLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_TimeLab];
        [m_TimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            DIF_StrongSelf
            make.left.equalTo(strongSelf->m_TitleLab.mas_right);
            make.top.bottom.centerY.equalTo(strongSelf);
            make.right.equalTo(rightIcon.mas_left).offset(-12);
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)loadData:(MessageNoticeDetailModel *)model
{
    if (model.noticeType.integerValue == 1)
    {
        [m_LeftIcon setImage:[UIImage imageNamed:model.isRead?@"系统消息-已读":@"系统消息-未读"]];
        [m_TitleLab setText:model.noticeTitle];
        [m_DetailLab setText:model.noticeDetail];
        [m_TimeLab setText:(model.createTime?[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:model.createTime.integerValue/1000]
                                                              Formate:@"yyyy-MM-dd"]:@"")];
    }
    else
    {
        [m_LeftIcon setImage:[UIImage imageNamed:model.isRead?@"财富消息-已读":@"财富消息-未读"]];
        [m_TitleLab setText:model.noticeTitle];
        [m_DetailLab setText:model.noticeDetail];
        [m_TimeLab setText:(model.createTime?[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:model.createTime.integerValue/1000]
                                                              Formate:@"yyyy-MM-dd"]:@"")];
    }
}

@end
