//
//  IMContentShowView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "IMContentShowView.h"

@implementation IMContentShowView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        self.messageArray = [NSMutableArray array];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollBlock)
    {
        self.scrollBlock(self, self);
    }
}

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMContentModel *model = [IMContentModel mj_objectWithKeyValues:self.messageArray[indexPath.row]];
    if (model.type == ENUM_IM_CONTENT_TYPE_Send)
    {
        IMSendViewCell *cell = [IMSendViewCell cellClassName:@"IMSendViewCell"
                                                 InTableView:nil
                                             forContenteMode:model.contentStr];
        return cell.cellHeight;
    }
    else
    {
        IMReciveViewCell *cell = [IMReciveViewCell cellClassName:@"IMReciveViewCell"
                                                     InTableView:nil
                                                 forContenteMode:model.contentStr];
        return cell.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMContentModel *model = [IMContentModel mj_objectWithKeyValues:self.messageArray[indexPath.row]];
    if (model.type == ENUM_IM_CONTENT_TYPE_Send)
    {
        IMSendViewCell *cell = [IMSendViewCell cellClassName:@"IMSendViewCell"
                                                 InTableView:tableView
                                             forContenteMode:model.contentStr];
        return cell;
    }
    else
    {
        IMReciveViewCell *cell = [IMReciveViewCell cellClassName:@"IMReciveViewCell"
                                                     InTableView:tableView
                                                 forContenteMode:model.contentStr];
        return cell;
    }
}

@end
