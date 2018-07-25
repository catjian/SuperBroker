//
//  CarInsuranceBusinessViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceBusinessViewController.h"
#import "CarInsuranceBusinessBaseView.h"

@interface CarInsuranceBusinessViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation CarInsuranceBusinessViewController
{
    CarInsuranceBusinessBaseView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险服务"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[CarInsuranceBusinessBaseView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
    [self.contentView addSubview:m_BaseView];
}

- (IBAction)userServerButtonEvent:(id)sender
{
}

- (IBAction)commitButtonEvent:(id)sender
{
    [self loadViewController:@"CarInsuranceCommitViewController"];
}

@end
