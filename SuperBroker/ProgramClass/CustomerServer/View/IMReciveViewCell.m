//
//  IMReciveViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IMReciveViewCell.h"

@implementation IMReciveViewCell
{
    UIImageView *m_UserIcon;
    UIView *m_MessageView;
    UIView *m_ImageBack;
    UILabel *m_MessageLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.cellHeight = DIF_PX(12+28+5);
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setBackgroundColor:DIF_HEXCOLOR(@"")];
        m_UserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), DIF_PX(12), DIF_PX(28), DIF_PX(28))];
        [m_UserIcon setImage:[UIImage imageNamed:@"头像"]];
        [self.contentView addSubview:m_UserIcon];
        
        [self createMessageView];
    }
    return self;
}

- (void)createMessageView
{
    m_MessageView = [[UIView alloc] initWithFrame:CGRectMake(m_UserIcon.right+DIF_PX(12), m_UserIcon.top, DIF_SCREEN_WIDTH-m_UserIcon.width*5, m_UserIcon.height)];
    [self.contentView addSubview:m_MessageView];
    
    m_ImageBack = [[UIView alloc] initWithFrame:m_MessageView.bounds];
    [m_MessageView addSubview:m_ImageBack];
    
    CGFloat offset_y = 0;
    for (int i = 0; i < 3; i++)
    {
        CGFloat width = 0, offset_x = 0, height = 0;
        for (int j = 1; j <= 3; j++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"popRec_%d.png",i*3+j]];
            height = image.size.height/2;
            width = image.size.width/2<50?image.size.width/2:50;
            UIImageView *popView = [[UIImageView alloc] initWithImage:image];
            [popView setFrame:CGRectMake(offset_x, offset_y, width, height)];
            [popView setTag:100+(i*3+j)];
            [m_ImageBack addSubview:popView];
            offset_x+= width;
        }
        offset_y += height;
    }
    m_MessageLab = [[UILabel alloc] initWithFrame:[m_ImageBack viewWithTag:105].frame];
    [m_MessageLab setLineBreakMode:NSLineBreakByCharWrapping];
    [m_MessageLab setNumberOfLines:0];
    [m_MessageLab setFont:DIF_UIFONTOFSIZE(13)];
    [m_MessageLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_MessageView addSubview:m_MessageLab];
}

- (void)loadData:(NSString *)model
{
    NSArray *stringArr = [model componentsSeparatedByString:@"\n"];
    CGRect attrsRect = [model boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName : DIF_DIFONTOFSIZE(13)}
                                           context:nil];
    CGFloat maxWidht = (m_MessageView.width - (20+35)/2);
    int lineNum = ceil(attrsRect.size.width / maxWidht);
    for (NSString *str in stringArr)
    {
        if (str.length == 0)
        {
            lineNum++;
        }
    }
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
    for (int i = 0; i < 3; i++)
    {
        for (int j = 1; j <= 3; j++)
        {
            NSInteger num = (i*3+j);
            UIImageView *popView = (UIImageView *)[m_ImageBack viewWithTag:100+num];
            if (num == 2 || num == 5 || num == 8)
            {
                [popView setWidth:m_MessageLab.width];
            }
            if (num == 6 || num == 5)
            {
                [popView setHeight:m_MessageLab.height];
            }
            if(num == 4)
            {
                [popView setHeight:m_MessageLab.height];
                popView.image = [popView.image stretchableImageWithLeftCapWidth:0 topCapHeight:20];
            }
            if (num == 7 || num == 8 || num == 9)
            {
                [popView setTop:[m_ImageBack viewWithTag:105].bottom];
            }
            if (num == 3 || num == 6 || num == 9)
            {
                [popView setLeft:[m_ImageBack viewWithTag:102].right];
            }
        }
    }
}

@end
