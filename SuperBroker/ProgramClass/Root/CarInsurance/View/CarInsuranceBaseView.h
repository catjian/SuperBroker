//
//  CarInsuranceBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BaseCollectionView.h"
#import "CarInsuranceViewCell.h"

@interface CarInsuranceBaseView : UIView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) collectionViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, strong) NSArray *productArr;

@end
