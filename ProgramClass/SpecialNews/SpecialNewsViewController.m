//
//  SpecialNewsViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewController.h"
#import "SpecialNewsBaseView.h"

@interface SpecialNewsViewController ()<UITextFieldDelegate>

@end

@implementation SpecialNewsViewController
{
    SpecialNewsBaseView *m_BaseView;
    UIView *m_SearchView;
    UITextField *m_SearchTextField;
    NSArray *m_Articleclassify;
    ArticleListModel *m_listModel;
    ArticleclassifyModel *m_NowPageModel;
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
    [self setRightItemWithContentName:@" 搜索"];
    [self.navigationItem setLeftBarButtonItem:nil];
    [self createSearchView];
    [self.navigationItem setTitleView:m_SearchView];
    [self httpRequestArticleclassify];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[SpecialNewsBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setPageSelectBlock:^(NSInteger page) {
            DIF_StrongSelf
            strongSelf->m_NowPageModel = [ArticleclassifyModel mj_objectWithKeyValues:strongSelf->m_Articleclassify[page]];
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            if (strongSelf->m_Articleclassify.count > 0)
            {
                [strongSelf httpRequestWithClassifyId:strongSelf->m_NowPageModel.classifyId
                                        SearchContent:strongSelf->m_SearchTextField.text
                                           PageNumber:1];
            }
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            if (strongSelf->m_Articleclassify.count > 0)
            {
                [strongSelf httpRequestWithClassifyId:strongSelf->m_NowPageModel.classifyId
                                        SearchContent:strongSelf->m_SearchTextField.text
                                           PageNumber:page+1];
            }
        }];
    }
}

#pragma mark - Search Event Object

- (void)createSearchView
{
    m_SearchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width-90, 29)];
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
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"  保险不懂问这里"];
    [placeholder FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, placeholder.length)];
    [placeholder ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"cccccc") Range:NSMakeRange(0, placeholder.length)];
    [placeholder attatchImage:[UIImage imageNamed:@"搜索"]
                   imageFrame:CGRectMake(0, -(m_SearchTextField.height-18)/2, 18, 18)
                        Range:NSMakeRange(0, 0)];
    [m_SearchTextField setAttributedPlaceholder:placeholder];
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

#pragma mark - http Request

- (void)httpRequestArticleclassify
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestArticleclassifyResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_Articleclassify = responseModel[@"data"];
             [strongSelf->m_BaseView setClassifyArr:responseModel[@"data"]];
             strongSelf->m_NowPageModel = [ArticleclassifyModel mj_objectWithKeyValues:strongSelf->m_Articleclassify[0]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestWithClassifyId:(NSString *)classifyId
                    SearchContent:(NSString *)title
                       PageNumber:(NSInteger)pageNum
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestArticleListWithParameters:@{@"classifyId":classifyId,@"title":title,@"pageNum":[@(pageNum) stringValue]}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endloadEvent];
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             strongSelf->m_listModel = [ArticleListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if (pageNum == 1)
             {
                 [strongSelf->m_BaseView setListModel:@[strongSelf->m_listModel]];
             }
             else
             {
                 NSMutableArray *listModelArr = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.listModel];
                 [listModelArr addObject:strongSelf->m_listModel];
                 [strongSelf->m_BaseView setListModel:listModelArr];
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

@end
