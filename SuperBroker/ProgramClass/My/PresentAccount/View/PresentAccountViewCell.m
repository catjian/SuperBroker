//
//  PresentAccountViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentAccountViewCell.h"

@implementation PresentAccountViewCell
{
    UILabel *m_LeftTitle;
    UITextField *m_ContentLab;
    UIImageView *m_RightIcon;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = 51;
        m_LeftTitle = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(90), self.cellHeight)];
        [m_LeftTitle setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_LeftTitle setFont:DIF_DIFONTOFSIZE(15)];
        [m_LeftTitle setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_LeftTitle];
        
        m_RightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(9), DIF_PX(16))];
        [m_RightIcon setCenterY:self.cellHeight/2];
        [m_RightIcon setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_RightIcon setImage:[UIImage imageNamed:@"右括号"]];
        [m_RightIcon setHidden:YES];
        [self.contentView addSubview:m_RightIcon];
        
        m_ContentLab = [[UITextField alloc] initWithFrame:CGRectMake(m_LeftTitle.right+DIF_PX(12), 0, m_RightIcon.left-DIF_PX(19), self.cellHeight)];
        [m_ContentLab setRight:m_RightIcon.left-DIF_PX(19)];
        [m_ContentLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_ContentLab setFont:DIF_DIFONTOFSIZE(14)];
        [m_ContentLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_ContentLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cellHeight-1, DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.contentView addSubview:line];
    }
    return self;
}

- (void) loadData:(NSDictionary *)model
{
    [m_RightIcon setHidden:![model[@"showRight"] boolValue]];
    [m_LeftTitle setText:model[@"leftTitle"]];
    [m_ContentLab setText:model[@"content"]];
    [m_ContentLab setEnabled:![model[@"showRight"] boolValue]];
}

- (NSString *)contentStr
{
    _contentStr = m_ContentLab.text;
    return _contentStr;
}
@end
