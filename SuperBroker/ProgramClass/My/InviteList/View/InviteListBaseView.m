//
//  InviteListBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InviteListBaseView.h"

@implementation InviteListBaseView
{
    UIView *m_BGView;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        self.noDataImageName = @"无记录";
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [self setBackgroundView:[self getBackGroundView]];
    }
    return self;
}

- (UIView *)getBackGroundView
{
    if (m_BGView)
    {
        return m_BGView;
    }
    m_BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
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

- (void)setListModel:(InviteListModel *)listModel
{
    _listModel = listModel;
    [self reloadData];
}

- (void)setListArrModel:(NSArray *)listArrModel
{
    _listArrModel = listArrModel;
    [self reloadData];
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.backgroundView = nil;
//    if (self.listModel.getInviteListData.count == 0)
//    {
//        [self setBackgroundView:[self getBackGroundView]];
//    }
    if ([InviteListModel getInviteListDataWithList:self.listArrModel] == 0) {
        [self setBackgroundView:[self getBackGroundView]];
    }
    return [InviteListModel getInviteListDataWithList:self.listArrModel].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteListViewCell *cell = [BaseTableViewCell cellClassName:@"InviteListViewCell"
                                                    InTableView:tableView
                                                forContenteMode:[InviteListModel getInviteListDataWithList:self.listArrModel][indexPath.row]];
    return cell;
}

@end
