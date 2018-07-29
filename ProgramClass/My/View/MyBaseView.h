//
//  MyBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrokerInfoDataModel.h"

typedef void(^MyBaseViewTopButtonEventBlock)(NSInteger tag);

@interface MyBaseView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, copy) MyBaseViewTopButtonEventBlock topBtnBlock;
@property (nonatomic, strong) BrokerInfoDataModel *brokerInfoModel;

@end
