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


@end

@implementation UserInfoViewController

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
}

#pragma mark - Button event

- (IBAction)uploadUserIconButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [[CommonPictureSelect sharedPictureSelect] showWithViewController:self
                                                        ResponseBlock:^(UIImage *image) {
                                                        }];
}

- (IBAction)chooseSexButtonEvent:(UIButton *)sender
{    
    [[CommonSheetView alloc] initWithSheetTitle:@[@"男",@"女",@"取消"]
                                  ResponseBlock:^(NSInteger tag) {
                                      
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
