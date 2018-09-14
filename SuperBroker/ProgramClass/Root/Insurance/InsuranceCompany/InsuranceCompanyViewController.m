//
//  InsuranceCompanyViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceCompanyViewController.h"
#import "InsuranceCompanyBaseView.h"

@interface InsuranceCompanyViewController ()

@end

@implementation InsuranceCompanyViewController
{
    InsuranceCompanyBaseView *m_BaseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"保险公司"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceCompanyBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        [self httpRequestInsuranceCompany];
        DIF_WeakSelf(self)
        [m_BaseView setBlock:^(NSArray *selectIndex) {
            DIF_StrongSelf
            if (!selectIndex)
            {
                if (strongSelf.block)
                {
                    strongSelf.block(nil);
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                return;
            }
            NSMutableArray *response = [NSMutableArray array];
            for (NSIndexPath *indexPath in selectIndex)
            {
                InsuranceCompanyModel *model = [InsuranceCompanyModel mj_objectWithKeyValues:strongSelf->m_BaseView.companyArr[indexPath.row]];
                [response addObject:model.compId];
            }
            if (strongSelf.block)
            {
                strongSelf.block(response);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    m_BaseView.compIdStr = self.compIdStr;
}

#pragma mark - Http Request

- (void)httpRequestInsuranceCompany
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceCompanyResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_BaseView.companyArr = responseModel[@"data"];
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
