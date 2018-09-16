//
//  BuyMemeberViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/14.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "BuyMemeberViewController.h"
#import "BuyMemberPayViewController.h"

@interface BuyMemeberViewController () <UITableViewDelegate, UITableViewDataSource>

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
    BaseTableView *m_BaseView;
    NSArray *m_MemberLevel;
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
    [self setNavTarBarTitle:@"开通会员"];
    [self setRightItemWithContentName:@"客服-黑"];
    [self.levelOneMemberAmount setHidden:YES];
    [self.levelTwoMemberAmount setHidden:YES];
    [self.levelThrMemberAmount setHidden:YES];
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self httpRequestMemberLevel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [m_BaseView setDelegate:self];
        [m_BaseView setDataSource:self];
        [m_BaseView setBackgroundColor:DIF_HEXCOLOR(nil)];
        [m_BaseView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:m_BaseView];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
        [lineView setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.view addSubview:lineView];
        if (m_MemberLevel.count * 180 > m_BaseView.height)
        {
            [m_BaseView setContentInset:UIEdgeInsetsMake(0, 0, 30, 0)];
        }
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
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
//             [strongSelf loadViewContentWithData:responseModel[@"data"]];
             strongSelf->m_MemberLevel = responseModel[@"data"];
             [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
             if (strongSelf->m_MemberLevel.count * 180 > strongSelf.view.height - Height_NavBar * 2)
             {
                 [strongSelf->m_BaseView setContentInset:UIEdgeInsetsMake(0, 0, 30, 0)];
             }
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
         
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

//- (void)loadViewContentWithData:(NSArray *)data
//{
//    m_MemberLevel = data;
//    if (m_MemberLevel.count > 0)
//    {
//        MemberLevelModel *levelOne = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[0]];
//        NSString *strHtml = levelOne.businessBenefit;
//        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
//                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
//                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
//                                              documentAttributes:nil error:nil];
//        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
//        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
//        self.levelOneBenefit.attributedText = strAtt;
//        [self.levelOneMemberName setText:levelOne.memberName];
//        [self.levelOneMemberAmount setText:levelOne.memberAmount];
//        [self.levelOneMemberAmount setHidden:NO];
////        [self.levelOneBackImage sd_setImageWithURL:[NSURL URLWithString:levelOne.titleUrl]
////                                  placeholderImage:[UIImage imageNamed:@"初级会员背景"]];
//        [self.levelOneBackImage sd_setImageWithURL:[NSURL URLWithString:levelOne.titleUrl]];
//        [self.levelOneBackImage.layer setCornerRadius:5];
//        [self.levelOneBackImage.layer setMasksToBounds:YES];
//    }
//    if (m_MemberLevel.count > 1)
//    {
//        MemberLevelModel *levelTwo = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[1]];
//        NSString *strHtml = levelTwo.businessBenefit;
//        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
//                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
//                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
//                                              documentAttributes:nil error:nil];
//        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
//        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
//        self.levelTwoBenefit.attributedText = strAtt;
//        [self.levelTwoMemberName setText:levelTwo.memberName];
//        [self.levelTwoMemberAmount setText:levelTwo.memberAmount];
//        [self.levelTwoMemberAmount setHidden:NO];
////        [self.levelTwoBackImage sd_setImageWithURL:[NSURL URLWithString:levelTwo.titleUrl]
////                                  placeholderImage:[UIImage imageNamed:@"中级会员背景"]];
//        [self.levelTwoBackImage sd_setImageWithURL:[NSURL URLWithString:levelTwo.titleUrl]];
//        [self.levelTwoBackImage.layer setCornerRadius:5];
//        [self.levelTwoBackImage.layer setMasksToBounds:YES];
//    }
//    if (m_MemberLevel.count > 2)
//    {
//        MemberLevelModel *levelThr = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[2]];
//        NSString *strHtml = levelThr.businessBenefit;
//        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
//                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
//                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
//                                              documentAttributes:nil error:nil];
//        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
//        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
//        self.levelThrBenefit.attributedText = strAtt;
//        [self.levelThrMemberName setText:levelThr.memberName];
//        [self.levelThrMemberAmount setText:levelThr.memberAmount];
//        [self.levelThrMemberAmount setHidden:NO];
////        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]
////                                  placeholderImage:[UIImage imageNamed:@"高级会员背景"]];
//        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]];
//        [self.levelThrBackImage.layer setCornerRadius:5];
//        [self.levelThrBackImage.layer setMasksToBounds:YES];
//    }
//    if (m_MemberLevel.count > 3)
//    {
//        MemberLevelModel *levelFour = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[3]];
//        NSString *strHtml = levelFour.businessBenefit;
//        NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc]
//                                              initWithData:[strHtml dataUsingEncoding:NSUnicodeStringEncoding]
//                                              options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType }
//                                              documentAttributes:nil error:nil];
//        [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(9) Range:NSMakeRange(0, strAtt.length)];
//        [strAtt ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"ffffff") Range:NSMakeRange(0, strAtt.length)];
//        self.levelFourBenefit.attributedText = strAtt;
//        [self.levelFourMemberName setText:levelFour.memberName];
//        [self.levelFourMemberAmount setText:levelFour.memberAmount];
//        [self.levelFourMemberAmount setHidden:NO];
//        //        [self.levelThrBackImage sd_setImageWithURL:[NSURL URLWithString:levelThr.titleUrl]
//        //                                  placeholderImage:[UIImage imageNamed:@"高级会员背景"]];
//        [self.levelFourBackImage sd_setImageWithURL:[NSURL URLWithString:levelFour.titleUrl]];
//        [self.levelFourBackImage.layer setCornerRadius:5];
//        [self.levelFourBackImage.layer setMasksToBounds:YES];
//    }
//}

#pragma mark - tableView delegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_MemberLevel.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 231, 127)];
        [imageView setBackgroundColor:DIF_HEXCOLOR(nil)];
        [imageView setCenterX:DIF_SCREEN_WIDTH/2];
        [imageView setTag:1001];
        [imageView.layer setCornerRadius:5];
        [imageView.layer setMasksToBounds:YES];
        [cell addSubview:imageView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"购买会员"] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(0, 180-23, 155, 23)];
        [btn setTag:1002];
        [btn setCenterX:DIF_SCREEN_WIDTH/2];
        [btn addTarget:self action:@selector(cellBuyMemberButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn];
        
        UILabel *memberNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, imageView.width, 20)];
        [memberNameLab setTag:1003];
        [memberNameLab setFont:DIF_UIFONTOFSIZE(15)];
        [memberNameLab setTextColor:DIF_HEXCOLOR(@"ffffff")];
        [memberNameLab setTextAlignment:NSTextAlignmentCenter];
        [imageView addSubview:memberNameLab];
        
        UILabel *memberAmountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, memberNameLab.bottom+30, imageView.width, 30)];
        [memberAmountLab setTag:1004];
        [memberAmountLab setFont:DIF_UIFONTOFSIZE(10)];
        [memberAmountLab setTextColor:DIF_HEXCOLOR(@"ffffff")];
        [memberAmountLab setTextAlignment:NSTextAlignmentCenter];
        [imageView addSubview:memberAmountLab];
    }
    
    MemberLevelModel *levelDetail = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[indexPath.row]];
    UIImageView *imageView = [cell viewWithTag:1001];
    UILabel *memberNameLab = [cell viewWithTag:1003];
    UILabel *memberAmountLab = [cell viewWithTag:1004];
    [imageView setImage:nil];
    [memberAmountLab setText:nil];
    [memberNameLab setText:nil];
    [imageView sd_setImageWithURL:[NSURL URLWithString:levelDetail.titleUrl]];
    [imageView.layer setCornerRadius:5];
    [imageView.layer setMasksToBounds:YES];
    [memberNameLab setText:levelDetail.memberName];
    NSMutableAttributedString * strAtt = [[NSMutableAttributedString alloc] initWithString:[levelDetail.memberAmount stringByAppendingString:@"元"]];
    [strAtt FontAttributeNameWithFont:DIF_UIFONTOFSIZE(28) Range:[strAtt.string rangeOfString:levelDetail.memberAmount]];
    [memberAmountLab setAttributedText:strAtt];
    
    return cell;
}

- (void)cellBuyMemberButtonEvent:(UIButton *)btn
{
    UITableViewCell *cell = (UITableViewCell *)btn.superview;
    NSIndexPath *indexPath = [m_BaseView indexPathForCell:cell];
    BuyMemberPayViewController *vc = [self loadViewController:@"BuyMemberPayViewController"];
    vc.detailModel = [MemberLevelModel mj_objectWithKeyValues:m_MemberLevel[indexPath.row]];
}

@end
