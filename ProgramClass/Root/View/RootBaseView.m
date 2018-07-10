//
//  RootBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "RootBaseView.h"
#import "RootViewCell.h"

@interface RootBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation RootBaseView
{
    UILabel *m_NoticeLab;
    BaseCollectionView *m_ContentView;
    NSArray *m_ContentArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_ContentArr = @[@"保险",@"车险",@"信用卡",@"贷款",@"违章代缴",@"add"];
        UIView *topView = [self createTopView];
        [self createCollectionViewWithTopView:topView];
    }
    return self;
}

- (UILabel *)noticeLab
{
    if (!m_NoticeLab)
    {
        m_NoticeLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(12), self.width-DIF_PX(14*2), DIF_PX(18))];
        [m_NoticeLab setBackgroundColor:DIF_HEXCOLOR(@"")];
        [m_NoticeLab setFont:DIF_DIFONTOFSIZE(12)];
        [m_NoticeLab setTextColor:DIF_HEXCOLOR(@"4a4a4a")];
    }
    return m_NoticeLab;
}

- (void)refreshUserInfo
{
    if(m_NoticeLab)
    {
        [m_NoticeLab setText:[NSString stringWithFormat:@"姓名：%@   部门：%@  工号：%@",DIF_CommonCurrentUser.userName,DIF_CommonCurrentUser.wareaName,DIF_CommonCurrentUser.staffId]];
    }
}

- (UIView *)createTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, DIF_PX(40))];
    [topView setBackgroundColor:DIF_HEXCOLOR(@"")];
    [topView addSubview:[self noticeLab]];
    [self addSubview:topView];
    return topView;
}

- (void)createCollectionViewWithTopView:(UIView *)topView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, topView.bottom, self.width, self.height)
                                       ScrollDirection:UICollectionViewScrollDirectionVertical
                                                CellClassName:@"RootViewCell"];
    [m_ContentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return m_ContentArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    RootViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *contentTitle = m_ContentArr[indexPath.section][indexPath.row];
    [cell.titleLab setText:contentTitle];
    [cell.imageView setImage:[UIImage imageNamed:contentTitle]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        CommonADAutoView *adView;
        if ([reusableview viewWithTag:1000])
        {
            adView = (CommonADAutoView *)[reusableview viewWithTag:1000];
        }
        else
        {
            adView = [[CommonADAutoView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(150))];
            [adView setTag:1000];
            [reusableview addSubview:adView];
        }        
    }
    return reusableview;
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 1:
            break;
        default:
            [CommonAlertView showAlertViewOneBtnWithTitle:@"提示" Message:@"敬请期待！"
                                              ButtonTitle:nil];
            break;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(30))/3;
    return CGSizeMake(widht, DIF_PX(60));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(30), DIF_PX(0), DIF_PX(30));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(150));
}

@end
