//
//  InsuranceBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceBaseView.h"
#import "InsuranceViewCellTableViewCell.h"

@implementation InsuranceBaseView
{
    BaseTableView *m_TableView;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createTopView];
        [self createTableView];
    }
    return self;
}

- (void)createTopView
{
    DIF_WeakSelf(self)
    CommonPageControlView *pageView = [[CommonPageControlView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(60))
                                                                            titles:@[@"保险种类 ↓",@"公司 ↓",@"年龄 ↓",@"筛选"]];
    [self addSubview:pageView];
    [pageView setSelectBlock:^(NSInteger index) {
        DIF_StrongSelf
        if (strongSelf.topSelectBlock)
        {
            strongSelf.topSelectBlock(index);
        }
    }];
}

- (void)createTableView
{
    m_TableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, DIF_PX(60), DIF_SCREEN_WIDTH, self.height-DIF_PX(60)) style:UITableViewStylePlain];
    [m_TableView setDelegate:self];
    [m_TableView setDataSource:self];
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
    InsuranceViewCellTableViewCell *cell = [BaseTableViewCell cellClassName:@"InsuranceViewCellTableViewCell" InTableView:tableView forContenteMode:nil];
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
