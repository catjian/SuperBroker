//
//  MyOrderListViewCell.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyOrderInsuranceListModel.h"
#import "MyOrderCarListModel.h"
#import "InsuranceProductModel.h"

@interface MyOrderListViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, strong) UILabel *moneyLab;
@property (nonatomic, strong) UILabel *statusLab;

@end
