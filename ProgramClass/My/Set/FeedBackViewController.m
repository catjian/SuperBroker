//
//  FeedBackViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleLab;
@property (weak, nonatomic) IBOutlet PlaceTextView *contentTV;


@end

@implementation FeedBackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"设置"];
    [self setRightItemWithContentName:@"客服"];
    [self.contentTV setPlaceholder:@"请输入详细内容描述"];
    [self.contentTV setPlaceColor:DIF_HEXCOLOR(@"CCCCCC")];
    [self.contentTV setMaxLength:240];
    [self.contentTV setRealTextColor:DIF_HEXCOLOR(@"333333")];
}

- (IBAction)commitButtonEvent:(id)sender
{
    [self loadViewController:@"FeedBackResponseViewController"];
}

@end
