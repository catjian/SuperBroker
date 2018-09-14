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
@property (weak, nonatomic) IBOutlet UILabel *charNumber;


@end

@implementation FeedBackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"意见反馈"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self.contentTV setPlaceholder:@"请输入详细内容描述"];
    [self.contentTV setPlaceColor:DIF_HEXCOLOR(@"CCCCCC")];
    [self.contentTV setMaxLength:240];
    [self.contentTV setRealTextColor:DIF_HEXCOLOR(@"333333")];
    [self.contentTV setChangeBlock:^(UITextView *textView, NSRange range, NSString *replacementText) {
        int inputLength = 240-textView.text.length-(replacementText.length>0?1:(-1));
        [self.charNumber setText:[NSString stringWithFormat:@"%d/240", inputLength]];
    }];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)commitButtonEvent:(id)sender
{
    if(self.titleLab.text.length < 1)
    {
        [self.view makeToast:@"请输入反馈内容标题"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.contentTV.text.length < 1)
    {
        [self.view makeToast:@"请输入详细内容描述"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestBrokerFeedBackWithParameters:@{@"feedbackTitle":self.titleLab.text,
                                               @"feedbackDesc":self.contentTV.text}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf loadViewController:@"FeedBackResponseViewController"];
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
