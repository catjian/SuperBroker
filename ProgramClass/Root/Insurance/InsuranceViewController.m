//
//  InsuranceViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceViewController.h"
#import "InsuranceBaseView.h"

@interface InsuranceViewController ()<UITextFieldDelegate>

@end

@implementation InsuranceViewController
{
    InsuranceBaseView *m_BaseView;
    UITextField *m_SearchTextField;
    UIView *m_SearchView;
    InsuranceProductModel *m_DataModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(YES);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    DIF_ShowTabBarAnimation(YES);
    m_DataModel = [InsuranceProductModel new];
    [self setRightItemWithContentName:@" 搜索"];
    [self createSearchView];
    [self.navigationItem setTitleView:m_SearchView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[InsuranceBaseView alloc] initWithFrame:self.view.bounds];
        [m_BaseView setInsuranceDataArray:m_DataModel.getInsuranceProductModel];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self);
        [m_BaseView setScrollBlock:^(UITableView *tableView, UIScrollView *scrollView) {
            DIF_StrongSelf
            [strongSelf->m_SearchView endEditing:YES];
        }];
        [m_BaseView setTopSelectBlock:^(NSInteger index) {
            DIF_StrongSelf
            switch (index) {
                case 0:
                    [strongSelf loadViewController:@"InsuranceTypesViewController"];
                    break;
                case 1:
                    [strongSelf loadViewController:@"InsuranceCompanyViewController"];
                    break;
                case 2:
                    [strongSelf loadViewController:@"InsuranceAgeViewController"];
                    break;
                default:
                    [strongSelf loadViewController:@"ScreenViewController"];
                    break;
            }
        }];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self searchButtonEvent];
}

#pragma mark - Search Event Object

- (void)createSearchView
{
    CGFloat loseWidth = (is_iPhone5AndEarly?100:(is_iPhone6?110:120));
    m_SearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-loseWidth, 29)];
    [m_SearchView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *backView = [[UIView alloc] initWithFrame:m_SearchView.frame];
    [backView setBackgroundColor:DIF_HEXCOLOR(@"f2f2f3")];
    [backView.layer setCornerRadius:5];
    [backView.layer setMasksToBounds:YES];
    [m_SearchView addSubview:backView];
    
    m_SearchTextField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, backView.width-24, backView.height)];
    [m_SearchTextField setFont:DIF_UIFONTOFSIZE(14)];
    [m_SearchTextField setDelegate:self];
    [backView addSubview:m_SearchTextField];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@""];
    [placeholder FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, placeholder.length)];
    [placeholder ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"cccccc") Range:NSMakeRange(0, placeholder.length)];
    [placeholder attatchImage:[UIImage imageNamed:@"搜索"]
                   imageFrame:CGRectMake(0, -(m_SearchTextField.height-18)/2, 18, 18)
                        Range:NSMakeRange(0, 0)];
    [m_SearchTextField setAttributedPlaceholder:placeholder];
    
//    UIButton *cleanBtn = [CommonCommitButton commitButtonWithFrame:CGRectMake(0, 0, DIF_PX(30), DIF_PX(30)) Title:nil TitleColor:nil BackGroundColor:nil];
//    [cleanBtn setCenterY:m_SearchTextField.centerY];
//    [cleanBtn setRight:backView.width-DIF_PX(30)];
//    [cleanBtn addTarget:self action:@selector(cleanSearchText) forControlEvents:UIControlEventTouchUpInside];
//    [cleanBtn setImage:[UIImage imageNamed:@"TFClean"] forState:UIControlStateNormal];
//    [backView addSubview:cleanBtn];
}

- (void)cleanSearchText
{
    [m_SearchTextField setText:nil];
}

- (void)searchButtonEvent
{
    [self loadViewController:@"InsuranceDetailViewController" hidesBottomBarWhenPushed:YES];
    [self.view endEditing:YES];
    [m_SearchTextField resignFirstResponder];
    if ([CommonVerify isContainsEmoji:m_SearchTextField.text])
    {
        [self.view makeToast:@"关键字不能包含表情"
                    duration:1 position:CSToastPositionCenter];
        return;
    }
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *other = @"➋➌➍➎➏➐➑➒";     //九宫格的输入值
    if (string && [other rangeOfString:string].location == NSNotFound && ([string isEqualToString:@" "] || [CommonVerify isContainsEmoji:string]))
    {
        return NO;
    }
    if (!string || string.isNull)
    {
        if (textField.text.length == 1)
        {
        }
        return YES;
    }
    if (textField.text.length + string.length > 18)
    {
        return NO;
    }
    return YES;
}
@end
