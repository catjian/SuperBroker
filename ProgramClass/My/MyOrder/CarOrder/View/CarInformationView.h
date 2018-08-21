//
//  CarInformationView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/28.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInformationView : UIView

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentFriLab;
@property (nonatomic, strong) UILabel *contentSecLab;
@property (nonatomic, strong) UILabel *contentThrLab;
@property (nonatomic, strong) UILabel *contentFourLab;

@property (nonatomic, strong) UIImageView *userCardImage;
@property (nonatomic, strong) UIImageView *driverCardImage;

@end
