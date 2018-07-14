//
//  MyViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyViewController.h"
#import "MyBaseView.h"
#import "UserInfoViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
{
    MyBaseView *m_BaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[MyBaseView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:m_BaseView];
    DIF_WeakSelf(self);
    [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
        DIF_StrongSelf
        NSInteger index = indexPath.section*10+indexPath.row;
        switch (index)
        {
            case 0:
                break;
            case 10:
                [strongSelf loadViewController:@"UserInfoViewController" hidesBottomBarWhenPushed:YES];
                break;
            case 11:
                break;
            case 12:
                break;
            case 13:
                break;
            case 21:
                break;
            default:
                break;
        }
    }];
}

@end
