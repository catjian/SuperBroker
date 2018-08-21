//
//  IMContentShowView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableView.h"
#import "IMSendViewCell.h"
#import "IMReciveViewCell.h"


@interface IMContentShowView : BaseTableView

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *messageArray;

@end
