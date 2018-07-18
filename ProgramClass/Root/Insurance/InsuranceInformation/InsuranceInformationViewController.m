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

- (IBAction)customServerButtonEvent:(id)sender {
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
}

- (IBAction)commitOrderButtonEvent:(id)sender
{
    [self loadViewController:@"InsuranceOrderCommitViewController"];
}

@end
