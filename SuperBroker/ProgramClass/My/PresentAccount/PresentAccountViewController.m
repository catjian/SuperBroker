//
//  PresentAccountViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentAccountViewController.h"
#import "AddBankAccountViewController.h"

@interface PresentAccountViewController ()

@end

@implementation PresentAccountViewController
{
    PresentAccountModel *m_BaseViewModel;
    PresentAccountBaseView *m_BaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
    [self httpRequestGetAccount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    m_BaseViewModel = [PresentAccountModel new];
    [self setNavTarBarTitle:@"提现账户"];
    [self setRightItemWithContentName:@"完成"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[PresentAccountBaseView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        m_BaseView.objModel = m_BaseViewModel;
        [self.view addSubview:m_BaseView];
        
        DIF_WeakSelf(self);
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, id model) {
            DIF_StrongSelf
            if (indexPath.row == 1)
            {
                AddBankAccountViewController *vc = [strongSelf loadViewController:@"AddBankAccountViewController"];
                PresentAccountViewCell *cell = [strongSelf->m_BaseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                for(NSDictionary *dic in strongSelf->m_BaseViewModel.getAccountListNormal)
                {
                    PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:dic];
                    if (model.accountType.integerValue == 40)
                    {
                        vc.accountModel = model;
                        break;
                    }
                }
            }
        }];
    }
}

-(void)rightBarButtonItemAction:(UIButton *)btn
{
    PresentAccountViewCell *cell = [m_BaseView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell.contentStr.length <= 0)
    {
        [self.view makeToast:@"请输入支付宝账号" duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    if ([m_BaseViewModel.getAccountList.firstObject[@"content"] length] == 0)
    {
        [DIF_CommonHttpAdapter
         httpRequestMyAcountAddAlipayWithParameters:@{@"accountNo":cell.contentStr}
         ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
             if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
             {
                 [CommonHUD hideHUD];
                 DIF_StrongSelf
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
             }
             
         } FailedBlcok:^(NSError *error) {
             [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
         }];
    }
    else
    {
        PresentAccountModel *editModel;
        for (NSDictionary *dic in m_BaseViewModel.getAccountListNormal)
        {
            editModel = [PresentAccountModel mj_objectWithKeyValues:dic];
            if (editModel.accountType.integerValue == 41)
            {
                break;
            }
        }
        [DIF_CommonHttpAdapter
         httpRequestMyAcountEditAlipayWithParameters:@{@"accountNo":cell.contentStr,
                                                       @"withdrawalAccountId":editModel.withdrawalAccountId}
         ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
             if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
             {
                 [CommonHUD hideHUD];
                 DIF_StrongSelf
                 [strongSelf.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
             }
             
         } FailedBlcok:^(NSError *error) {
             [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
         }];
    }
}

#pragma mark - Http Request

- (void)httpRequestGetAccount
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyAllAccountListWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf->m_BaseViewModel setAccountList:responseModel[@"data"]];
             [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
