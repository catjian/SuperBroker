//
//  RootBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootBaseView.h"

@interface RootBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RootBaseView
{
    UIButton *m_NoticeBtn;
    UILabel *m_NoticeLab;
    BaseCollectionView *m_ContentView;
    NSArray *m_ContentArr;
    UIView *m_NoticeView;
    NSInteger m_noticeIndex;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_noticeIndex = 0;
        m_ContentArr = @[@"保险",@"车险",@"信用卡",@"违章代缴",@"贷款"];
        [self createCollectionViewW];
    }
    return self;
}

- (UIButton *)noticeLabWithleft:(CGFloat)left
{
    if (!m_NoticeBtn)
    {
        m_NoticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [m_NoticeBtn setFrame:CGRectMake(left+DIF_PX(10), 0, self.width-DIF_PX(14*2), DIF_PX(42))];
        [m_NoticeBtn setBackgroundColor:DIF_HEXCOLOR(@"")];
        [m_NoticeBtn setTitle:@"" forState:UIControlStateNormal];
        [m_NoticeBtn addTarget:self action:@selector(noticeButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        m_NoticeLab = [[UILabel alloc] initWithFrame:CGRectMake(left+DIF_PX(10), DIF_PX(12), self.width-DIF_PX(14*2), DIF_PX(42))];
        [m_NoticeLab setBackgroundColor:DIF_HEXCOLOR(@"")];
        [m_NoticeLab setFont:DIF_DIFONTOFSIZE(13)];
        [m_NoticeLab setTextColor:DIF_HEXCOLOR(@"333333") ];
        [m_NoticeLab setText:@"" ];
    }
    return m_NoticeBtn;
}

- (void)runNoticeLab
{
    [m_NoticeLab setAlpha:0];
    RootNoticeListModel *model = [RootNoticeListModel mj_objectWithKeyValues:self.noticeListArr[m_noticeIndex]];
    [m_NoticeLab setText:model.noticeTitle];
    m_noticeIndex = ++m_noticeIndex >= self.noticeListArr.count?0:m_noticeIndex;
    DIF_WeakSelf(self)
    [UIView animateWithDuration:2 animations:^{
        DIF_StrongSelf
        [strongSelf->m_NoticeLab setAlpha:1];
        [strongSelf->m_NoticeLab setTop:DIF_PX(0)];
    } completion:^(BOOL finished) {
        if (!finished)
        {
            return ;
        }
        [UIView animateWithDuration:2
                              delay:4
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             DIF_StrongSelf
                             [strongSelf->m_NoticeLab setAlpha:0];
                             [strongSelf->m_NoticeLab setTop:-DIF_PX(12)];
                         } completion:^(BOOL finished) {
                             DIF_StrongSelf
                             [strongSelf->m_NoticeLab setText:@""];
                             [strongSelf->m_NoticeLab setTop:DIF_PX(12)];
                             if (finished)
                             {
                                 [strongSelf runNoticeLab];
                             }
                         }];
    }];
}

-(void)noticeButtonEvent:(UIButton *)btn
{
    if (self.selectBlock && self.noticeListArr.count > 0)
    {
        RootNoticeListModel *model = [RootNoticeListModel mj_objectWithKeyValues:self.noticeListArr[m_noticeIndex]];
        self.selectBlock([NSIndexPath indexPathForRow:9 inSection:9], model);
    }
}

- (UIView *)createNoticeView
{
    if (!m_NoticeView)
    {
        m_NoticeView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(150), self.width, DIF_PX(42))];
        [m_NoticeView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [m_NoticeView setTag:999];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"消息喇叭"]];
        [imageView setLeft:DIF_PX(12)];
        [imageView setCenterY:m_NoticeView.height/2];
        [m_NoticeView addSubview:imageView];
        [m_NoticeView addSubview:[self noticeLabWithleft:imageView.right]];
        [m_NoticeView addSubview:m_NoticeLab];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, m_NoticeView.height-1, m_NoticeView.width, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [m_NoticeView addSubview:line];
    }
    
    return m_NoticeView;
}

- (void)createCollectionViewW
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)
                                       ScrollDirection:UICollectionViewScrollDirectionVertical
                                                CellClassName:@"RootViewCell"];
    [m_ContentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
}

- (void)setArticleListArr:(NSArray *)articleListArr
{
    _articleListArr = articleListArr;
    [m_ContentView reloadData];
}

- (void)setInsuranceListArr:(NSArray *)insuranceListArr
{
    _insuranceListArr = insuranceListArr;
    [m_ContentView reloadData];
}

- (void)setNoticeListArr:(NSArray *)noticeListArr
{
    _noticeListArr = noticeListArr;
}

- (void)setMovePictures:(NSArray *)movePictures
{
    _movePictures = movePictures;
    [m_ContentView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return m_ContentArr.count;
        case 1:
            return self.insuranceListArr.count;
        default:
            return self.articleListArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
            [m_ContentView registerClass:[RootViewCell class] forCellWithReuseIdentifier:@"RootViewCell_CELLIDENTIFIER"];
            static NSString *cellIdentifier = @"RootViewCell_CELLIDENTIFIER";
            RootViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            NSString *contentTitle = m_ContentArr[indexPath.row];
            [cell.titleLab setText:contentTitle];
            [cell.imageView setImage:[UIImage imageNamed:contentTitle]];
            return cell;
        }
        case 1:
        {
            [m_ContentView registerClass:[RootViewHotCell class] forCellWithReuseIdentifier:@"RootViewHotCell_CELLIDENTIFIER"];
            static NSString *cellIdentifier = @"RootViewHotCell_CELLIDENTIFIER";
            RootViewHotCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            RootRecommendInsuranceModel *model = [RootRecommendInsuranceModel mj_objectWithKeyValues:self.insuranceListArr[indexPath.row]];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.titlePictureUrl] placeholderImage:nil];
            [cell.titleLab setText:model.prodName];
            [cell.detailLab setText:model.details];
            [cell.moneyLab setText:[NSString stringWithFormat:@"推广奖励：%@元",model.promotionRewards]];
            return cell;
        }
        default:
        {
            RootRecommnedArticleModel *model = [RootRecommnedArticleModel mj_objectWithKeyValues:self.articleListArr[indexPath.row]];
            if (model.imgUrlList.count == 1)
            {
                [m_ContentView registerClass:[RooViewNewsCell class] forCellWithReuseIdentifier:@"RooViewNewsCell_CELLIDENTIFIER"];
                static NSString *cellIdentifier = @"RooViewNewsCell_CELLIDENTIFIER";
                RooViewNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
                [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
                [cell.titleLab setText:model.title];
                [cell.detailLab setText:model.summary];
                [cell.companyLab setText:model.author];
                [cell.readNumLab setText:[NSString stringWithFormat:@"%@阅读",model.hits]];
                return cell;
            }
            if (model.imgUrlList.count > 1)
            {
                [m_ContentView registerClass:[RooViewNewsMoreImageCell class] forCellWithReuseIdentifier:@"RooViewNewsMoreImageCell_CELLIDENTIFIER"];
                static NSString *cellIdentifier = @"RooViewNewsMoreImageCell_CELLIDENTIFIER";
                RooViewNewsMoreImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
                [cell.title setText:model.title];
                [cell.pic1 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[0]] placeholderImage:nil];
                [cell.pic2 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[1]] placeholderImage:nil];
                if (model.imgUrlList.count > 2)
                {
                    [cell.pic3 sd_setImageWithURL:[NSURL URLWithString:model.imgUrlList[2]] placeholderImage:nil];
                }
                [cell.company setText:[NSString stringWithFormat:@"%@阅读",model.hits]];
                return cell;
            }
            [m_ContentView registerClass:[RooViewNewsTextCell class] forCellWithReuseIdentifier:@"RooViewNewsTextCell_CELLIDENTIFIER"];
            static NSString *cellIdentifier = @"RooViewNewsTextCell_CELLIDENTIFIER";
            RooViewNewsTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            [cell.title setText:model.title];
            [cell.detail setText:model.summary];
            [cell.company setText:[NSString stringWithFormat:@"%@阅读",model.hits]];
            return cell;
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        switch (indexPath.section)
        {
            case 0:
            {
                for (int i = 0; i < 2; i++)
                {
                    if ([reusableview viewWithTag:1001+i])
                    {
                        [[reusableview viewWithTag:1001+i] removeFromSuperview];
                    }
                }
                CommonADAutoView *adView;
                if ([reusableview viewWithTag:1000])
                {
                    adView = (CommonADAutoView *)[reusableview viewWithTag:1000];
                    [adView removeFromSuperview];
                    adView = nil;
                }                
                adView = [[CommonADAutoView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(150))];
                [adView setTag:1000];
                [adView setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
                [reusableview addSubview:adView];
                [adView setSelectBlock:^(NSInteger page) {
                    if (self.selectBlock)
                    {
                        RootMovePictureModel *model = [RootMovePictureModel mj_objectWithKeyValues:self.movePictures[page]];
                        self.selectBlock(nil, model);
                    }
                }];
                NSMutableArray *picArr = [NSMutableArray array];
                for (NSDictionary *dic in self.movePictures)
                {
                    RootMovePictureModel *model = [RootMovePictureModel mj_objectWithKeyValues:dic];
                    [picArr addObject:model.pictureUrl];
                }
                adView.picArr = picArr;
                [m_NoticeView removeFromSuperview];
                [reusableview addSubview:[self createNoticeView]];
                if(self.noticeListArr.count > 0)
                {
                    [m_NoticeLab.layer removeAllAnimations];
                    [self runNoticeLab];
                }
            }
                break;
            default:
            {
                UIView *titleView;
                if ([reusableview viewWithTag:999])
                {
                    [[reusableview viewWithTag:999] removeFromSuperview];
                }
                if ([reusableview viewWithTag:1000])
                {
                    [[reusableview viewWithTag:1000] removeFromSuperview];
                }
                if ([reusableview viewWithTag:1000+(indexPath.section==1?2:1)])
                {
                    [[reusableview viewWithTag:1000+(indexPath.section==1?2:1)] removeFromSuperview];
                }
                if ([reusableview viewWithTag:1000+indexPath.section])
                {
                    titleView = [reusableview viewWithTag:1000+indexPath.section];
                }
                else
                {
                    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(60))];
                    [titleView setTag:1000+indexPath.section];
                    [titleView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
                    [reusableview addSubview:titleView];
                    
                    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleView.width, 1)];
                    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
                    [titleView addSubview:lineT];
                    
                    UIView *lineC = [[UIView alloc] initWithFrame:CGRectMake(0, 10, titleView.width, 1)];
                    [lineC setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
                    [titleView addSubview:lineC];
                    
                    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(10), DIF_SCREEN_WIDTH, DIF_PX(50))];
                    [contentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
                    [titleView addSubview:contentView];
                    
                    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, contentView.width-24, contentView.height)];
                    [title setText:(indexPath.section==1?@"热销推荐":@"精选头条")];
                    [title setFont:DIF_UIFONTOFSIZE(18)];
                    [title setTextColor:DIF_HEXCOLOR(@"333333")];
                    [contentView addSubview:title];
                    
                    UIImageView *right = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"更多箭头"]];
                    [right setRight:contentView.width-DIF_PX(12)];
                    [right setCenterY:contentView.height/2];
                    [contentView addSubview:right];
                    
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    [btn setFrame:CGRectMake(12, 0, right.left-22, contentView.height)];
                    [btn setTitle:@"更多" forState:UIControlStateNormal];
                    [btn setTitleColor:DIF_HEXCOLOR(@"999999") forState:UIControlStateNormal];
                    [btn.titleLabel setFont:DIF_UIFONTOFSIZE(15)];
                    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
                    [btn addTarget:self action:@selector(headerViewMoreButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
                    [contentView addSubview:btn];
                    
                    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.height-1, titleView.width, 1)];
                    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
                    [titleView addSubview:lineB];
                    
                }
            }
        }
    }
    return reusableview;
}

- (void)headerViewMoreButtonEvent:(UIButton *)btn
{
    UIView *titleView = btn.superview.superview;
    if (titleView.tag - 1000 == 2)
    {
        [DIF_TabBar setSelectedIndex:1];
    }
    if (titleView.tag -1000 == 1)
    {
        if (self.selectBlock)
        {
            self.selectBlock([NSIndexPath indexPathForRow:0 inSection:0], nil);
        }
    }
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
            case 1:
            {
                if (self.selectBlock)
                {
                    self.selectBlock(indexPath, nil);
                }
            }
                break;
            default:
                [CommonAlertView showAlertViewOneBtnWithTitle:@"温馨提示"
                                                      Message:@"功能还未开通\n敬请期待！"
                                                  ButtonTitle:nil];
                break;
        }
    }
    else
    {
        if (self.selectBlock)
        {
            if (indexPath.section == 1)
            {
                RootRecommendInsuranceModel *model = [RootRecommendInsuranceModel mj_objectWithKeyValues:self.insuranceListArr[indexPath.row]];
                self.selectBlock(indexPath, model);
            }
            else
            {
                RootRecommnedArticleModel *model = [RootRecommnedArticleModel mj_objectWithKeyValues:self.articleListArr[indexPath.row]];
                self.selectBlock(indexPath, model);                
            }
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section)
    {
        case 0:
        {
//            CGFloat widht = (DIF_SCREEN_WIDTH-6*DIF_PX(12))/5;
            CGFloat widht = (DIF_SCREEN_WIDTH)/5;
            return CGSizeMake(widht, DIF_PX(109));
        }
        case 1:
        {
            CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(12))/2;
            return CGSizeMake(widht, DIF_PX(190));
        }
        default:
        {
            RootRecommnedArticleModel *model = [RootRecommnedArticleModel mj_objectWithKeyValues:self.articleListArr[indexPath.row]];
            if (model.imgUrlList.count > 1)
            {
                return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(140));
            }
            if (model.imgUrlList.count == 0)
            {
                return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(145));
            }
            return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(95));
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(0), DIF_PX(20), DIF_PX(0));
        case 1:
            return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(12), DIF_PX(0), DIF_PX(12));
        default:
            return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(0), DIF_PX(0), DIF_PX(0));
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(192));
        default:
            return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(60));
    }
}

@end
