//
//  MyBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyBaseView.h"
#import "MyBaseViewCell.h"

@implementation MyBaseView
{
    BaseTableView *m_TableView;
    UIView *m_TopView;
    UIImageView *m_CustomIcon;
    UILabel *m_CustomName;
    UIButton *m_CustomLive;
    NSArray *m_TitleArr;
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
    UIImageView *backView = [[UIImageView alloc] initWithFrame:self.bounds];
    [backView setBackgroundColor:[UIColor greenColor]];
    [self addSubview:backView];
}

- (void)createTopView
{
    m_TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [m_TopView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:m_TopView];
    
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(100), DIF_SCREEN_WIDTH*2, DIF_SCREEN_WIDTH*2)];
    [roundView setCenterX:m_TopView.width/2];
    [roundView setBackgroundColor:[UIColor whiteColor]];
    [roundView.layer setCornerRadius:DIF_SCREEN_WIDTH];
    [m_TopView addSubview:roundView];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(160), DIF_SCREEN_WIDTH, DIF_SCREEN_HEIGHT*2)];
    [spaceView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [m_TopView addSubview:spaceView];
    
    m_CustomIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DIF_PX(80), DIF_PX(80))];
    [m_CustomIcon setBackgroundColor:[UIColor yellowColor]];
    [m_CustomIcon setCenterX:m_TopView.width/2];
    [m_CustomIcon setCenterY:roundView.top];
    [m_TopView addSubview:m_CustomIcon];
    
    m_CustomName = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(40), m_CustomIcon.bottom+DIF_PX(6), m_TopView.width-DIF_PX(40*2), DIF_PX(40))];
    [m_CustomName setTextAlignment:NSTextAlignmentCenter];
    [m_TopView addSubview:m_CustomName];
    
    m_CustomLive = [UIButton buttonWithType:UIButtonTypeCustom];
    [m_CustomLive setFrame:CGRectMake(m_CustomName.left, m_CustomName.bottom+DIF_PX(6), m_CustomName.width, DIF_PX(60))];
    [m_CustomLive.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [m_TopView addSubview:m_CustomLive];
}

- (void)createTableView
{
    m_TableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, self.height) style:UITableViewStyleGrouped];
    [m_TableView setBackgroundColor:[UIColor clearColor]];
    [m_TableView setBackgroundView:nil];
    [m_TableView setDelegate:self];
    [m_TableView setDataSource:self];
    [self addSubview:m_TableView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_TopView setTop:-scrollView.contentOffset.y];
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DIF_PX(220);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyBaseViewCell *cell = [BaseTableViewCell cellClassName:@"MyBaseViewCell"
                                                InTableView:tableView
                                            forContenteMode:nil];
    [cell.textLabel setText:m_TitleArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(220))];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, view.width, 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"999999")];
    [view addSubview:line];
    
    return view;
}

@end
