//
//  LoanBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/29.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanBaseView.h"

@implementation LoanBaseView
{
    BaseTableView *m_TableView;
    NSMutableArray<UILabel *> *m_TopLabs;
    BOOL m_isSelectType;
    BOOL m_isSelectCom;
    BOOL m_isSelectAge;
    BOOL m_isSelectScreen;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.noDataImageName = @"无记录";
        m_isSelectType = NO;
        m_isSelectCom = NO;
        m_isSelectAge = NO;
        m_isSelectScreen = NO;
        [self createTopView];
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
        [line1 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line1];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(42), DIF_SCREEN_WIDTH, 1)];
        [line2 setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line2];
        [self createTableView];
    }
    return self;
}

- (NSArray *)topTitlesArray
{
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"资质"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectType?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectType?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"额度"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectCom?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectCom?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"办理周期"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectAge?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectAge?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"借贷期限"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectScreen?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:@"筛选"]
             imageFrame:CGRectMake(5, -2, 15, 15)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    return titles;
}

- (void)createTopView
{
    m_TopLabs = [NSMutableArray array];
    NSArray *titles = [self topTitlesArray];
    for (NSInteger i = 0; i < titles.count; i ++)
    {
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(self.width / titles.count * i, 0, self.width / titles.count, DIF_PX(42));
        label.tag = i;
        label.font = DIF_DIFONTOFSIZE(14);
        [label setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        label.textAlignment = NSTextAlignmentCenter;
        [label setAttributedText:(NSAttributedString *)titles[i]];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewLabelAction:)]];
        [self addSubview:label];
        [m_TopLabs addObject:label];
    }
}

- (void)topViewLabelAction:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    switch (index)
    {
        case 0:
            m_isSelectType = !m_isSelectType;
            break;
        case 1:
            m_isSelectCom = !m_isSelectCom;
            break;
        case 2:
            m_isSelectAge = !m_isSelectAge;
            break;
        default:
            m_isSelectScreen = !m_isSelectScreen;
            break;
    }
    NSArray *titles = [self topTitlesArray];
    UILabel *lab = m_TopLabs[index];
    [lab setAttributedText:titles[index]];
    if (self.topSelectBlock)
    {
        self.topSelectBlock(index);
    }
}

- (void)createTableView
{
    m_TableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, DIF_PX(43), DIF_SCREEN_WIDTH, self.height-50-DIF_PX(43)) style:UITableViewStylePlain];
    [m_TableView setDelegate:self];
    [m_TableView setDataSource:self];
    [m_TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [m_TableView setBackgroundView:[self getBackGroundView]];
    [self addSubview:m_TableView];
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.scrollBlock)
    {
        self.scrollBlock(nil, nil);
    }
}

- (void)setLoanProModel:(LoanproductModel *)loanProModel
{
    _loanProModel = loanProModel;
    [m_TableView reloadData];
    [m_TableView endRefresh];
}

- (void)setLoanProModelArr:(NSArray *)loanProModelArr
{
    _loanProModelArr = loanProModelArr;
    [m_TableView reloadData];
    [m_TableView endRefresh];
}

- (void)setRefreshBlock:(tableViewHeaderRefreshBlock)refreshBlock
{
    _refreshBlock = refreshBlock;
    m_TableView.refreshBlock = refreshBlock;
}

- (void)setLoadMoreBlock:(tableViewLoadMoreBlock)loadMoreBlock
{
    _loadMoreBlock = loadMoreBlock;
    m_TableView.loadMoreBlock = loadMoreBlock;
}

- (void)refreshTableView
{
    [m_TableView.mj_header beginRefreshing];
}

- (void)uploadTopButtonStatusWithType:(BOOL)typeOn Comp:(BOOL)comON Age:(BOOL)ageOn Screen:(BOOL)screenOn
{
    m_isSelectType = typeOn;
    m_isSelectCom = comON;
    m_isSelectAge = ageOn;
    m_isSelectScreen = screenOn;
    NSArray *titles = [self topTitlesArray];
    for (NSInteger i = 0; i < titles.count; i ++)
    {
        UILabel *lab = m_TopLabs[i];
        [lab setAttributedText:titles[i]];
    }
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    tableView.backgroundView = nil;
    NSInteger count = self.loanProModelArr.count;
    if (count == 0)
    {
        [tableView setBackgroundView:[self getBackGroundView]];
    }
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DIF_PX(1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    LoanTableViewCell *cell = [BaseTableViewCell cellClassName:@"LoanTableViewCell"
                                                   InTableView:nil
                                               forContenteMode:nil];
    height = cell.getCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootLoanDetailModel *model = [RootLoanDetailModel mj_objectWithKeyValues:self.loanProModelArr[indexPath.row]];
    LoanTableViewCell *cell = [BaseTableViewCell cellClassName:@"LoanTableViewCell"
                                                   InTableView:tableView
                                               forContenteMode:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectBlock)
    {
        RootLoanDetailModel *model = [RootLoanDetailModel mj_objectWithKeyValues:self.loanProModelArr[indexPath.row]];
        self.selectBlock(indexPath, model);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(1))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"")];
    return view;
}

@end
