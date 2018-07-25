//
//  NormaQuestionViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NormaQuestionViewController.h"

@interface NormaQuestionViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation NormaQuestionViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        self.cellHeight = 51;
        UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右括号"]];
        [rightImg setRight:DIF_SCREEN_WIDTH-12];
        [rightImg setCenterY:25];
        [self.contentView addSubview:rightImg];
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(12, 12, DIF_SCREEN_WIDTH-24, self.cellHeight-24)];
        [self.titleLab setFont:DIF_UIFONTOFSIZE(15)];
        [self.titleLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [self.contentView addSubview:self.titleLab];
        
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
    }
    return self;
}

@end

@interface NormaQuestionViewController ()

@end

@implementation NormaQuestionViewController
{
    BaseTableView *m_BaseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    [self setNavTarBarTitle:@"常见问题"];
    [self setRightItemWithContentName:@"客服-黑"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!m_BaseView)
    {
        m_BaseView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [m_BaseView setDelegate:self];
        [m_BaseView setDataSource:self];
        [m_BaseView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:m_BaseView];
    }
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DIF_PX(51);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormaQuestionViewCell *cell = [BaseTableViewCell cellClassName:@"" InTableView:tableView forContenteMode:nil];    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 12)];
    [view setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:lineT];
    
    UIView *lintB = [[UIView alloc] initWithFrame:CGRectMake(0, 11, DIF_SCREEN_WIDTH, 1)];
    [lintB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:lintB];
    
    return view;
}

@end
