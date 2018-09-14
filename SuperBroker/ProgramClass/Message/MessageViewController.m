//
//  MessageViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageBaseView.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
{    
    MessageBaseView *m_BaseView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_ShowTabBarAnimation(NO);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"消息"];
    self.navigationItem.leftBarButtonItem = nil;
//    [DIF_TabBar showBadgeNumberOnItemIndex:2 Number:2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!m_BaseView)
    {
        m_BaseView = [[MessageBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setPageSelectBlock:^(NSInteger page) {
            DIF_StrongSelf
        }];
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestNoticeListWithParameters:@{@"noticeType":strongSelf->m_BaseView.segmentIndex==0?@"62":@"63",
                                                              @"pageNum":@"1",@"pageSize":@"10"}];
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf httpRequestNoticeListWithParameters:@{@"noticeType":strongSelf->m_BaseView.segmentIndex==0?@"62":@"63",
                                                              @"pageNum":[@(page+1) stringValue],@"pageSize":@"10"}];
        }];
        [m_BaseView setSelectBlock:^(NSIndexPath *indexPath, MessageNoticeDetailModel *model) {
            DIF_StrongSelf
            [strongSelf httpRequestNoticeDetailWithDetailModel:model];
        }];
    }
}

#pragma mark - Http Request

- (void)httpRequestNoticeListWithParameters:(NSDictionary *)parms
{
    __block NSDictionary *weakParms = parms;
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
      httpRequestNoticeListWithParameters:parms
      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
          DIF_StrongSelf
          [strongSelf->m_BaseView endloadEvent];
          if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
          {
              if ([weakParms[@"noticeType"] integerValue] == 62)
              {
                  MessageNoticeListModel *list = [MessageNoticeListModel mj_objectWithKeyValues:responseModel[@"data"]];
                  if ([weakParms[@"pageNum"] integerValue] == 1)
                  {
                      strongSelf->m_BaseView.systemNoticeList = [NSMutableArray arrayWithArray:list.list];
                  }
                  else if (list.list.count > 0)
                  {
                      [strongSelf->m_BaseView.systemNoticeList addObjectsFromArray:list.list];
                  }
//                  [DIF_TabBar showBadgeNumberOnItemIndex:2
//                                                  Number:strongSelf->m_BaseView.systemNoticeList.count];
              }
              else
              {
                  MessageNoticeListModel *list = [MessageNoticeListModel mj_objectWithKeyValues:responseModel[@"data"]];
                  if ([weakParms[@"pageNum"] integerValue] == 1)
                  {
                      strongSelf->m_BaseView.wealthNoticeList = [NSMutableArray arrayWithArray:list.list];
                  }
                  else if (list.list.count > 0)
                  {
                      [strongSelf->m_BaseView.wealthNoticeList addObjectsFromArray:list.list];
                  }
              }
              [strongSelf->m_BaseView setNoDataImageName:@"无记录"];
              [strongSelf->m_BaseView reloadTableView];
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
              [strongSelf->m_BaseView reloadTableView];
              [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
          }
      } FailedBlcok:^(NSError *error) {
          DIF_StrongSelf
          if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
          {
              [strongSelf->m_BaseView setNoDataImageName:@"网络走丢了"];
              [strongSelf->m_BaseView reloadTableView];
          }
          if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
          {
              [strongSelf->m_BaseView setNoDataImageName:@"已超时"];
              [strongSelf->m_BaseView reloadTableView];
          }
          [strongSelf->m_BaseView endloadEvent];
          [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
      }];
}

- (void)httpRequestNoticeDetailWithDetailModel:(MessageNoticeDetailModel *)model
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
      httpRequestMessageNoticeDetailWithParameters:@{@"noticeId":model.noticeId}
      ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
          DIF_StrongSelf
          if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
          {
              [CommonHUD hideHUD];
              MessageDetailViewController *vc = [strongSelf loadViewController:@"MessageDetailViewController" hidesBottomBarWhenPushed:NO];
              vc.detailModel = [MessageNoticeDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
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
