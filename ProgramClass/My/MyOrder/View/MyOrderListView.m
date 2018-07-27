//
//  MyOrderListView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyOrderListView.h"

@implementation MyOrderListView
{
    UIScrollView *m_BaseView;
    NSMutableArray<BaseTableView *> *m_TableViewArr;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_TableViewArr = [NSMutableArray arrayWithCapacity:2];
        m_BaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [m_BaseView setContentSize:CGSizeMake(frame.size.width*2, frame.size.height)];
        [m_BaseView setShowsVerticalScrollIndicator:NO];
        [m_BaseView setShowsHorizontalScrollIndicator:NO];
        [m_BaseView setScrollEnabled:NO];
        [m_BaseView setScrollsToTop:NO];
        [self addSubview:m_BaseView];
        [self createContentTableView];
    }
    return self;
}

- (void)createContentTableView
{
    for (int i = 0; i < 2; i++)
    {
        BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:CGRectMake(i*m_BaseView.width, 0, m_BaseView.width, m_BaseView.height)
                                                                  style:UITableViewStylePlain];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [tableView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [m_BaseView addSubview:tableView];
        [m_TableViewArr addObject:tableView];
    }
}

- (void)showContentViewWithIndex:(NSInteger)index
{
    [m_BaseView setContentOffset:CGPointMake(index*m_BaseView.width, 0) animated:YES];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListViewCell *cell = [BaseTableViewCell cellClassName:@"MyOrderListViewCell" InTableView:nil forContenteMode:nil];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListViewCell *cell = [BaseTableViewCell cellClassName:@"MyOrderListViewCell" InTableView:tableView forContenteMode:nil];
    
    [cell.titleLab setText:@"全家出行旅游意外保险"];
    [cell.dateLab setText:[CommonDate getNowDateWithFormate:@"yyyy-MM-dd HH:mm"]];
    [cell.moneyLab setText:@"推广奖励：20-80元"];
    [cell.statusLab setText:@"待付款"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectBlock)
    {
        self.selectBlock(indexPath, nil);
    }
}

@end
