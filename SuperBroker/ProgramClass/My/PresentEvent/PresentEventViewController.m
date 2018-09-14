//
//  PresentEventViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/16.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "PresentEventViewController.h"

@interface PresentEventViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *accountIcon;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UITextField *MoneyTF;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLab;
@property (weak, nonatomic) IBOutlet UILabel *remarkLab;


@end

@implementation PresentEventViewController
{
    NSArray *m_AccountList;
    NSInteger m_selectAccount;
    NSDictionary *m_DrawalInfo;
    PresentDrawalRuleModel *m_RuleModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
    [self httpRequestGetDrawalInfo];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"我的提现"];
    [self setRightItemWithContentName:@"客服-黑"];
//    [self httpRequestGetAccount];
    m_selectAccount = 0;
//    [self.allMoneyLab setText:[NSString stringWithFormat:@"可用余额%.2f元",[DIF_APPDELEGATE.mybrokeramount[@"income"] floatValue]]];
//    [self.allMoneyLab setText:[NSString stringWithFormat:@"可用余额%@元",[DIF_APPDELEGATE.mybrokeramount[@"income"] stringValue]]];
//    [self.remarkLab setText:[NSString stringWithFormat:@"注：每天提现一次，最小提现金额为%.2f元；预计提交完成后2~3个工作日内到账",
//                             [DIF_APPDELEGATE.mybrokeramount[@"minWithdrawalAmount"] floatValue]]];
//    [self.remarkLab setText:[NSString stringWithFormat:@"注：每天提现一次，最小提现金额为%@元；预计提交完成后2~3个工作日内到账",
//                             [DIF_APPDELEGATE.mybrokeramount[@"minWithdrawalAmount"] stringValue]]];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

#pragma mark - Button Events
- (IBAction)selectAccountButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    NSMutableArray *titls = [NSMutableArray array];
    for (NSDictionary *dic in m_AccountList)
    {
        PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:dic];
        if ([model.bankName isEqualToString:@"支付宝"])
        {
            
            [titls addObject:[NSString stringWithFormat:@"%@ %@",model.bankName,model.accountNo]];
        }
        else
        {
            [titls addObject:[NSString stringWithFormat:@"%@（%@）",model.bankName,[model.accountNo substringFromIndex:model.accountNo.length>4?model.accountNo.length-4:0]]];
        }
    }
    if (titls.count == 0)
    {
        [self.view makeToast:@"请先新增提现账户" duration:2 position:CSToastPositionCenter];
        return;
    }
    [titls addObject:@"取消"];
    DIF_WeakSelf(self)
    [[CommonSheetView alloc] initWithSheetTitle:titls
                                  ResponseBlock:^(NSInteger tag) {
                                      DIF_StrongSelf
                                      if (tag != strongSelf->m_AccountList.count)
                                      {
                                          strongSelf->m_selectAccount = tag;
                                          PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:strongSelf->m_AccountList[tag]];
                                          [strongSelf.accountIcon setImage:[UIImage imageNamed:@"银联-86x86"]];
                                          if ([model.bankName isEqualToString:@"支付宝"])
                                          {
                                              [strongSelf.accountIcon setImage:[UIImage imageNamed:@"支付宝-86x86"]];
                                              [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@ %@",model.bankName,model.accountNo]
                                                                     forState:UIControlStateNormal];
                                          }
                                          else
                                          {
                                              [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@（%@）",model.bankName,[model.accountNo substringFromIndex:model.accountNo.length>4?model.accountNo.length-4:0]]
                                                                     forState:UIControlStateNormal];
                                          }
                                      }
    }];
}

- (IBAction)getAllMoneyButtonEvent:(id)sender
{
//    NSString *income = [(NSNumber *)DIF_APPDELEGATE.mybrokeramount[@"income"] stringValue];
    [self.MoneyTF setText:m_RuleModel.income];
}

- (IBAction)commitPresentButtnEvent:(id)sender
{
    [self httpRequestWithDrawalRequest];
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
             strongSelf->m_AccountList = responseModel[@"data"];
             if (strongSelf->m_AccountList.count > 0)
             {
                 PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:strongSelf->m_AccountList.firstObject];
                 [strongSelf.accountIcon setImage:[UIImage imageNamed:@"银联-86x86"]];
                 if ([model.bankName isEqualToString:@"支付宝"])
                 {
                     [strongSelf.accountIcon setImage:[UIImage imageNamed:@"支付宝-86x86"]];
                     [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@ %@",model.bankName,model.accountNo]
                                            forState:UIControlStateNormal];
                 }
                 else
                 {
                     [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@（%@）",model.bankName,[model.accountNo substringFromIndex:model.accountNo.length>4?model.accountNo.length-4:0]]
                                            forState:UIControlStateNormal];
                 }
             }
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestWithDrawalRequest
{
    if (m_AccountList.count == 0)
    {
        [self.view makeToast:@"请先设置提醒账户" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.MoneyTF.text.integerValue == 0)
    {
        [self.view makeToast:@"请输入提现金额" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.MoneyTF.text.floatValue < [m_RuleModel.minWithdrawalAmount floatValue])
    {
        [self.view makeToast:@"输入提现金额小于最小提现金额" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.MoneyTF.text.floatValue > [m_RuleModel.maxWithdrawalAmount floatValue])
    {
        [self.view makeToast:@"提现金额不能大于最大提现金额" duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:m_AccountList[m_selectAccount]];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestWithDrawalRequestWithParameters:@{@"payId":model.withdrawalAccountId,
                                                  @"withdrawalAmount":self.MoneyTF.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf loadViewController:@"PresentEventResponseViewController"];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestGetDrawalInfo
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestWithDrawalInfoWithResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             dispatch_async(dispatch_get_main_queue(), ^{
                 strongSelf->m_DrawalInfo = responseModel[@"data"];
                 strongSelf->m_AccountList = strongSelf->m_DrawalInfo[@"withdrawalAccountList"];
                 if (strongSelf->m_AccountList.count > 0)
                 {
                     PresentAccountModel *model = [PresentAccountModel mj_objectWithKeyValues:strongSelf->m_AccountList.firstObject];
                     [strongSelf.accountIcon setImage:[UIImage imageNamed:@"银联-86x86"]];
                     if ([model.bankName isEqualToString:@"支付宝"])
                     {
                         [strongSelf.accountIcon setImage:[UIImage imageNamed:@"支付宝-86x86"]];
                         [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@ %@",model.bankName,model.accountNo]
                                                forState:UIControlStateNormal];
                     }
                     else
                     {
                         [strongSelf.accountBtn setTitle:[NSString stringWithFormat:@"%@（%@）",model.bankName,[model.accountNo substringFromIndex:model.accountNo.length>4?model.accountNo.length-4:0]]
                                                forState:UIControlStateNormal];
                     }
                 }
                 strongSelf->m_RuleModel = [PresentDrawalRuleModel mj_objectWithKeyValues:strongSelf->m_DrawalInfo[@"withdrawalRule"]];
                 [strongSelf.allMoneyLab setText:[NSString stringWithFormat:@"可用余额%@元",strongSelf->m_RuleModel.income]];
                 [strongSelf.remarkLab setText:strongSelf->m_RuleModel.withdrawalDescription];
             });
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
