//
//  MyBaseViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyBaseViewCell.h"

@implementation MyBaseViewCell
{
    UIImageView *m_LeftIcon;
    UILabel *m_LeftTitle;
    UILabel *m_ContentLab;
    UIImageView *m_RightIcon;
    UIButton *m_RightBtn;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        self.cellHeight = 50;
        self.showLine = YES;
        [self setShowLineWidht:DIF_SCREEN_WIDTH];
        
        m_LeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(22), DIF_PX(22))];
        [m_LeftIcon setCenterY:self.cellHeight/2];
        [self.contentView addSubview:m_LeftIcon];
        
        m_LeftTitle = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.left, 0, DIF_PX(70), self.cellHeight)];
        [m_LeftTitle setTextColor:DIF_HEXCOLOR(@"ff6600")];
        [m_LeftTitle setFont:DIF_DIFONTOFSIZE(18)];
        [self.contentView addSubview:m_LeftTitle];
        
        m_ContentLab = [[UILabel alloc] initWithFrame:CGRectMake(m_LeftIcon.right+DIF_PX(12), 0, DIF_PX(150), self.cellHeight)];
        [m_ContentLab setRight:DIF_SCREEN_WIDTH];
        [m_ContentLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_ContentLab setFont:DIF_DIFONTOFSIZE(15)];
        [self.contentView addSubview:m_ContentLab];
        
        m_RightIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(9), DIF_PX(16))];
        [m_RightIcon setCenterY:self.cellHeight/2];
        [m_RightIcon setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_RightIcon setImage:[UIImage imageNamed:@"右括号"]];
        [self.contentView addSubview:m_RightIcon];
        
        m_RightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_RightBtn setFrame:CGRectMake(0, 0, DIF_PX(95), DIF_PX(31))];
        [m_RightBtn setCenterY:self.cellHeight/2];
        [m_RightBtn setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_RightBtn setImage:[UIImage imageNamed:@"点击可复制"] forState:UIControlStateNormal];
        [m_RightBtn addTarget:self action:@selector(copyButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_RightBtn];
    }
    return self;
}

- (void)loadData:(NSDictionary *)model
{
    [m_RightIcon setHidden:YES];
    [m_RightBtn setHidden:YES];
    [m_LeftIcon setHidden:YES];
    [m_LeftTitle setHidden:YES];
    [m_ContentLab setLeft:m_LeftIcon.right+DIF_PX(12)];
    NSArray *key = @[@"icon",@"title",@"content"];
    NSString *value = model[key[0]];
    if (value && value.length > 0)
    {
        [m_LeftIcon setHidden:NO];
        [m_RightIcon setHidden:NO];
        [m_LeftIcon setImage:[UIImage imageNamed:value]];
        [m_ContentLab setText:model[key[2]]];
        return;
    }
    value = model[key[1]];
    if (value && value.length > 0)
    {
        [m_LeftTitle setHidden:NO];
        [m_RightBtn setHidden:NO];
        [m_LeftTitle setText:value];
        [m_ContentLab setLeft:m_LeftTitle.right];
        [m_ContentLab setAttributedText:model[key[2]]];
    }
}

- (void)copyButtonEvent:(UIButton *)btn
{
    if(self.copyBlock)
    {
        NSAttributedString *atrStr = m_ContentLab.attributedText;
        if (atrStr.string.length > 0) {            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = atrStr.string;
            self.copyBlock();
        }
    }
}

@end
