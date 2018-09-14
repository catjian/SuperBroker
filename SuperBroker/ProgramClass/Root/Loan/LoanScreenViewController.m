//
//  LoanScreenViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanScreenViewController.h"
#import "LoanScreenBaseView.h"

@interface LoanScreenViewController ()

@end

@implementation LoanScreenViewController
{
    LoanScreenBaseView *m_BaseView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[LoanScreenBaseView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:m_BaseView];
        DIF_WeakSelf(self)
        [m_BaseView setBlock:^(NSArray *selectIndex) {
            DIF_StrongSelf
            if (!selectIndex)
            {
                if (strongSelf.block)
                {
                    strongSelf.block(nil);
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
                return;
            }
            NSMutableArray *response = [NSMutableArray array];
            for (NSIndexPath *indexPath in selectIndex)
            {
                LoanScreenModel *model = [LoanScreenModel mj_objectWithKeyValues:strongSelf->m_BaseView.screenDataArr[indexPath.row]];
                [response addObject:model.speciesId?model.speciesId:model.dictId];
            }
            if (strongSelf.block)
            {
                strongSelf.block(response);
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    m_BaseView.screenIdStr = self.screenIdStr;
    m_BaseView.screenDataArr = self.screenDataArr;
    m_BaseView.isSingle = self.isSingle;
}



@end
