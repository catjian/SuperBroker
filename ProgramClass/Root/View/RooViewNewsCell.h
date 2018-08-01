//
//  RooViewNewsCell.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootRecommnedArticleModel.h"

@interface RooViewNewsCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *detailLab;
@property (nonatomic, strong) UILabel *companyLab;
@property (nonatomic, strong) UILabel *readNumLab;

@end
