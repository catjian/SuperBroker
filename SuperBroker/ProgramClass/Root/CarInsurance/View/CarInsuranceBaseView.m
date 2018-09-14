//
//  CarInsuranceBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceBaseView.h"

@implementation CarInsuranceBaseView
{
    BaseCollectionView *m_ContentView;
    NSArray *m_ContentArr;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createCollectionViewW];
    }
    return self;
}

- (void)createCollectionViewW
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)
                                              ScrollDirection:UICollectionViewScrollDirectionVertical
                                                CellClassName:@"CarInsuranceViewCell_CELLIDENTIFIER"];
    [m_ContentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self addSubview:m_ContentView];
    [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
}

- (void)setProductArr:(NSArray *)productArr
{
    _productArr = productArr;
    [m_ContentView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [m_ContentView registerClass:[CarInsuranceViewCell class] forCellWithReuseIdentifier:@"CarInsuranceViewCell_CELLIDENTIFIER"];
    static NSString *cellIdentifier = @"CarInsuranceViewCell_CELLIDENTIFIER";
    CarInsuranceViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    CarInsuranceListModel *model = [CarInsuranceListModel mj_objectWithKeyValues:self.productArr[indexPath.row]];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.productUrl] placeholderImage:nil];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        UIView *titleView = [reusableview viewWithTag:1000];
        if (!titleView)
        {
            titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(60))];
            [titleView setTag:1000];
            [titleView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
            [reusableview addSubview:titleView];
            
            UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, titleView.width, 1)];
            [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
            [titleView addSubview:lineT];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, DIF_SCREEN_WIDTH-24, 15)];
            [title setText:@"精选保险公司"];
            [title setFont:DIF_UIFONTOFSIZE(14)];
            [title setTextColor:DIF_HEXCOLOR(@"333333")];
            [titleView addSubview:title];
            
//            UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.height-1, titleView.width, 1)];
//            [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
//            [titleView addSubview:lineB];            
        }
    }
    return reusableview;
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectBlock)
    {
        CarInsuranceListModel *model = [CarInsuranceListModel mj_objectWithKeyValues:self.productArr[indexPath.row]];
        self.selectBlock(indexPath, model);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(12))/3;
    return CGSizeMake(widht, DIF_PX(63));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(12), DIF_PX(0), DIF_PX(12));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(16);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(60));
}

@end
