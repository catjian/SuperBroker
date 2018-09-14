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
    NSInteger m_SegmentIndex;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.noDataImageName = @"无记录";
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
        [tableView setBackgroundView:[self getBackGroundView]];
        [m_TableViewArr addObject:tableView];
    }
}

- (UIView *)getBackGroundView
{
    UIView *m_BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [m_BGView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.noDataImageName]];
    [imageView setCenterX:self.width/2];
    [imageView setCenterY:DIF_PX(352/2)];
    [m_BGView addSubview:imageView];
    
    NSDictionary *titleDic = @{@"无记录":@"什么都没有",
                               @"数据错误":@"数据错误，请下拉刷新",
                               @"网络走丢了":@"网络走丢了\n请检查您的网络或下拉刷新",
                               @"已超时":@"已超时，请下拉刷新"};
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+10, self.width, DIF_PX(20))];
    [lab setText:titleDic[self.noDataImageName]];
    [lab setTextColor:DIF_HEXCOLOR(@"d8d8d8")];
    [lab setFont:DIF_UIFONTOFSIZE(18)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    if ([self.noDataImageName isEqualToString:@"网络走丢了"])
    {
        [lab setHeight:DIF_PX(50)];
        [lab setNumberOfLines:0];
        [lab setLineBreakMode:NSLineBreakByCharWrapping];
    }
    [m_BGView addSubview:lab];
    
    return m_BGView;
}

- (void)setRefreshBlock:(tableViewHeaderRefreshBlock)refreshBlock
{
    _refreshBlock = refreshBlock;
    m_TableViewArr.firstObject.refreshBlock = self.refreshBlock;
    m_TableViewArr.lastObject.refreshBlock = self.refreshBlock;
}

- (void)setLoadMoreBlock:(tableViewLoadMoreBlock)loadMoreBlock
{
    _loadMoreBlock = loadMoreBlock;
    m_TableViewArr.firstObject.loadMoreBlock = self.loadMoreBlock;
    m_TableViewArr.lastObject.loadMoreBlock = self.loadMoreBlock;    
}

- (void)showContentViewWithIndex:(NSInteger)index
{
    m_SegmentIndex = index;
    [m_BaseView setContentOffset:CGPointMake(index*m_BaseView.width, 0) animated:YES];
    [m_TableViewArr[index].mj_header beginRefreshing];
}

- (void)setInsuranceList:(NSArray *)insuranceList
{
    _insuranceList = insuranceList;
    [m_TableViewArr.firstObject reloadData];
}

- (void)setCarList:(NSArray *)carList
{
    _carList = carList;
    [m_TableViewArr.lastObject reloadData];
}

- (void)loadTableView
{
    [m_TableViewArr[m_SegmentIndex].mj_header beginRefreshing];
}

- (void)endloadEvent
{
    [m_TableViewArr.firstObject endRefresh];
    [m_TableViewArr.lastObject endRefresh];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.backgroundView = nil;
    NSInteger count = m_SegmentIndex==0?self.insuranceList.count:self.carList.count;
    if (count == 0)
    {
        [tableView setBackgroundView:[self getBackGroundView]];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListViewCell *cell = [BaseTableViewCell cellClassName:@"MyOrderListViewCell" InTableView:nil forContenteMode:nil];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceOrderDetailModel *model = [InsuranceOrderDetailModel mj_objectWithKeyValues:m_SegmentIndex==0?self.insuranceList[indexPath.row]:self.carList[indexPath.row]];
    MyOrderListViewCell *cell = [BaseTableViewCell cellClassName:@"MyOrderListViewCell" InTableView:tableView forContenteMode:nil];    
    [cell.titleLab setText:model.productName];
    [cell.dateLab setText:[CommonDate dateToString:[NSDate dateWithTimeIntervalSince1970:model.createTime.integerValue/1000]
                                           Formate:@"yyyy-MM-dd HH:mm"]];
    [cell.moneyLab setText:[NSString stringWithFormat:@"推广奖励：%@元",model.generalizeAmount]];
    if (m_SegmentIndex == 0 && model.orderStatus.integerValue == 15)
    {        
        [cell.statusLab setText:[NSString stringWithFormat:@"%@\n%@元",model.orderStatusName,model.orderAmount]];
    }
    else if (m_SegmentIndex == 1 && model.orderStatus.integerValue == 11)
    {
        [cell.statusLab setText:[NSString stringWithFormat:@"%@\n%@元",model.orderStatusName,model.orderAmount]];
    }
    else
    {
        [cell.statusLab setText:model.orderStatusName];
    }
    [cell.statusLab setTextColor:DIF_HEXCOLOR(DIF_StateTypeColor[model.orderStatusName])];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.productUrl]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectBlock)
    {
        InsuranceOrderDetailModel *model = [InsuranceOrderDetailModel mj_objectWithKeyValues:m_SegmentIndex==0?self.insuranceList[indexPath.row]:self.carList[indexPath.row]];
        self.selectBlock(indexPath, model);
    }
}

@end
