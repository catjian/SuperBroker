//
//  SpecialNewsBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsBaseView.h"

@implementation SpecialNewsBaseView
{
    UIScrollView *m_BaseView;
    NSMutableArray<BaseTableView *> *m_TableViewArr;
    NSInteger m_SegmentIndex;
    NSMutableDictionary *m_ListArrayDic;
    NSMutableArray *m_listArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.noDataImageName = @"无记录";
        m_listArr = [NSMutableArray array];
        m_ListArrayDic = [NSMutableDictionary dictionary];
        m_SegmentIndex = 0;
        m_TableViewArr = [NSMutableArray arrayWithCapacity:2];
        m_BaseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, DIF_PX(60), frame.size.width, frame.size.height-DIF_PX(60))];
        [m_BaseView setContentSize:CGSizeMake(frame.size.width*2, frame.size.height)];
        [m_BaseView setShowsVerticalScrollIndicator:NO];
        [m_BaseView setShowsHorizontalScrollIndicator:NO];
        [m_BaseView setScrollEnabled:NO];
        [m_BaseView setScrollsToTop:NO];
        [self addSubview:m_BaseView];
    }
    return self;
}

- (void)setClassifyArr:(NSArray *)classifyArr
{
    _classifyArr = classifyArr;
    [self createPageController];
}

- (void)createPageController
{
    NSMutableArray *titles = [NSMutableArray array];
    for (NSDictionary *dic in self.classifyArr)
    {
        ArticleclassifyModel *model = [ArticleclassifyModel mj_objectWithKeyValues:dic];
        [titles addObject:model.classifyName];
    }
    CommonPageControlView *pageView = [[CommonPageControlView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(60))
                                                                            titles:titles];
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
        [strongSelf->m_BaseView setContentOffset:CGPointMake(page*strongSelf->m_BaseView.width, 0) animated:YES];
        strongSelf->_listModel = strongSelf->m_ListArrayDic[[@(page) stringValue]];
        for (ArticleListModel *model in strongSelf.listModel)
        {
            [strongSelf->m_listArr addObjectsFromArray:model.list];
        }
        BaseTableView *tv = strongSelf->m_TableViewArr[strongSelf->m_SegmentIndex];
        [tv.mj_header beginRefreshing];
    }];
    [self createContentTableView];
}

- (void)createContentTableView
{
    for (int i = 0; i < self.classifyArr.count; i++)
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

- (void)setListModel:(NSArray *)listModel
{
    _listModel = listModel;
    [m_ListArrayDic setObject:listModel forKey:[@(m_SegmentIndex) stringValue]];
    m_listArr = [NSMutableArray array];
    for (ArticleListModel *model in listModel)
    {
        [m_listArr addObjectsFromArray:model.list];
    }
    BaseTableView *tv = m_TableViewArr[m_SegmentIndex];
    [tv reloadData];
}

- (void)endloadEvent
{
    for (BaseTableView *tv in m_TableViewArr)
    {
        [tv endRefresh];
    }
}

- (void)loadScrollView
{
    [m_BaseView setContentOffset:CGPointMake(m_SegmentIndex*m_BaseView.width, 0) animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.scrollBlock)
    {
        self.scrollBlock(nil, nil);
    }
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.backgroundView = nil;
    NSInteger count = m_listArr.count;
    if (count == 0)
    {
        [tableView setBackgroundView:[self getBackGroundView]];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleListDetailModel *model = [ArticleListDetailModel mj_objectWithKeyValues:m_listArr[indexPath.row]];
    if(model.imgUrlList.count <= 0)
    {
        SpecialNewsViewTextCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewTextCell"
                                                             InTableView:nil
                                                         forContenteMode:nil];
        return cell.cellHeight;
    }
    else if(model.imgUrlList.count > 0 && model.imgUrlList.count < 2)
    {
        SpecialNewsViewImageCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewImageCell"
                                                              InTableView:nil
                                                          forContenteMode:nil];
        return cell.cellHeight;
    }
    else
    {
        SpecialNewsViewMoreImageCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewMoreImageCell"
                                                                  InTableView:nil
                                                              forContenteMode:nil];
        return cell.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleListDetailModel *model = [ArticleListDetailModel mj_objectWithKeyValues:m_listArr[indexPath.row]];
    if(model.imgUrlList.count <= 0)
    {
        SpecialNewsViewTextCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewTextCell"
                                                             InTableView:tableView
                                                         forContenteMode:model];
        return cell;
    }
    else if(model.imgUrlList.count > 0 && model.imgUrlList.count < 2)
    {
        SpecialNewsViewImageCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewImageCell"
                                                              InTableView:tableView
                                                          forContenteMode:model];
        return cell;
    }
    else
    {
        SpecialNewsViewMoreImageCell *cell = [BaseTableViewCell cellClassName:@"SpecialNewsViewMoreImageCell"
                                                                  InTableView:tableView
                                                              forContenteMode:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleListDetailModel *model = [ArticleListDetailModel mj_objectWithKeyValues:m_listArr[indexPath.row]];
    if(self.selectBlock)
    {
        self.selectBlock(indexPath, model);
    }
}

@end
