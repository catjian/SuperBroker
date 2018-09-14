//
//  BuyMemeberViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemeberViewController.h"
#import "BuyMemberPayViewController.h"

@interface BuyMemeberViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *levelOneBackImage;
@property (weak, nonatomic) IBOutlet UILabel *levelOneMemberName;
@property (weak, nonatomic) IBOutlet UILabel *levelOneMemberAmount;
@property (weak, nonatomic) IBOutlet UITextView *levelOneBenefit;

@property (weak, nonatomic) IBOutlet UIImageView *levelTwoBackImage;
@property (weak, nonatomic) IBOutlet UILabel *levelTwoMemberName;
@property (weak, nonatomic) IBOutlet UILabel *levelTwoMemberAmount;
@property (weak, nonatomic) IBOutlet UITextView *levelTwoBenefit;

@property (weak, nonatomic) IBOutlet UIImageView *levelThrBackImage;
@property (weak, nonatomic) IBOutlet UILabel *levelThrMemberName;
@property (weak, nonatomic) IBOutlet UILabel *levelThrMemberAmount;
@property (weak, nonatomic) IBOutlet UITextView *levelThrBenefit;

@property (weak, nonatomic) IBOutlet UIImageView *levelFourBackImage;

@property (weak, nonatomic) IBOutlet UILabel *levelFourMemberName;
@property (weak, nonatomic) IBOutlet UILabel *levelFourMemberAmount;
@property (weak, nonatomic) IBOutlet UITextView *levelFourBenefit;

@end

@implementation BuyMemeberViewController
{
    NSArray *m_MemberLevel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self.levelOneMemberAmount setHidden:YES];
    [self.levelTwoMemberAmount setHidden:YES];
    [self.levelThrMemberAmount setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self httpRequestMemberLevel];
}

- (IBAction)buyMemeberButtonEvent:(UIButton *)sender
{
    BuyMemberPayViewController *vc = [self loadViewController:@"BuyMemberPayViewController"];
    vc.detailModel = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[sender.tag-1000]];
}

#pragma mark - Http Request

- (void)httpRequestMemberLevel
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMemberLevelResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             DIF_StrongSelf
             [strongSelf loadViewContentWithData:responseModel[@"data"]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)loadViewContentWithData:(NSArray *)data
{
    m_MemberLevel = data;
    if (m_MemberLevel.count > 0)
    {
        MemberLevelModel *levelOne = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[0]];
        NSString *strHtml = levelOne.businessBenefit;
        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
                                              documentAttributes:nil error:nil];
        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
        self.levelOneBenefit.attributedText = strAtt;
        [self.levelOneMemberName setText:levelOne.memberName];
        [self.levelOneMemberAmount setText:levelOne.memberAmount];
        [self.levelOneMemberAmount setHidden:NO];
//        [self.levelOneBackImage sd_setImageWithURL:[NSURL URLWithString:levelOne.titleUrl]
//                                  placeholderImage:[UIImage imageNamed:@"初级会员背景"]];
        [self.levelOneBackImage sd_setImageWithURL:[NSURL URLWithString:levelOne.titleUrl]];
        [self.levelOneBackImage.layer setCornerRadius:5];
        [self.levelOneBackImage.layer setMasksToBounds:YES];
    }
    if (m_MemberLevel.count > 1)
    {
        MemberLevelModel *levelTwo = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[1]];
        NSString *strHtml = levelTwo.businessBenefit;
        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
                                              documentAttributes:nil error:nil];
        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
        self.levelTwoBenefit.attributedText = strAtt;
        [self.levelTwoMemberName setText:levelTwo.memberName];
        [self.levelTwoMemberAmount setText:levelTwo.memberAmount];
        [self.levelTwoMemberAmount setHidden:NO];
//        [self.levelTwoBackImage sd_setImageWithURL:[NSURL URLWithString:levelTwo.titleUrl]
//                                  placeholderImage:[UIImage imageNamed:@"中级会员背景"]];
        [self.levelTwoBackImage sd_setImageWithURL:[NSURL URLWithString:levelTwo.titleUrl]];
        [self.levelTwoBackImage.layer setCornerRadius:5];
        [self.levelTwoBackImage.layer setMasksToBounds:YES];
    }
    if (m_MemberLevel.count > 2)
    {
        MemberLevelModel *levelThr = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[2]];
        NSString *strHtml = levelThr.businessBenefit;
        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
                                              documentAttributes:nil error:nil];
        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
        self.levelThrBenefit.attributedText = strAtt;
        [self.levelThrMemberName setText:levelThr.memberName];
        [self.levelThrMemberAmount setText:levelThr.memberAmount];
        [self.levelThrMemberAmount setHidden:NO];
//        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]
//                                  placeholderImage:[UIImage imageNamed:@"高级会员背景"]];
        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]];
        [self.levelThrBackImage.layer setCornerRadius:5];
        [self.levelThrBackImage.layer setMasksToBounds:YES];
    }
    if (m_MemberLevel.count > 3)
    {
        MemberLevelModel *levelFour = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[3]];
        NSString *strHtml = levelFour.businessBenefit;
        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
                                              documentAttributes:nil error:nil];
        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
        self.levelFourBenefit.attributedText = strAtt;
        [self.levelFourMemberName setText:levelFour.memberName];
        [self.levelFourMemberAmount setText:levelFour.memberAmount];
        [self.levelFourMemberAmount setHidden:NO];
        //        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]
        //                                  placeholderImage:[UIImage imageNamed:@"高级会员背景"]];
        [self.levelFourBackImage sd_setImageWithURL:[NSURL URLWithString:levelFour.titleUrl]];
        [self.levelFourBackImage.layer setCornerRadius:5];
        [self.levelFourBackImage.layer setMasksToBounds:YES];
    }
}
@end
