//
//  MyBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyBaseView.h"
#import "MyBaseViewCell.h"
#import "MyViewDataModel.h"

@implementation MyBaseView
{
    BaseTableView *m_TableView;
    UIView *m_TopView;
    UIImageView *m_CustomIcon;
    UILabel *m_CustomName;
    UIButton *m_CustomLive;
    NSArray *m_TitleArr;
    UILabel *m_CustomCoupon;
    UILabel *m_CustomIncome;
    UIButton *m_MyLevelBtn;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_TitleArr = @[@"我的订单", @"基本信息", @"提现账户", @"我的邀请",@"设置",@"我的提现",@"我的邀请码"];
        [self createBackView];
        [self createTopView];
        [self createTableView];
    }
    return self;
}

- (void)createBackView
{
    UIImage *image = [UIImage imageNamed:@"个人中心背景"];
    UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX_Scale(image.size.width), DIF_PX_Scale(image.size.height))];
    [backView setImage:image];
    [backView setBackgroundColor:[UIColor blueColor]];
    [self addSubview:backView];
}

- (void)createTopView
{
    m_TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.width, self.height)];
    [m_TopView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:m_TopView];
}

- (void)createTableView
{
    m_TableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, self.height) style:UITableViewStyleGrouped];
    [m_TableView setBackgroundColor:[UIColor clearColor]];
    [m_TableView setBackgroundView:nil];
    [m_TableView setDelegate:self];
    [m_TableView setDataSource:self];
    [m_TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:m_TableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_TopView setTop:20-scrollView.contentOffset.y];
}

- (void)topButtonEvent:(UIButton *)btn
{
    if(self.topBtnBlock)
    {
        self.topBtnBlock(btn.tag);
    }
}

- (void)setBrokerInfoModel:(BrokerInfoDataModel *)brokerInfoModel
{
    _brokerInfoModel = brokerInfoModel;
    [m_TableView reloadData];
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel] objectAtIndex:section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ?DIF_PX(270):DIF_PX(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel].count == section+1?50:0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBaseViewCell *cell = [BaseTableViewCell cellClassName:@"MyBaseViewCell"
                                                InTableView:tableView
                                            forContenteMode:[MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel][indexPath.section][indexPath.row]];
    if (indexPath.section == [MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel].count-1 && self.brokerInfoModel &&
        self.brokerInfoModel.brokerType.integerValue != 64)
    {
        [cell setCopyBlock:^{
            [self makeToast:@"复制成功！"
                   duration:2 position:CSToastPositionCenter];
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock)
    {
        self.selectBlock(indexPath, nil);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(270))];
        [backview setBackgroundColor:[UIColor clearColor]];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(0, 20+DIF_PX(11), DIF_PX(22), DIF_PX(22))];
        [rightBtn setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [rightBtn setTag:9999];
        [rightBtn setImage:[UIImage imageNamed:@"客服-黑"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"客服-白色"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [backview addSubview:rightBtn];
        
        UIView *contentView = [self createHeaderContentView];
        [backview addSubview:contentView];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, backview.height-DIF_PX(10), DIF_SCREEN_WIDTH, DIF_PX(10))];
        [view setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        [backview addSubview:view];
        UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
        [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [view addSubview:lineT];
        UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
        [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [view addSubview:lineB];
        
        return backview;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(10))];
        [view setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
        
        UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.width, 1)];
        [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [view addSubview:lineT];
        UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
        [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [view addSubview:lineB];
        
        return view;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel].count ==section+1)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH,
                                                                [MyViewDataModel getDataModelWithBrokerInfoDataModel:self.brokerInfoModel].count ==section+1?50: 0.1)];
        [view setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        
        
        UILabel *lab = [[UILabel alloc] initWithFrame:view.bounds];
        [lab setTextColor:DIF_HEXCOLOR(@"999999")];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        // app build版本
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        NSString *versionStr = [NSString stringWithFormat:@"当前版本: %@-%@",app_Version,app_build];
        [lab setText:versionStr];
        [lab setFont:DIF_DIFONTOFSIZE(14)];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [view addSubview:lab];
        return view;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH,0.1)];
    [view setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    return view;
}

- (UIView *)createHeaderContentView
{
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(12), DIF_PX(76), DIF_SCREEN_WIDTH-DIF_PX(24), DIF_PX(270-76))];
    [roundView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [roundView.layer setCornerRadius:5];
    
//    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, roundView.top+DIF_PX(194), DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT*2)];
//    [spaceView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
//    [m_TopView addSubview:spaceView];
    
    m_CustomIcon = [[UIImageView alloc] initWithFrame:CGRectMake(DIF_PX(34), DIF_PX(31), DIF_PX(80), DIF_PX(80))];
    [m_CustomIcon sd_setImageWithURL:[NSURL URLWithString:self.brokerInfoModel.brokerPictureUrl] placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_CustomIcon.layer setCornerRadius:DIF_PX(80/2)];
    [m_CustomIcon.layer setMasksToBounds:YES];
    [roundView addSubview:m_CustomIcon];
    
    m_CustomName = [[UILabel alloc] initWithFrame:CGRectMake(m_CustomIcon.right+DIF_PX(12), DIF_PX(42), 0, DIF_PX(30))];
    [m_CustomName setWidth:roundView.width-m_CustomName.left];
    [m_CustomName setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomName setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomName setText:self.brokerInfoModel.brokerName];
    [roundView addSubview:m_CustomName];
    
    
    m_CustomLive = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_CustomLive setFrame:CGRectMake(m_CustomName.left, m_CustomName.bottom, m_CustomName.width, DIF_PX(30))];
    NSDictionary *levelNames = @{@"6":@"钻石经纪人-标志", @"7":@"白金经纪人-标志", @"8":@"黄金经纪人-标志", @"82":@"白银经纪人-标志"};
    NSString *level = levelNames[self.brokerInfoModel.payType];
    if (level && self.brokerInfoModel.brokerType.integerValue != 10)
    {
        NSString *levelStr = self.brokerInfoModel.levelId?self.brokerInfoModel.memberName:@"注册会员";
        levelStr = [levelStr stringByAppendingString:@"     "];
        NSMutableAttributedString *status = [[NSMutableAttributedString alloc] initWithString:levelStr];
        [status attatchImage:[UIImage imageNamed:level]
                  imageFrame:CGRectMake(7, -2, 13, 13)
                       Range:NSMakeRange(0, levelStr.length-5)];
        [m_CustomLive setAttributedTitle:status forState:UIControlStateNormal];
    }
    else
    {
        [m_CustomLive setTitle:(self.brokerInfoModel.levelId?self.brokerInfoModel.memberName:@"注册会员")
                      forState:UIControlStateNormal];
    }
    [m_CustomLive setTitleColor:DIF_HEXCOLOR(@"ff5000") forState:UIControlStateNormal];
    [m_CustomLive.titleLabel setFont:DIF_UIFONTOFSIZE(13)];
    m_CustomLive.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [m_CustomLive setTag:9900];
//    if (self.brokerInfoModel.brokerType.integerValue == 64)
//    {
//        [m_CustomLive addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
//    }
    [roundView addSubview:m_CustomLive];
    
    m_CustomCoupon = [[UILabel alloc] initWithFrame:CGRectMake(0, m_CustomIcon.bottom+DIF_PX(20), DIF_PX(140), DIF_PX(14))];
    [m_CustomCoupon setText:[NSString stringWithFormat:@"%.2f", self.brokerInfoModel.vouchers.floatValue]];//@"88.00"];
    [m_CustomCoupon setText:[NSString stringWithFormat:@"%@", self.brokerInfoModel.vouchers?self.brokerInfoModel.vouchers:@""]];//@"88.00"];
    [m_CustomCoupon setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomCoupon setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomCoupon setTextAlignment:NSTextAlignmentCenter];
    [roundView addSubview:m_CustomCoupon];
    
    UIButton *couponTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [couponTitle setFrame:CGRectMake(m_CustomCoupon.left, m_CustomCoupon.bottom+DIF_PX(6), m_CustomCoupon.width, DIF_PX(14+12))];
    [couponTitle setTitle:@"我的消费券" forState:UIControlStateNormal];
    [couponTitle setTitleColor:DIF_HEXCOLOR(@"999999") forState:UIControlStateNormal];
    [couponTitle.titleLabel setFont:DIF_UIFONTOFSIZE(13)];
    [couponTitle setTag:9901];
    [couponTitle addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:couponTitle];
    
    UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(m_CustomCoupon.right, m_CustomCoupon.top, 1, DIF_PX(35))];
    [lineH setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [roundView addSubview:lineH];
    
    UIButton *withdraw = [UIButton buttonWithType:UIButtonTypeCustom];
    [withdraw setFrame:CGRectMake(0, m_CustomCoupon.top, DIF_PX(46), DIF_PX(17))];
    [withdraw setRight:roundView.width-DIF_PX(40)];
    [withdraw setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
    [withdraw setTag:9902];
    [withdraw addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:withdraw];
    
    m_CustomIncome = [[UILabel alloc] initWithFrame:CGRectMake(lineH.right, m_CustomCoupon.top, withdraw.left-lineH.right-DIF_PX(10), m_CustomCoupon.height)];
    [m_CustomIncome setText:[NSString stringWithFormat:@"%.2f 元", self.brokerInfoModel.income.floatValue]];//@"230.00 元"];
    [m_CustomIncome setText:[NSString stringWithFormat:@"%@ 元", self.brokerInfoModel.income?self.brokerInfoModel.income:@""]];//@"230.00 元"];
    [m_CustomIncome setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomIncome setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomIncome setTextAlignment:NSTextAlignmentCenter];
    [roundView addSubview:m_CustomIncome];
    
    UIButton *incomeTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [incomeTitle setFrame:CGRectMake(m_CustomIncome.left, couponTitle.top, m_CustomIncome.width, couponTitle.height)];
    [incomeTitle setTitle:self.brokerInfoModel.brokerType.integerValue==10?@"我的业绩":@"我的收益" forState:UIControlStateNormal];
    [incomeTitle setTitleColor:DIF_HEXCOLOR(@"999999") forState:UIControlStateNormal];
    [incomeTitle.titleLabel setFont:DIF_UIFONTOFSIZE(13)];
    [incomeTitle setTag:9903];
    [incomeTitle addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:incomeTitle];
    
    m_MyLevelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_MyLevelBtn setFrame:CGRectMake(0, 30, 60, 27)];
    [m_MyLevelBtn setRight:roundView.width+4];
    [m_MyLevelBtn setBackgroundImage:[UIImage imageNamed:@"标签"] forState:UIControlStateNormal];
    [m_MyLevelBtn setTitle:@"我的权益" forState:UIControlStateNormal];
    [m_MyLevelBtn setTitleColor:DIF_HEXCOLOR(@"ffffff") forState:UIControlStateNormal];
    [m_MyLevelBtn.titleLabel setFont:DIF_UIFONTOFSIZE(10)];
    [m_MyLevelBtn setTitleEdgeInsets:UIEdgeInsetsMake(-2, 8, 0, 0)];
    [m_MyLevelBtn setTag:9904];
    if (self.brokerInfoModel.brokerType.integerValue == 64)
    {
        [m_MyLevelBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }
    [m_MyLevelBtn addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:m_MyLevelBtn];
    
    
    if (self.brokerInfoModel.brokerType.integerValue == 10)
    {
        [roundView setFrame:CGRectMake(DIF_PX(12), DIF_PX(110), DIF_SCREEN_WIDTH-DIF_PX(24), DIF_PX(270-110))];
        [m_CustomIcon setSize:CGSizeMake(DIF_PX(110), DIF_PX(110))];
        [m_CustomIcon setCenterX:roundView.width/2];
        [m_CustomIcon setCenterY:0];
        [m_CustomIcon.layer setCornerRadius:DIF_PX(110/2)];
        [m_CustomIcon.layer setBorderWidth:DIF_PX(3)];
        [m_CustomIcon.layer setBorderColor:DIF_HEXCOLOR(@"ffffff").CGColor];
        [m_CustomName setTextAlignment:NSTextAlignmentCenter];
        [m_CustomName setFrame:CGRectMake(0, 0, roundView.width, m_CustomName.height)];
        [m_CustomName setTop:m_CustomIcon.bottom+DIF_PX(5)];
        [m_CustomLive setFrame:CGRectMake(0, 0, roundView.width, m_CustomLive.height)];
        [m_CustomLive setTop:m_CustomName.bottom+DIF_PX(5)];
        [m_CustomLive setTitleColor:DIF_HEXCOLOR(@"999999") forState:UIControlStateNormal];
        m_CustomLive.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [m_CustomIncome setHidden:YES];
        [incomeTitle setHidden:YES];
        [m_MyLevelBtn setHidden:YES];
        [m_CustomCoupon setHidden:YES];
        [couponTitle setHidden:YES];
        [lineH setHidden:YES];
        [withdraw setHidden:YES];
        [m_CustomIncome setLeft:m_CustomCoupon.left];
        [incomeTitle setLeft:couponTitle.left];
    }
    
    return roundView;
}

@end
