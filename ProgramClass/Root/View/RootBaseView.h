//
//  RootBaseView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewCell.h"
#import "RootViewHotCell.h"
#import "RooViewNewsCell.h"
#import "RootNoticeDetailModel.h"
#import "RootMovePictureModel.h"
#import "RootNoticeListModel.h"

@interface RootBaseView : UIView

@property (nonatomic, copy) tableViewSelectRowAtIndexPathBlock selectBlock;
@property (nonatomic, strong) NSArray *articleListArr;
@property (nonatomic, strong) NSArray *insuranceListArr;
@property (nonatomic, strong) NSArray *movePictures;
@property (nonatomic, strong) NSArray *noticeListArr;

@end
