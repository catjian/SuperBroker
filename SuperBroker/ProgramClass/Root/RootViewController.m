//
//  RootViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootViewController.h"
#import "RootBaseView.h"
#import "InsuranceDetailViewController.h"
#import "SpecialNewsDetailViewController.h"
#import "MessageDetailViewController.h"
#import "LoanDetailViewController.h"
#import "LoanViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
{
    RootBaseView *m_BaseView;
    NSArray *m_MovePictures;
    NSArray *m_NoticeListArr;
    NSArray *m_ArticleListArr;
    NSArray *m_InsuranceListArr;
    NSArray *m_LoanListArr;
    NSArray *m_LoanSpeciesList;
    RootNoticeListModel *m_NoticeListModel;
    RootMovePictureModel *m_MovePictureModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:DIF_Login_Status] == 1)
    {
        if (m_MovePictures.count == 0 && m_NoticeListArr.count == 0
            && m_ArticleListArr.count == 0 && m_InsuranceListArr.count == 0)
        {
            [CommonHUD showHUDWithMessage:@"获取首页数据中。。。"];
        }
        [self httpRequestIndexnNotice];
    }
}

- (void)viewDidLoad
{
    self.ShowBackButton = NO;
    [super viewDidLoad];
    [self setNavTarBarTitle:@"易普惠"];
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
            if (!indexPath)
            {
                return;
            }
            switch (indexPath.section)
            {
                case 0:
                {
                    switch (indexPath.row)
                    {
                        case 0:
                        {                            
                            [strongSelf loadViewController:@"LoanViewController" hidesBottomBarWhenPushed:NO];
                        }
                            break;
                        case 1:
                        {
                            [strongSelf loadViewController:@"InsuranceViewController" hidesBottomBarWhenPushed:NO];
                        }
                            break;
                        case 2:
                        {
                            [strongSelf loadViewController:@"CarInsuranceViewController" hidesBottomBarWhenPushed:NO];
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                case 1:
                {
                    LoanViewController *vc = [strongSelf loadViewController:@"LoanViewController" hidesBottomBarWhenPushed:NO];
                    vc.speciesId = [strongSelf->m_LoanSpeciesList[indexPath.row] objectForKey:@"speciesId"];
                }
                    break;
                case 2:
                {
                    RootLoanDetailModel *ipdModel = [RootLoanDetailModel mj_objectWithKeyValues:[model mj_keyValues]];
                    [strongSelf httpRequestLoanproductDetailWithListModel:ipdModel];
                }
                    break;
                case 3:
                {
                    InsuranceProductDetailModel *ipdModel = [InsuranceProductDetailModel mj_objectWithKeyValues:[model mj_keyValues]];
                    [strongSelf httpRequestInsuranceProductDetailWithListModel:ipdModel];
                }
                    break;
                case 4:
                {
                    ArticleListDetailModel *ipdModel = [ArticleListDetailModel mj_objectWithKeyValues:[model mj_keyValues]];
                    [strongSelf httpRequestArticleDetailWithDetailModel:ipdModel];
                }
                    break;
                case 9:
                {
                    [strongSelf httpRequestNoticeDetail:model];
                }
                default:
                    break;
            }
        }];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
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
//             [strongSelf httpRequestMovePicture];
             [self httpRequestRecommendRootAll];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

- (void)httpRequestNoticeDetail:(RootNoticeListModel *)detail
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMessageNoticeDetailWithParameters:@{@"noticeId":detail.noticeId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             MessageDetailViewController *vc = [strongSelf loadViewController:@"MessageDetailViewController" hidesBottomBarWhenPushed:NO];
             vc.detailModel = [MessageNoticeDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
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

- (void)httpRequestLoanproductDetailWithListModel:(RootLoanDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoanproductDetailWithParameters:@{@"prodId":model.productId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanDetailViewController *vc = [strongSelf loadViewController:@"LoanDetailViewController" hidesBottomBarWhenPushed:YES];
             vc.detailModel = [LoanProductDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             vc.listDetailModel = model;
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestInsuranceProductDetailWithListModel:(InsuranceProductDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceProductDetailWithParameters:@{@"prodId":model.prodId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             InsuranceDetailViewController *vc = [strongSelf loadViewController:@"InsuranceDetailViewController" hidesBottomBarWhenPushed:YES];
             vc.detailModel = [InsuranceProductDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             vc.productModel = model;
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestArticleDetailWithDetailModel:(ArticleListDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestArticleDetailWithParameters:@{@"articleId":model.articleId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             SpecialNewsDetailViewController *vc = [strongSelf loadViewController:@"SpecialNewsDetailViewController" hidesBottomBarWhenPushed:YES];
             vc.detailModel = [ArticleDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}


- (void)httpRequestRecommendRootAll
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestRecommendRootAllResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             NSDictionary *dataDic = responseModel[@"data"];
             strongSelf->m_ArticleListArr = dataDic[@"articleList"];
             strongSelf->m_BaseView.articleListArr = strongSelf->m_ArticleListArr;
             strongSelf->m_MovePictures = dataDic[@"movePictureList"];
             strongSelf->m_BaseView.movePictures = strongSelf->m_MovePictures;
             strongSelf->m_InsuranceListArr = dataDic[@"insuranceProdList"];
             strongSelf->m_BaseView.insuranceListArr = strongSelf->m_InsuranceListArr;
             strongSelf->m_LoanListArr = dataDic[@"loanProductList"];
             strongSelf->m_BaseView.loanListArr = strongSelf->m_LoanListArr;
             strongSelf->m_LoanSpeciesList = dataDic[@"loanSpeciesList"];
             strongSelf->m_BaseView.loanSpeciesList = strongSelf->m_LoanSpeciesList;
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
