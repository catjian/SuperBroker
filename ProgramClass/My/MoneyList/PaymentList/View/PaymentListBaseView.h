//
//  PaymentListBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "PaymentListBaseViewCell.h"

@interface PaymentListBaseView : BaseTableView

@property(nonatomic, strong) PaymentListModel *listModel;

@end
