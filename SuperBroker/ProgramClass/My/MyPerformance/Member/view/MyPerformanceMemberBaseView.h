//
//  MyPerformanceBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/6.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "MyPerformaceMemberViewCell.h"

@interface MyPerformanceMemberBaseView : BaseTableView

@property (nonatomic, strong) NSArray *listArrModel;
@property (nonatomic, strong) NSString *noDataImageName;

@end
