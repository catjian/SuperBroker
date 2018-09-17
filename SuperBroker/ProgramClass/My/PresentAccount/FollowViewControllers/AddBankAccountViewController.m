//
//  AddBankAccountViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "AddBankAccountViewController.h"

@interface AddBankAccountViewController ()

@property (weak, nonatomic) IBOutlet UIButton *selectBankBtn;
@property (weak, nonatomic) IBOutlet UITextField *bankIDTF;
@end

@implementation AddBankAccountViewController
{
    NSArray *m_BankList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    [self setNavTarBarTitle:@"提现账户"];
    [self setRightItemWithContentName:@"完成"];
    [self.selectBankBtn setTitle:self.accountModel.bankName forState:UIControlStateNormal];
    [self.bankIDTF setText:self.accountModel.accountNo];
    [self httpRequestBankList];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    if (self.selectBankBtn.titleLabel.text.length <= 0)
    {
        [self.view makeToast:@"请选择银行" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![CommonVerify isBankCardId:self.bankIDTF.text])
    {
        [self.view makeToast:@"请输入正确的银行卡号" duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    if (!self.accountModel)
    {
        [DIF_CommonHttpAdapter
         httpRequestMyAcountAddBankCardWithParameters:@{@"accountNo":self.bankIDTF.text,
                                                        @"bankName":self.selectBankBtn.titleLabel.text}
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
        [DIF_CommonHttpAdapter
         httpRequestMyAcountEditBankCardWithParameters:@{@"accountNo":self.bankIDTF.text,
                                                         @"bankName":self.selectBankBtn.titleLabel.text,
                                                         @"withdrawalAccountId":self.accountModel.withdrawalAccountId}
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

- (IBAction)selectBankButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    NSMutableArray *bankNameArr = [NSMutableArray array];
    for (NSDictionary *dic in m_BankList)
    {
        [bankNameArr addObject:dic[@"dictName"]];
    }
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    __block CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:bankNameArr];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(NSDictionary *x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            [strongSelf.selectBankBtn setTitle:x[@"SuccessButtonEvent"][@"content"]
                                      forState:UIControlStateNormal];
        }
    }];
}

- (void)httpRequestBankList
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestBankListResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             strongSelf->m_BankList = responseModel[@"data"];
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
