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
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"无记录"]];
    [imageView setCenterX:self.width/2];
    [imageView setCenterY:DIF_PX(352/2)];
    [m_BGView addSubview:imageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+10, self.width, DIF_PX(20))];
    [lab setText:@"什么都没有"];
    [lab setTextColor:DIF_HEXCOLOR(@"d8d8d8")];
    [lab setFont:DIF_UIFONTOFSIZE(18)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    [m_BGView addSubview:lab];
    
    return m_BGView;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.backgroundView = nil;
    if (self.listModel.getInviteListData.count == 0)
    {
        [self setBackgroundView:[self getBackGroundView]];
    }
    return self.listModel.getInviteListData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InviteListViewCell *cell = [BaseTableViewCell cellClassName:@"InviteListViewCell"
                                                    InTableView:tableView
                                                forContenteMode:self.listModel.getInviteListData[indexPath.row]];
    return cell;
}

@end
