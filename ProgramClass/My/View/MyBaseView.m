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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setFrame:CGRectMake(0, DIF_PX(11), DIF_PX(22), DIF_PX(22))];
    [rightBtn setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
    [rightBtn setImage:[UIImage imageNamed:@"客服-黑"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"客服-白色"] forState:UIControlStateHighlighted];
    [m_TopView addSubview:rightBtn];
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

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [MyViewDataModel getDataModel].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[MyViewDataModel getDataModel] objectAtIndex:section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ?DIF_PX(270):DIF_PX(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBaseViewCell *cell = [BaseTableViewCell cellClassName:@"MyBaseViewCell"
                                                InTableView:tableView
                                            forContenteMode:[MyViewDataModel getDataModel][indexPath.section][indexPath.row]];
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 0.1)];
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
    [m_CustomIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"头像"]];
    [m_CustomIcon.layer setCornerRadius:40];
    [m_CustomIcon.layer setMasksToBounds:YES];
    [roundView addSubview:m_CustomIcon];
    
    m_CustomName = [[UILabel alloc] initWithFrame:CGRectMake(m_CustomIcon.right+DIF_PX(12), DIF_PX(42), 0, DIF_PX(30))];
    [m_CustomName setWidth:roundView.width-m_CustomName.left];
    [m_CustomName setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomName setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomName setText:@"用户名"];
    [roundView addSubview:m_CustomName];
    
    m_CustomLive = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_CustomLive setFrame:CGRectMake(m_CustomName.left, m_CustomName.bottom, m_CustomName.width, DIF_PX(30))];
    [m_CustomLive setTitle:@"高级会员" forState:UIControlStateNormal];
    [m_CustomLive setTitleColor:DIF_HEXCOLOR(@"ff5000") forState:UIControlStateNormal];
    [m_CustomLive.titleLabel setFont:DIF_UIFONTOFSIZE(13)];
    m_CustomLive.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [m_CustomLive setTag:9900];
    [m_CustomLive addTarget:self action:@selector(topButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [roundView addSubview:m_CustomLive];
    
    m_CustomCoupon = [[UILabel alloc] initWithFrame:CGRectMake(0, m_CustomIcon.bottom+DIF_PX(20), DIF_PX(140), DIF_PX(14))];
    [m_CustomCoupon setText:@"88.00"];
    [m_CustomCoupon setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomCoupon setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomCoupon setTextAlignment:NSTextAlignmentCenter];
    [roundView addSubview:m_CustomCoupon];
    
    UIButton *couponTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    [couponTitle setFrame:CGRectMake(m_CustomCoupon.left, m_CustomCoupon.bottom+DIF_PX(12), m_CustomCoupon.width, DIF_PX(14))];
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
    [m_CustomIncome setText:@"230.00 元"];
    [m_CustomIncome setTextColor:DIF_HEXCOLOR(@"333333")];
    [m_CustomIncome setFont:DIF_UIFONTOFSIZE(18)];
    [m_CustomIncome setTextAlignment:NSTextAlignmentRight];
    [roundView addSubview:m_CustomIncome];
    
    UILabel *incomeTitle = [[UILabel alloc] initWithFrame:CGRectMake(lineH.right+DIF_PX(45), couponTitle.top, roundView.right-lineH.right, DIF_PX(14))];
    [incomeTitle setText:@"我的收益"];
    [incomeTitle setTextColor:DIF_HEXCOLOR(@"999999")];
    [incomeTitle setFont:DIF_UIFONTOFSIZE(13)];
    [roundView addSubview:incomeTitle];
    
    return roundView;
}

@end
