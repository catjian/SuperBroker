//
//  InsuranceInformationViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceInformationViewController.h"

@interface InsuranceInformationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNumTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;

@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UIButton *mateBtn;
@property (weak, nonatomic) IBOutlet UIButton *childBtn;
@property (weak, nonatomic) IBOutlet UIButton *parentBtn;
@property (weak, nonatomic) IBOutlet UIButton *relevanceBtn;

@end

@implementation InsuranceInformationViewController
{
    NSString *m_insuredRelation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"填写投保信息"];
    [self.myBtn.layer setBorderWidth:1];
    [self.myBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.myBtn.layer setCornerRadius:5];
    [self.mateBtn.layer setBorderWidth:1];
    [self.mateBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.mateBtn.layer setCornerRadius:5];
    [self.childBtn.layer setBorderWidth:1];
    [self.childBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.childBtn.layer setCornerRadius:5];
    [self.parentBtn.layer setBorderWidth:1];
    [self.parentBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.parentBtn.layer setCornerRadius:5];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)customServerButtonEvent:(id)sender
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)relevanceButtonsEvent:(UIButton *)sender
{
    [self.myBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [self.myBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.mateBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [self.mateBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.childBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [self.childBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [self.parentBtn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
    [self.parentBtn.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    
    [sender setTitleColor:DIF_HEXCOLOR(@"017aff") forState:UIControlStateNormal];
    [sender.layer setBorderColor:DIF_HEXCOLOR(@"017aff").CGColor];
    m_insuredRelation = sender.titleLabel.text;
    [self.relevanceBtn setTitle:m_insuredRelation forState:UIControlStateNormal];
}

- (IBAction)commitOrderButtonEvent:(id)sender
{
    [self httpRequestInsuranceProductDetail];
}

#pragma mark - Http Request

- (void)httpRequestInsuranceProductDetail
{
    if (self.nameTF.text.length < 2 )
    {
        [self.view makeToast:@"请输入真实姓名"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![CommonVerify isIdentityCard:self.cardNumTF.text])
    {
        [self.view makeToast:@"请输入证件号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (m_insuredRelation.length <= 0)
    {
        [self.view makeToast:@"请选择投保人关系"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.phoneTF.text.length <= 0 || ![CommonVerify isMobileNumber:self.phoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.emailTF.text.length > 0 && ![CommonVerify isValidateEmail:self.emailTF.text])
    {
        [self.view makeToast:@"请输入正确的邮箱地址"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    [parms setObject:self.detailModel.prodId forKey:@"prodId"];
    [parms setObject:self.nameTF.text forKey:@"insuredName"];
    [parms setObject:self.cardNumTF.text forKey:@"certificate"];
    [parms setObject:m_insuredRelation forKey:@"insuredRelation"];
    [parms setObject:self.phoneTF.text forKey:@"insuredPhone"];
    if (self.emailTF.text.length > 0)
    {
        [parms setObject:self.emailTF.text forKey:@"insuredEmail"];
    }
    [CommonHUD showHUDWithMessage:@"正在提交保险订单..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestInsuranceOrderWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             InsuranceCommitViewController *vc = [strongSelf loadViewController:@"InsuranceCommitViewController"];
             vc.detailModel = [InsuranceOrderDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             vc.customInfo = parms;
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
