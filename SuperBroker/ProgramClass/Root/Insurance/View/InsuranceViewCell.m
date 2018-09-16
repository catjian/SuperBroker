//
//  InsuranceViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceViewCell.h"

@implementation InsuranceViewCell
{
    UIImageView *m_leftImage;
    UILabel *m_topTitle;
    UILabel *m_firDetail;
    UILabel *m_secDetail;
    UILabel *m_thrDetail;
    UILabel *m_rightTitle;
    UILabel *m_rightImage;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(100);
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
        m_leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), DIF_PX(16), DIF_PX(84), DIF_PX(63))];
        [m_leftImage.layer setBorderWidth:1];
        [m_leftImage.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.contentView addSubview:m_leftImage];
        [self createCenterView];
        m_rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(m_topTitle.right, DIF_PX(12), DIF_SCREEN_WIDTH-m_topTitle.right-DIF_PX(5), DIF_PX(30))];
//        [m_rightTitle setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [m_rightTitle setTextColor:DIF_HEXCOLOR(@"ff5000")];
        [m_rightTitle setFont:DIF_UIFONTOFSIZE(22)];
        [m_rightTitle setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_rightTitle];
        [self createRedBag];
    }
    return self;
}

- (void)createCenterView
{
    UIView *centView = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(110), m_leftImage.top, DIF_SCREEN_WIDTH-DIF_PX(180), m_leftImage.height)];
    [self.contentView addSubview:centView];
    
    m_topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centView.width, DIF_PX(18))];
    [centView addSubview:m_topTitle];
    m_firDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_topTitle.bottom+14, m_topTitle.width, DIF_PX(13))];
    [centView addSubview:m_firDetail];
    m_secDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_firDetail.bottom+5, m_firDetail.width, DIF_PX(13))];
    [m_secDetail setNumberOfLines:0];
    [m_secDetail setLineBreakMode:NSLineBreakByCharWrapping];
    [m_secDetail setFont:DIF_UIFONTOFSIZE(13)];
    [m_secDetail setTextColor:DIF_HEXCOLOR(@"999999")];
    [centView addSubview:m_secDetail];
//    m_thrDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_secDetail.bottom+5, m_firDetail.width, m_firDetail.height)];
//    [centView addSubview:m_thrDetail];
}

- (void)createRedBag
{
    UIImageView *redBag = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_SCREEN_WIDTH, 0, DIF_PX(35), DIF_PX(39))];
    [redBag setRight:DIF_SCREEN_WIDTH-DIF_PX(20)];
    [redBag setBottom:self.cellHeight-DIF_PX(16)];
    [redBag setImage:[UIImage imageNamed:@"红包"]];
    [self.contentView addSubview:redBag];
    
    UILabel *rbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, DIF_PX(19), redBag.width, DIF_PX(6))];
    [rbTitle setTextColor:DIF_HEXCOLOR(@"ffffff")];
    [rbTitle setFont:DIF_UIFONTOFSIZE(6)];
    [rbTitle setText:@"推广奖励"];
    [rbTitle setTextAlignment:NSTextAlignmentCenter];
    [redBag addSubview:rbTitle];
    
    m_rightImage = [[UILabel alloc] initWithFrame:CGRectMake(0, rbTitle.bottom+2, rbTitle.width, DIF_PX(12))];
    [m_rightImage setTextColor:DIF_HEXCOLOR(@"ffffff")];
    [m_rightImage setFont:DIF_UIFONTOFSIZE(8)];
    [m_rightImage setTextAlignment:NSTextAlignmentCenter];
    [m_rightImage setText:@"600-1200元"];
    [redBag addSubview:m_rightImage];
}

- (void)loadData:(NSDictionary *)model
{
    [m_leftImage sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]]];
    [m_topTitle setAttributedText:model[@"contentTitle"]];
    [m_firDetail setAttributedText:model[@"contentAge"]];
    [m_secDetail setText:model[@"contentMoney1"]];
//    [m_thrDetail setAttributedText:model[@"contentMoney2"]];
    [m_rightTitle setAttributedText:model[@"contentMoney3"]];
    [m_rightImage setText:[model[@"promotionRewards"] stringByAppendingString:@"元"]];
}

@end
