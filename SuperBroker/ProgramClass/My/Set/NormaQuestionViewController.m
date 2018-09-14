//
//  NormaQuestionViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/23.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "NormaQuestionViewController.h"
#import "RootRecommnedArticleModel.h"
#import "SpecialNewsDetailViewController.h"

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
    NSString *m_NoDataImageName;
    ArticleListModel *m_listModel;
    NSArray *m_listArrModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    [self setNavTarBarTitle:@"常见问题"];
    [self setRightItemWithContentName:@"客服-黑"];
    m_NoDataImageName = @"无记录";
}

- (void)rightBarButtonItemAction:(UIButton *)btn
{
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
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
        DIF_WeakSelf(self)
        [m_BaseView setRefreshBlock:^{
            DIF_StrongSelf
            [strongSelf httpRequestCommonProblemListWithParameters:@{@"pageNum":@"1",@"pageSize":@"10"}];
        }];
        [m_BaseView setLoadMoreBlock:^(NSInteger page) {
            DIF_StrongSelf
            [strongSelf httpRequestCommonProblemListWithParameters:@{@"pageNum":[@(page+1) stringValue],@"pageSize":@"10"}];
        }];
    }
}

- (UIView *)getBackGroundView
{
    UIView *m_BGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, m_BaseView.width, m_BaseView.height)];
    [m_BGView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:m_NoDataImageName]];
    [imageView setCenterX:m_BaseView.width/2];
    [imageView setCenterY:DIF_PX(352/2)];
    [m_BGView addSubview:imageView];
    
    NSDictionary *titleDic = @{@"无记录":@"什么都没有",
                               @"数据错误":@"数据错误，请下拉刷新",
                               @"网络走丢了":@"网络走丢了\n请检查您的网络或下拉刷新",
                               @"已超时":@"已超时，请下拉刷新"};
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom+10, m_BaseView.width, DIF_PX(20))];
    [lab setText:titleDic[m_NoDataImageName]];
    [lab setTextColor:DIF_HEXCOLOR(@"d8d8d8")];
    [lab setFont:DIF_UIFONTOFSIZE(18)];
    [lab setTextAlignment:NSTextAlignmentCenter];
    if ([m_NoDataImageName isEqualToString:@"网络走丢了"])
    {
        [lab setHeight:DIF_PX(50)];
        [lab setNumberOfLines:0];
        [lab setLineBreakMode:NSLineBreakByCharWrapping];
    }
    [m_BGView addSubview:lab];
    
    return m_BGView;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  m_listArrModel.count;
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
    NormaQuestionViewCell *cell = [BaseTableViewCell cellClassName:@"NormaQuestionViewCell" InTableView:tableView forContenteMode:nil];
    RootRecommnedArticleModel *contentModel = [RootRecommnedArticleModel mj_objectWithKeyValues:m_listArrModel[indexPath.row]];
    [cell.titleLab setText:contentModel.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RootRecommnedArticleModel *contentModel = [RootRecommnedArticleModel mj_objectWithKeyValues:m_listArrModel[indexPath.row]];
    [self httpRequestArticleDetailWithDetailModel:contentModel];
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


#pragma mark - Http Request

- (void)httpRequestCommonProblemListWithParameters:(NSDictionary *)parms
{
    __block NSDictionary *weakParms = parms;
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestCommonProblemListWithParameters:parms
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         [strongSelf->m_BaseView endRefresh];
         if (type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             strongSelf->m_NoDataImageName = @"无记录";
             strongSelf->m_listModel = [ArticleListModel mj_objectWithKeyValues:responseModel[@"data"]];
             if ([weakParms[@"pageNum"] integerValue] == 1)
             {
                 strongSelf->m_listArrModel = strongSelf->m_listModel.list;
             }
             else if (strongSelf->m_listModel.list.count > 0)
             {
                 NSMutableArray *nowList = [NSMutableArray arrayWithArray:strongSelf->m_listArrModel];
                 [nowList addObjectsFromArray:strongSelf->m_listModel.list];
                 strongSelf->m_listArrModel = nowList;
             }
             [strongSelf->m_BaseView reloadData];
         }
         else
         {
             if ([responseModel[@"message"] rangeOfString:@"网络连接失败"].location != NSNotFound )
             {
                 strongSelf->m_NoDataImageName = @"网络走丢了";
             }
             else
             {
                 strongSelf->m_NoDataImageName = @"数据错误";
             }
             [strongSelf->m_BaseView reloadData];
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         DIF_StrongSelf
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"offline"].location != NSNotFound)
         {
             strongSelf->m_NoDataImageName = @"网络走丢了";
             [strongSelf->m_BaseView reloadData];
         }
         if ([error.userInfo[NSLocalizedDescriptionKey] rangeOfString:@"timed out"].location != NSNotFound)
         {
             strongSelf->m_NoDataImageName = @"已超时";
             [strongSelf->m_BaseView reloadData];
         }
         [strongSelf->m_BaseView endRefresh];
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestArticleDetailWithDetailModel:(RootRecommnedArticleModel *)model
{
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestArticleDetailWithParameters:@{@"articleId":model.articleId}
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             SpecialNewsDetailViewController *vc = [strongSelf loadViewController:@"SpecialNewsDetailViewController" hidesBottomBarWhenPushed:YES];
             vc.detailModel = [ArticleDetailModel mj_objectWithKeyValues:responseModel[@"data"]];
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
