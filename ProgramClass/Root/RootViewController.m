//
//  RootViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewController.h"
#import "RootBaseView.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    RootBaseView *m_BaseView;
    NSArray *m_MovePictures;
    NSArray *m_NoticeListArr;
    NSArray *m_ArticleListArr;
    NSArray *m_InsuranceListArr;
    RootNoticeListModel *m_NoticeListModel;
    RootMovePictureModel *m_MovePictureModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:DIF_Login_Status] == 1)
    {
        [CommonHUD showHUDWithMessage:@"获取首页数据中。。。"];
        [self httpRequestIndexnNotice];
    }
}

- (void)viewDidLoad
{
    self.ShowBackButton = NO;
    [super viewDidLoad];
    [self setNavTarBarTitle:@"易保金服"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[RootBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (indexPath.row == 0)
            {
                [strongSelf loadViewController:@"InsuranceViewController" hidesBottomBarWhenPushed:NO];
            }
            else
            {
                [strongSelf loadViewController:@"CarInsuranceViewController" hidesBottomBarWhenPushed:NO];
            }
        }];
    }
}

#pragma mark - Http Request

- (void)httpRequestIndexnNotice
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestIndexnNoticeResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_NoticeListArr = responseModel[@"data"];
             strongSelf->m_BaseView.noticeListArr = strongSelf->m_NoticeListArr;
             [strongSelf httpRequestMovePicture];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

- (void)httpRequestNoticeDetail
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestNoticeDetailWithParameters:@{}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

- (void)httpRequestMovePicture
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMovePictureResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_MovePictures = responseModel[@"data"];
             strongSelf->m_BaseView.movePictures = strongSelf->m_MovePictures;
             [strongSelf httpRequestRecommendArticle];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestRecommendArticle
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestRecommendArticleResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_ArticleListArr = responseModel[@"data"];
             strongSelf->m_BaseView.articleListArr = strongSelf->m_ArticleListArr;
             [strongSelf httpRequestRecommendInsurance];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestRecommendInsurance
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestRecommendInsuranceResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_InsuranceListArr = responseModel[@"data"];
             strongSelf->m_BaseView.insuranceListArr = strongSelf->m_InsuranceListArr;
             [CommonHUD hideHUD];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
