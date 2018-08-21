//
//  InsuranceTypesViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceTypesViewController.h"
#import "InsuranceTypesBaseView.h"

@interface InsuranceTypesViewController ()

@end

@implementation InsuranceTypesViewController
{
    InsuranceTypesBaseView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavTarBarTitle:@"保险种类"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceTypesBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        [self httpRequestInsuranceSpecies];
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
                InsuranceSpeciesDetailModel *model = [InsuranceSpeciesDetailModel mj_objectWithKeyValues:strongSelf->m_BaseView.typeArr[indexPath.row]];
                [response addObject:model.speciesId];
            }
            if (strongSelf.block)
            {
                strongSelf.block(response);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    m_BaseView.speciesIdStr = self.speciesIdStr;
}

#pragma mark - Http Request

- (void)httpRequestInsuranceSpecies
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceSpeciesResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_BaseView.typeArr = responseModel[@"data"];
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
