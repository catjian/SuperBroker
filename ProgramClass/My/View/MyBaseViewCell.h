//
//  MyBaseViewCell.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef void(^MyBaseViewCellCopyBlock)(void);

@interface MyBaseViewCell : BaseTableViewCell

@property (nonatomic, copy) MyBaseViewCellCopyBlock copyBlock;

@end
