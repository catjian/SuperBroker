//
//  MyLoanBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "MyLoanViewCell.h"

@interface MyLoanBaseView : BaseTableView

@property(nonatomic, strong) MyloadListModel *listModel;
@property (nonatomic, strong) NSArray *listArrModel;
@property (nonatomic, strong) NSString *noDataImageName;

@end
