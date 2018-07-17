//
//  InsuranceBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceBaseView.h"

@implementation InsuranceBaseView
{
    BaseTableView *m_TableView;
    NSMutableArray<UILabel *> *m_TopLabs;
    BOOL m_isSelectType;
    BOOL m_isSelectCom;
    BOOL m_isSelectAge;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_isSelectType = NO;
        m_isSelectCom = NO;
        m_isSelectAge = NO;
        [self createTopView];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(42), DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self addSubview:line];
        [self createTableView];
    }
    return self;
}

- (NSArray *)topTitlesArray
{
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"保险种类"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectType?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectType?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"公司"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectCom?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectCom?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"年龄"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
    [title ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(!m_isSelectAge?@"333333":@"017aff") Range:NSMakeRange(0, title.length)];
    [title attatchImage:[UIImage imageNamed:m_isSelectAge?@"三角形-选中":@"三角形-未选中"]
             imageFrame:CGRectMake(5, 2, 7, 5)
                  Range:NSMakeRange(0, title.length)];
    [titles addObject:title];
    title = [[NSMutableAttributedString alloc] initWithString:@"筛选"];
    [title FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, title.length)];
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
        label.font = DIF_DIFONTOFSIZE(28);
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
        default:
            m_isSelectAge = !m_isSelectAge;
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
    [self addSubview:m_TableView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.scrollBlock)
    {
        self.scrollBlock(nil, nil);
    }
}

#pragma mark - UITalbeView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.insuranceDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DIF_PX(1);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    InsuranceViewCellTableViewCell *cell = [BaseTableViewCell cellClassName:@"InsuranceViewCellTableViewCell"
                                                                InTableView:nil
                                                            forContenteMode:nil];
    height = cell.getCellHeight;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceViewCellTableViewCell *cell = [BaseTableViewCell cellClassName:@"InsuranceViewCellTableViewCell"
                                                                InTableView:tableView
                                                            forContenteMode:self.insuranceDataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(1))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"")];
    return view;
}


@end
