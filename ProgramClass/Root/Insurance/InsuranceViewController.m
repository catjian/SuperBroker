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
    [self setRightItemWithContentName:@"搜索"];
    [self createSearchView];
    [self.navigationItem setTitleView:m_SearchView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    m_BaseView = [[InsuranceBaseView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:m_BaseView];
    DIF_WeakSelf(self)
    [m_BaseView setTopSelectBlock:^(NSInteger index) {
        DIF_StrongSelf
        switch (index) {
            case 0:
                [strongSelf loadViewController:@"InsuranceTypesViewController"];
                break;
            case 1:
                [strongSelf loadViewController:@"InsuranceCompanyViewController"];
                break;
            default:
                [strongSelf loadViewController:@"InsuranceAgeViewController"];
                break;
        }
    }];
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self searchButtonEvent];
}

#pragma mark - Search Event Object

- (void)createSearchView
{
    m_SearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-60*3, self.navigationItem.titleView.height)];
    [m_SearchView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *backView = [[UIView alloc] initWithFrame:m_SearchView.frame];
    [backView setBackgroundColor:DIF_HEXCOLOR(@"f2f2f3")];
    [backView.layer setCornerRadius:self.navigationItem.titleView.height/2];
    [backView.layer setMasksToBounds:YES];
    [m_SearchView addSubview:backView];
    
    m_SearchTextField = [[UITextField alloc] initWithFrame:m_SearchView.frame];
    [m_SearchTextField setPlaceholder:@"🔍"];
    [m_SearchTextField setDelegate:self];
    [backView addSubview:m_SearchTextField];
    
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [m_SearchTextField setPlaceholder:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (m_SearchTextField.text.length == 0)
    {
        [m_SearchTextField setPlaceholder:@"🔍"];
    }
}

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
