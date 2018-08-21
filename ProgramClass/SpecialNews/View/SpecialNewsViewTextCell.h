//
//  SpecialNewsViewTextCell.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/19.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ArticleclassifyModel.h"

@interface SpecialNewsViewTextCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *company;

@end
