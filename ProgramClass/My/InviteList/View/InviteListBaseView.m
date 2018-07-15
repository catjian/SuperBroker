//
//  InviteListBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InviteListBaseView.h"

@implementation InviteListBaseView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if(self)
    {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
