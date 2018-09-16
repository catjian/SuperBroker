//
//  MyIncomeListViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/15.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MyIncomeListViewController.h"
#import "MyIncomeListBaseView.h"

@interface MyIncomeListViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *topStackView;
@property (weak, nonatomic) IBOutlet UIView *line1View;
@property (weak, nonatomic) IBOutlet UIView *lineSpaceView;
@property (weak, nonatomic) IBOutlet UIView *line2View;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *line3View;

@property (weak, nonatomic) IBOutlet UILabel *canUserNum;
@property (weak, nonatomic) IBOutlet UILabel *allIncomeNum;
@property (weak, nonatomic) IBOutlet UIView *contentBG;

@end

@implementation MyIncomeListViewController
{
    MyIncomeListBaseView *m_BaseView;
    NSMutableArray<MyIncomeListModel *> * m_ListModel;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
    [DIF_APPDELEGATE httpRequestMyBrokerAmount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"我的收益"];
    [self setRightItemWithContentName:@"客服-黑"];
    
    if(self.brokerInfoModel.brokerType.integerValue == 10)
    {
        [self setNavTarBarTitle:@"我的业绩"];
        [self.topStackView setHidden:YES];
        [self.line1View setTop:0];
        [self.lineSpaceView setTop:self.line1View.bottom];
        [self.line2View setTop:self.lineSpaceView.bottom];
        [self.titleView setTop:self.line2View.bottom];
        [self.line3View setTop:self.titleView.bottom];
        [self.titleLab setText:@"业绩明细"];
        [self.contentBG setTop:self.line3View.bottom];
    }
    
    NSString *income =  [DIF_APPDELEGATE.mybrokeramount[@"income"] stringValue];
    income = income?income:@"0";
    [self.canUserNum setText:[NSString stringWithFormat:@"%@", income]];
    
    NSString *incomeAll =  [DIF_APPDELEGATE.mybrokeramount[@"incomeAll"] stringValue];
    incomeAll = incomeAll?incomeAll:@"0";
    [self.allIncomeNum setText:[NSString stringWithFormat:@"%@", incomeAll]];
    
    m_ListModel = [NSMutableArray array];
    m_BaseView = [[MyIncomeListBaseView alloc] initWithFrame:self.contentBG.bounds style:UITableViewStylePlain];
    [m_BaseView setWidth:DIF_SCREEN_WIDTH];
    [self.contentBG addSubview:m_BaseView];
    DIF_WeakSelf(self)
    [m_BaseView setRefreshBlock:^{
        DIF_StrongSelf
        [strongSelf httpRequestGetWithDrawalListWithPage:1];
    }];
    [m_BaseView setLoadMoreBlock:^(NSInteger page) {
        DIF_StrongSelf
        [strongSelf httpRequestGetWithDrawalListWithPage:page+1];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.brokerInfoModel.brokerType.integerValue == 10)
    {
        [self setNavTarBarTitle:@"我的业绩"];
        [self.topStackView setHidden:YES];
        [self.line1View setTop:0];
        [self.lineSpaceView setTop:self.line1View.bottom];
        [self.line2View setTop:self.lineSpaceView.bottom];
        [self.titleView setTop:self.line2View.bottom];
        [self.line3View setTop:self.titleView.bottom];
        [self.titleLab setText:@"业绩明细"];
        [self.contentBG setTop:self.line3View.bottom];
        m_BaseView.height += 75;
    }
    else
    {
        NSString *income =  [DIF_APPDELEGATE.mybrokeramount[@"income"] stringValue];
        income = income?income:@"0";
        [self.canUserNum setText:[NSString stringWithFormat:@"%@", income]];
        
        NSString *incomeAll =  [DIF_APPDELEGATE.mybrokeramount[@"incomeAll"] stringValue];
        incomeAll = incomeAll?incomeAll:@"0";
        [self.allIncomeNum setText:[NSString stringWithFormat:@"%@", incomeAll]];
    }
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

#pragma mark - Http Request

- (void)httpRequestGetWithDrawalListWithPage:(NSInteger)page
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestMyBrokerIncomeListWithParameters:@{@"pageNum":[@(page) stringValue],@"pageSize":@"10"}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
             if (page == 1)
             {
                 [strongSelf->m_ListModel removeAllObjects];
                 [strongSelf->m_ListModel addObject:[MyIncomeListModel mj_objectWithKeyValues:responseModel[@"data"]]];
                 strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             }
             else
             {
                 MyIncomeListModel *listModel = [MyIncomeListModel mj_objectWithKeyValues:responseModel[@"data"]];
                 [strongSelf->m_ListModel addObject:listModel];
                 strongSelf->m_BaseView.listModel = strongSelf->m_ListModel;
             }
             [strongSelf->m_BaseView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
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
             [strongSelf->m_BaseView reloadData];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
             [strongSelf->m_BaseView reloadData];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
             [strongSelf->m_BaseView reloadData];
         }
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
