//
//  LoanTableViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/29.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanTableViewCell.h"

@implementation LoanTableViewCell
{
    UIImageView *m_leftImage;
    UILabel *m_topTitle;
    UILabel *m_firDetail;
    UILabel *m_rightImage;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.cellHeight = DIF_PX(84);
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
        m_leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(12), DIF_PX(16), DIF_PX(50), DIF_PX(50))];
        [m_leftImage.layer setCornerRadius:5];
        [m_leftImage.layer setMasksToBounds:YES];
        [m_leftImage.layer setBorderWidth:1];
        [m_leftImage.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.contentView addSubview:m_leftImage];
        [self createContentView];
        [self createRedBag];
    }
    return self;
}

- (void)createContentView
{
    UIView *centView = [[UIView alloc] initWithFrame:CGRectMake(m_leftImage.right+DIF_PX(14), m_leftImage.top, DIF_SCREEN_WIDTH-DIF_PX(145), m_leftImage.height)];
    [self.contentView addSubview:centView];
    
    m_topTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, centView.width, DIF_PX(25))];
    [m_topTitle setTextColor:DIF_HEXCOLOR(@"#333333")];
    [m_topTitle setFont:DIF_DIFONTOFSIZE(18)];
    [centView addSubview:m_topTitle];
    m_firDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, m_topTitle.bottom, m_topTitle.width, DIF_PX(20))];
    [m_firDetail setTextColor:DIF_HEXCOLOR(@"#999999")];
    [m_firDetail setFont:DIF_DIFONTOFSIZE(13)];
    [centView addSubview:m_firDetail];
}

- (void)createRedBag
{
    UIImageView *redBag = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_SCREEN_WIDTH, 0, DIF_PX(35), DIF_PX(39))];
    [redBag setRight:DIF_SCREEN_WIDTH-DIF_PX(20)];
    [redBag setCenterY:self.cellHeight/2];
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
    [m_rightImage setFont:DIF_UIFONTOFSIZE(5)];
    [m_rightImage setTextAlignment:NSTextAlignmentCenter];
//    [m_rightImage setText:@"600-1200元"];
    [redBag addSubview:m_rightImage];
}

- (void)loadData:(RootLoanDetailModel *)model
{
    [m_leftImage sd_setImageWithURL:[NSURL URLWithString:model.productUrl]];
    [m_topTitle setText:model.productName];
    [m_firDetail setText:model.summary];
    [m_rightImage setText:[model.generalizeAmount stringByAppendingString:@"元"]];
}


@end
