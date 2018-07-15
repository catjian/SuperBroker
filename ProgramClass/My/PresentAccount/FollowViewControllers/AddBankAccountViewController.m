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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    [self setNavTarBarTitle:@"提现账户"];
    [self setRightItemWithContentName:@"完成"];
}

- (IBAction)selectBankButtonEvent:(id)sender
{
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:@[@"招商银行",@"建设银行",@"工商银行"]];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
    }];
}

@end
