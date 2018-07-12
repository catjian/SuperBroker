//
//  MyBaseViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyBaseViewCell.h"

@implementation MyBaseViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.showLine = YES;
        [self setShowLineWidht:DIF_SCREEN_WIDTH-DIF_PX(80)];
    }
    return self;
}

@end
