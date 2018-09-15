//
//  UserInfoViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "UserInfoViewController.h"
#import "EditPhoneViewController.h"

@interface UserInfoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idcardTF;
@property (weak, nonatomic) IBOutlet UIButton *phoneLab;
@property (weak, nonatomic) IBOutlet UIButton *sexyBtn;


@end

@implementation UserInfoViewController
{
    UIImage *m_UserIcon;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"个人信息"];
    [self setRightItemWithContentName:@"完成"];
    [self.nameTF setDelegate:self];
    [self.idcardTF setDelegate:self];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:self.brokerInfoModel.brokerPictureUrl] placeholderImage:[UIImage imageNamed:@"头像"]];
    [self.nameTF setText:self.brokerInfoModel.brokerName];
    [self.sexyBtn setTitle:self.brokerInfoModel.gender forState:UIControlStateNormal];
    [self.phoneLab setTitle:self.brokerInfoModel.brokerPhone forState:UIControlStateNormal];
    [self.idcardTF setText:self.brokerInfoModel.brokerIdentityCard];
}

- (void)setBrokerInfoModel:(BrokerInfoDataModel *)brokerInfoModel
{
    _brokerInfoModel = brokerInfoModel;
    [self.nameTF setText:brokerInfoModel.brokerName];
    [self.sexyBtn setTitle:brokerInfoModel.gender forState:UIControlStateNormal];
    [self.idcardTF setText:brokerInfoModel.brokerIdentityCard];
    [self.phoneLab setTitle:brokerInfoModel.brokerPhone forState:UIControlStateNormal];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    [CommonHUD showHUD];
    NSMutableDictionary *parms = [NSMutableDictionary dictionaryWithDictionary:@{@"brokerName":self.nameTF.text,
                                                                                 @"brokerIdentityCard":self.idcardTF.text,
                                                                                 @"gender":self.sexyBtn.titleLabel.text.length>0?self.sexyBtn.titleLabel.text:@""}];
    NSString *picUrl = [DIF_CommonHttpAdapter httpRequestUploadImageFile:self.userIcon.image ResponseBlock:nil FailedBlcok:nil];
    if (picUrl)
    {
        [parms setObject:picUrl forKey:@"brokerPictureUrl"];
    }
    if (self.idcardTF.text.length > 0 && [CommonVerify isIdentityCard:self.idcardTF.text])
    {
        [parms setObject:self.idcardTF.text forKey:@"brokerIdentityCard"];
    }
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestModifyBrokerinfoWithParameters:parms
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

#pragma mark - Button event

- (IBAction)uploadUserIconButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    DIF_WeakSelf(self)
    [[CommonPictureSelect sharedPictureSelect]
     showWithViewController:self
     ResponseBlock:^(UIImage *image) {
         DIF_StrongSelf
         if (image)
         {
             strongSelf->m_UserIcon = image;
             [self.userIcon setImage:image];
         }
     }];
}

- (IBAction)chooseSexButtonEvent:(UIButton *)sender
{
    [self.view endEditing:YES];
    DIF_WeakSelf(self)
    [[CommonSheetView alloc] initWithSheetTitle:@[@"男",@"女",@"取消"]
                                  ResponseBlock:^(NSInteger tag) {
                                      DIF_StrongSelf
                                      if (tag == 2)
                                      {
                                          return;
                                      }
                                      [strongSelf.sexyBtn setTitle:[@[@"男",@"女"] objectAtIndex:tag] forState:UIControlStateNormal];
                                  }];
}

- (IBAction)editPhoneButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    EditPhoneViewController *editVC = [self loadViewController:@"EditPhoneViewController"];
    editVC.phoneNum = self.phoneLab.titleLabel.text;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setNavTarBarTitle:@"个人信息修改"];
    [textField setTextAlignment:NSTextAlignmentLeft];
    [textField setTextColor:DIF_HEXCOLOR(@"000000")];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setNavTarBarTitle:@"个人信息"];
    [textField setTextAlignment:NSTextAlignmentRight];
    [textField setTextColor:DIF_HEXCOLOR(@"999999")];
}

@end
