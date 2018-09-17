//
//  SpecialNewsViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsViewController.h"
#import "SpecialNewsBaseView.h"
#import "SpecialNewsDetailViewController.h"

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
        [m_BaseView setScrollBlock:^(UITableView *tableView, UIScrollView *scrollView) {
            DIF_StrongSelf
            [strongSelf->m_SearchView endEditing:YES];
        }];
        [m_BaseView setPageSelectBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf->m_SearchView endEditing:YES];
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
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, ArticleListDetailModel *model) {
            DIF_StrongSelf
            [strongSelf httpRequestArticleDetailWithDetailModel:model];
        }];
    }
    else
    {
        [m_BaseView loadScrollView];
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
    [m_SearchTextField setClearButtonMode:UITextFieldViewModeUnlessEditing|UITextFieldViewModeWhileEditing];
    [backView addSubview:m_SearchTextField];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"  请输入文字关键字"];
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

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self.view endEditing:YES];
    [m_SearchTextField resignFirstResponder];
    if ([CommonVerify isContainsEmoji:m_SearchTextField.text])
    {
        [self.view makeToast:@"关键字不能包含表情"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    [self httpRequestWithClassifyId:m_NowPageModel.classifyId
                      SearchContent:m_SearchTextField.text
                         PageNumber:1];
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

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [m_SearchTextField resignFirstResponder];
    [self httpRequestWithClassifyId:m_NowPageModel.classifyId
                      SearchContent:@""
                         PageNumber:1];
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
     httpRequestArticleListWithParameters:@{@"classifyId":classifyId,@"title":title,@"pageNum":[@(pageNum) stringValue],@"pageSize":@"10"}
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
             else if (strongSelf->m_listModel.list.count > 0)
             {
                 NSMutableArray *listModelArr = [NSMutableArray arrayWithArray:strongSelf->m_BaseView.listModel];
                 [listModelArr addObject:strongSelf->m_listModel];
                 [strongSelf->m_BaseView setListModel:listModelArr];
             }
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
         }
         else
         {
             if ([responseModel[@"message"] rangeOfString:@"网络连接失败"].location != NSNotFound )
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             }
             else
             {
                 [strongSelf->m_BaseView setNoDataImageName:@"数据错误"];
             }
             [strongSelf->m_BaseView setListModel:nil];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView setListModel:nil];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView setListModel:nil];
         }
         [strongSelf->m_BaseView endloadEvent];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
    }];
}

- (void)httpRequestArticleDetailWithDetailModel:(ArticleListDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestArticleDetailWithParameters:@{@"articleId":model.articleId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             SpecialNewsDetailViewController *vc = [strongSelf loadViewController:@"SpecialNewsDetailViewController" hidesBottomBarWhenPushed:YES];
             vc.detailModel = [ArticleDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
             [strongSelf->m_BaseView loadScrollView];
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
