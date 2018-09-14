//
//  MessageBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MessageBaseView.h"

@implementation MessageBaseView
{
    UIScrollView *m_BaseView;
    NSMutableArray<BaseTableView *> *m_TableViewArr;
    NSInteger m_SegmentIndex;
    NSMutableDictionary *m_ReadDic;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.noDataImageName = @"无记录";
        m_ReadDic = [NSMutableDictionary dictionary];
        m_SegmentIndex = 0;
        m_TableViewArr = [NSMutableArray arrayWithCapacity:2];
        m_BaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, DIF_PX(42), frame.size.width, frame.size.height-DIF_PX(42))];
        [m_BaseView setContentSize:CGSizeMake(frame.size.width*2, frame.size.height)];
        [m_BaseView setShowsVerticalScrollIndicator:NO];
        [m_BaseView setShowsHorizontalScrollIndicator:NO];
        [m_BaseView setScrollEnabled:NO];
        [m_BaseView setScrollsToTop:NO];
        [self addSubview:m_BaseView];
        [self createPageController];
        [self createContentTableView];
    }
    return self;
}

- (void)createPageController
{
    CommonPageControlView *pageView = [[CommonPageControlView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(42))
                                                                            titles:@[@"系统消息",@"财富消息"]
                                                                          oneWidth:DIF_SCREEN_WIDTH/2-18];
    [self addSubview:pageView];
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self addSubview:lineT];
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, pageView.height-1, DIF_SCREEN_WIDTH, 1)];
    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self addSubview:lineB];
    pageView.selectBlock = self.pageSelectBlock;
    DIF_WeakSelf(self)
    [pageView setSelectBlock:^(NSInteger page) {
        DIF_StrongSelf
        if(strongSelf.pageSelectBlock)
        {
            strongSelf.pageSelectBlock(page);
        }
        strongSelf->m_SegmentIndex = page;
        strongSelf.segmentIndex = page;
        [strongSelf->m_BaseView setContentOffset:CGPointMake(page*strongSelf->m_BaseView.width, 0) animated:YES];
        [strongSelf->m_TableViewArr[page].mj_header beginRefreshing];
    }];
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
        [tableView setBackgroundView:[self getBackGroundView]];
        [m_BaseView addSubview:tableView];
        [m_TableViewArr addObject:tableView];
        tableView.refreshBlock = self.refreshBlock;
        tableView.loadMoreBlock = self.loadMoreBlock;
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
    for (BaseTableView *tv in m_TableViewArr)
    {
        tv.refreshBlock = refreshBlock;
    }
}

- (void)setLoadMoreBlock:(tableViewLoadMoreBlock)loadMoreBlock
{
    _loadMoreBlock = loadMoreBlock;
    for (BaseTableView *tv in m_TableViewArr)
    {
        tv.loadMoreBlock = loadMoreBlock;
    }
}

- (void)endloadEvent
{
    for (BaseTableView *tv in m_TableViewArr)
    {
        [tv endRefresh];
    }
}

- (void)reloadTableView
{
    if(m_SegmentIndex == 0)
    {
        [m_TableViewArr.firstObject reloadData];
    }
    else
    {
        [m_TableViewArr.lastObject reloadData];
    }
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.backgroundView = nil;
    NSInteger count = m_SegmentIndex == 0?self.systemNoticeList.count:self.wealthNoticeList.count;
    if (count == 0)
    {
        [tableView setBackgroundView:[self getBackGroundView]];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageBaseViewCell *cell = [BaseTableViewCell cellClassName:@"MessageBaseViewCell"
                                                     InTableView:nil
                                                 forContenteMode:nil];
    return cell.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageNoticeDetailModel *detailModel = [MessageNoticeDetailModel mj_objectWithKeyValues:m_SegmentIndex == 0?self.systemNoticeList[indexPath.row]:self.wealthNoticeList[indexPath.row]];
    detailModel.isRead = m_ReadDic[detailModel.noticeId]?YES:NO;
    detailModel.noticeType = [@(m_SegmentIndex+1) stringValue];
    MessageBaseViewCell *cell = [BaseTableViewCell cellClassName:@"MessageBaseViewCell"
                                                     InTableView:tableView
                                                 forContenteMode:detailModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (m_SegmentIndex == 0)
    {
        MessageNoticeDetailModel *detailModel = [MessageNoticeDetailModel mj_objectWithKeyValues:self.systemNoticeList[indexPath.row]];
        detailModel.isRead = YES;
        [m_ReadDic setObject:[@(YES) stringValue] forKey:detailModel.noticeId];
        [self.systemNoticeList replaceObjectAtIndex:indexPath.row withObject:detailModel];
        if(self.selectBlock)
        {
            self.selectBlock(indexPath, detailModel);
        }
    }
    else
    {
        MessageNoticeDetailModel *detailModel = [MessageNoticeDetailModel mj_objectWithKeyValues:self.wealthNoticeList[indexPath.row]];
        detailModel.isRead = YES;
        [m_ReadDic setObject:[@(YES) stringValue] forKey:detailModel.noticeId];
        [self.wealthNoticeList replaceObjectAtIndex:indexPath.row withObject:detailModel];
        if(self.selectBlock)
        {
            self.selectBlock(indexPath, detailModel);
        }
    }
    [tableView reloadData];
}
@end
