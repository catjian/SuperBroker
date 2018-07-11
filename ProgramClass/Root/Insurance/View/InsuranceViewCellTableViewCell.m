//
//  InsuranceViewCellTableViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceViewCellTableViewCell.h"

@implementation InsuranceViewCellTableViewCell
{
    UIImageView *m_leftImage;
    UILabel *m_topTitle;
    UILabel *m_firDetail;
    UILabel *m_secDetail;
    UILabel *m_thrDetail;
    UILabel *m_rightTitle;
    UIImageView *m_rightImage;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(100);
        m_leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(5), DIF_PX(10), DIF_PX(80), DIF_PX(80))];
        [self.contentView addSubview:m_leftImage];
        [self createCenterView];
        m_rightTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, DIF_PX(5), DIF_PX(80), DIF_PX(30))];
        [m_rightTitle setRight:DIF_PX(5)];
        [self.contentView addSubview:m_rightTitle];
        m_rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(m_rightImage.left, m_rightImage.bottom+DIF_PX(5), DIF_PX(50), DIF_PX(50))];
        [m_rightImage setCenterX:m_rightTitle.centerX];
        [self.contentView addSubview:m_rightImage];       
    }
    return self;
}

- (void)createCenterView
{
    UIView *centView = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(90), DIF_PX(0), DIF_SCREEN_WIDTH-DIF_PX(180), self.cellHeight)];
    [self.contentView addSubview:centView];
    
    m_topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centView.width, DIF_PX(40))];
    [centView addSubview:m_topTitle];
    m_firDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_topTitle.bottom, m_topTitle.width, DIF_PX(20))];
    [centView addSubview:m_firDetail];
    m_secDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_firDetail.bottom, m_firDetail.width, m_firDetail.height)];
    [centView addSubview:m_secDetail];
    m_thrDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_secDetail.bottom, m_firDetail.width, m_firDetail.height)];
    [centView addSubview:m_thrDetail];
}

- (void)loadData:(id)model
{
    
}

@end
