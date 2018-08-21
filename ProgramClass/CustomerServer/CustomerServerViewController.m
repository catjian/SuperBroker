//
//  CustomerServerViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CustomerServerViewController.h"
#import "IMContentShowView.h"
#import "IMInpuerView.h"

@interface CustomerServerViewController ()

@end

@implementation CustomerServerViewController
{
    IMContentShowView *m_ContentView;
    IMInpuerView *m_InputView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    DIF_HideTabBarAnimation(NO);
    [self.navigationController setNavigationBarHidden:NO];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTarBarTitle:@"客服"];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self.view addSubview:line];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
    DIF_WeakSelf(self)
    [DIF_TIMManagerObject setRecBlock:^{
        DIF_StrongSelf
        for (int i = strongSelf->m_ContentView.messageArray.count; i < DIF_TIMManagerObject.IMContentArr.count; i++)
        {
            [strongSelf->m_ContentView.messageArray addObject:DIF_TIMManagerObject.IMContentArr[i]];
        }
        [strongSelf reloadShowView];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!m_ContentView)
    {
        m_ContentView = [[IMContentShowView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [m_ContentView setHeight:self.view.height-43];
        [self.view addSubview:m_ContentView];
        DIF_WeakSelf(self);
        [m_ContentView setScrollBlock:^(UITableView *tableView, UIScrollView *scrollView) {
            DIF_StrongSelf
            CGPoint point =  [scrollView.panGestureRecognizer translationInView:strongSelf.view];
            if (point.y > 0)
            {
                [strongSelf->m_InputView endEditing:YES];
                [strongSelf.view endEditing:YES];
                [strongSelf->m_InputView setTop:strongSelf.view.height-strongSelf->m_InputView.height];
                [strongSelf->m_ContentView setHeight:strongSelf.view.height-strongSelf->m_InputView.height];
                [strongSelf->m_ContentView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
        }];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [self.view addSubview:line];
        __block CGFloat startHeigt = 0;
        m_InputView = [[IMInpuerView alloc] initWithFrame:CGRectMake(0, self.view.height-43, self.view.width, 43)];
        [self.view addSubview:m_InputView];
        [m_InputView setChangeBlock:^{
            DIF_StrongSelf
            CGFloat top = startHeigt;
            top  -= strongSelf->m_InputView.height - 43;
            [strongSelf->m_InputView setTop:top];
            [strongSelf->m_ContentView setHeight:strongSelf->m_InputView.top];
            [strongSelf->m_ContentView setContentInset:UIEdgeInsetsMake(0, 0, 10, 0)];
        }];
        [m_InputView setSendBlock:^(NSString *message) {
            DIF_StrongSelf
            [DIF_TIMManagerObject sendMessageWithText:message];
            IMContentModel *model = [IMContentModel new];
            model.type = ENUM_IM_CONTENT_TYPE_Send;
            model.contentStr = message;
            [strongSelf->m_ContentView.messageArray addObject:[model mj_keyValues]];
            [strongSelf reloadShowView];
        }];
        [m_InputView setEditBlock:^(BOOL isStart, NSNotification* note) {
            DIF_StrongSelf
            if(isStart)
            {
                NSValue *keyboardInfo = note.userInfo[UIKeyboardFrameEndUserInfoKey];
                CGRect boardRect = [keyboardInfo CGRectValue];
                [strongSelf->m_InputView setTop:strongSelf.view.height-strongSelf->m_InputView.height-boardRect.size.height];
                [strongSelf->m_ContentView setHeight:strongSelf->m_InputView.top];
                [strongSelf->m_ContentView setContentInset:UIEdgeInsetsMake(0, 0, 10, 0)];
            }
            else
            {
                [strongSelf->m_ContentView setHeight:strongSelf.view.height-strongSelf->m_InputView.height];
                [strongSelf->m_InputView setTop:strongSelf.view.height-strongSelf->m_InputView.height];
                [strongSelf->m_ContentView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            }
            startHeigt = strongSelf->m_InputView.top;
        }];
        [m_ContentView.messageArray setArray:DIF_TIMManagerObject.IMContentArr];
        [self reloadShowView];
    }
}

- (void)reloadShowView
{
    [m_ContentView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    [m_ContentView layoutIfNeeded];
    if (m_ContentView.contentSize.height > m_ContentView.height)
    {
        IMContentModel *model = [IMContentModel mj_objectWithKeyValues:m_ContentView.messageArray.lastObject];
        CGFloat height = [[BaseTableViewCell cellClassName:@"IMSendViewCell"
                                               InTableView:nil
                                           forContenteMode:model.contentStr] cellHeight];
        CGFloat offsetY = m_ContentView.contentSize.height+height;
        [m_ContentView setContentOffset:CGPointMake(0, offsetY)];
    }
//    DIF_WeakSelf(self);
//    dispatch_after(3, dispatch_get_main_queue(), ^{
//        DIF_StrongSelf
//        if (strongSelf->m_ContentView.contentSize.height > strongSelf->m_ContentView.height)
//        {
//            IMContentModel *model = [IMContentModel mj_objectWithKeyValues:strongSelf->m_ContentView.messageArray.lastObject];
//            CGFloat height = [[BaseTableViewCell cellClassName:@"IMSendViewCell"
//                                                   InTableView:nil
//                                               forContenteMode:model.contentStr] cellHeight];
//            CGFloat offsetY = strongSelf->m_ContentView.contentSize.height+height;
//            [strongSelf->m_ContentView setContentOffset:CGPointMake(0, offsetY)
//                                               animated:NO];
//        }
//    });
}

#pragma mark - TIM 


@end
