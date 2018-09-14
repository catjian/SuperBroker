//
//  InviteListBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "InviteListViewCell.h"

@interface InviteListBaseView : BaseTableView

@property(nonatomic, strong) InviteListModel *listModel;
@property (nonatomic, strong) NSArray *listArrModel;
@property (nonatomic, strong) NSString *noDataImageName;

@end
