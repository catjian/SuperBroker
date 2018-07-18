//
//  InsturanceOrderCommitViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/18.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceOrderCommitViewController.h"
#import "CancelCommitOrderView.h"

@interface InsuranceOrderCommitViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *insIcon;
@property (weak, nonatomic) IBOutlet UILabel *insNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insDateLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredNameLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredCardIDLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredRelevanceLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredPhoneLab;
@property (weak, nonatomic) IBOutlet UILabel *insuredEmailLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *createDateLab;
@property (weak, nonatomic) IBOutlet UILabel *managerPhoneLab;


@end

@implementation InsuranceOrderCommitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"保险订单提交"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (IBAction)cancelOrderButtonEvent:(id)sender
{    
    CancelCommitOrderView *cancelView = [[CancelCommitOrderView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:cancelView];
    [cancelView show];
}
@end
