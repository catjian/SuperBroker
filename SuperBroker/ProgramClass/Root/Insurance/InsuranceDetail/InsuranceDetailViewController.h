//
//  InsuranceDetailViewController.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseViewController.h"
#import "InsuranceProductModel.h"

@interface InsuranceDetailViewController : BaseViewController

@property (nonatomic, strong) InsuranceProductDetailModel *detailModel;
@property (nonatomic, strong) InsuranceProductDetailModel *productModel;

@end
