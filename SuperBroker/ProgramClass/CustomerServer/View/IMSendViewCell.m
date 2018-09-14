//
//  IMSendViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IMSendViewCell.h"

@implementation IMSendViewCell
{
    UIImageView *m_UserIcon;
    UIView *m_MessageView;
    UILabel *m_MessageLab;
    UIView *m_ImageBack;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.cellHeight = (12+28+5);
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:DIF_HEXCOLOR(@"")];
        m_UserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_SCREEN_WIDTH-DIF_PX(28)-DIF_PX(12), DIF_PX(12), DIF_PX(28), DIF_PX(28))];
        [m_UserIcon setImage:[UIImage imageNamed:@"头像"]];
        [self.contentView addSubview:m_UserIcon];
        
        [self createMessageView];
    }
    return self;
}

- (void)createMessageView
{
    CGFloat offset_y = 0,width = 0, left = 0;
    width = DIF_SCREEN_WIDTH-m_UserIcon.width*5;
    left = DIF_SCREEN_WIDTH-DIF_PX(28)-DIF_PX(12)*2 - width;
    m_MessageView = [[UIView alloc] initWithFrame:CGRectMake(left, m_UserIcon.top, width, m_UserIcon.height)];
    [self.contentView addSubview:m_MessageView];
    
    m_ImageBack = [[UIView alloc] initWithFrame:m_MessageView.bounds];
    [m_MessageView addSubview:m_ImageBack];
    
    offset_y = 0;
    width = 0;
    CGFloat offset_x = 0, height = 0;
    for (int i = 0; i < 3; i++)
    {
        width = 0;
        offset_x = 0;
        height = 0;
        for (int j = 1; j <= 3; j++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"popSend_%d.png",i*3+j]];
            height = image.size.height/2;
            width = image.size.width/2<50?image.size.width/2:50;
            UIImageView *popView = [[UIImageView alloc] initWithImage:image];
            [popView setTag:100+(i*3+j)];
            [popView setFrame:CGRectMake(offset_x, offset_y, width, height)];
            [m_ImageBack addSubview:popView];
            offset_x+= width;
        }
        offset_y += height;
    }
    [m_ImageBack setWidth:offset_x];
    [m_ImageBack setRight:m_MessageView.width];
    m_MessageLab = [[UILabel alloc] initWithFrame:[m_ImageBack viewWithTag:105].frame];
    [m_MessageLab setLineBreakMode:NSLineBreakByCharWrapping];
    [m_MessageLab setNumberOfLines:0];
    [m_MessageLab setFont:DIF_UIFONTOFSIZE(13)];
    [m_MessageLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_MessageView addSubview:m_MessageLab];
}

- (void)loadData:(NSString *)model
{
    CGRect attrsRect = [model boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(13)}
                                           context:nil];
    CGFloat maxWidht = (m_MessageView.width - (20+35)/2);
    int lineNum = ceil(attrsRect.size.width / maxWidht);
    [m_MessageLab setWidth:attrsRect.size.width>maxWidht?maxWidht:attrsRect.size.width];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"popSend_%d.png",5]];
    [m_MessageLab setHeight:image.size.height/2];
    if (lineNum > 1)
    {
        [m_MessageLab setHeight:attrsRect.size.height*lineNum];
    }
    [m_MessageLab setText:model];
    self.cellHeight = (12+28+5)-12+m_MessageLab.height;
    m_MessageView.height = m_UserIcon.height-12+m_MessageLab.height;
    m_ImageBack.height = m_MessageView.height;
    [m_ImageBack setWidth:m_MessageLab.width+(20+35)/2];
    [m_ImageBack setRight:m_MessageView.width];
    for (int i = 0; i < 3; i++)
    {
        for (int j = 1; j <= 3; j++)
        {
            NSInteger num = (i*3+j);
            UIImageView *popView = (UIImageView *)[m_ImageBack viewWithTag:100+num];
            if (num == 2 || num == 5 || num == 8)
            {
                [popView setLeft:[m_ImageBack viewWithTag:101].right];
                [popView setWidth:m_MessageLab.width];
            }
            if (num == 4 || num == 5)
            {
                [popView setHeight:m_MessageLab.height];
            }
            if(num == 6)
            {
                [popView setHeight:m_MessageLab.height];
                popView.image = [popView.image stretchableImageWithLeftCapWidth:0 topCapHeight:20];
                [m_MessageLab setLeft:popView.left];
            }
            if (num == 7 || num == 8 || num == 9)
            {
                [popView setTop:[m_ImageBack viewWithTag:105].bottom];
            }
            if (num == 1 || num == 4 || num == 7)
            {
                [popView setLeft:0];
            }
            if (num == 3 || num == 6 || num == 9)
            {
                [popView setLeft:[m_ImageBack viewWithTag:102].right];
            }
        }
    }
    [m_MessageLab setLeft:[m_ImageBack viewWithTag:105].left+m_ImageBack.left];
}

@end
