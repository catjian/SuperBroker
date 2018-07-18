//
//  ScreenBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/17.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "ScreenBaseView.h"

@interface ScreenBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation ScreenBaseView
{
    UILabel *m_NoticeLab;
    BaseCollectionView *m_ContentView;
    NSArray<NSDictionary<NSString *,NSArray *> *>* m_ContentArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_ContentArr = @[@{@"排序":@[@"默认排序",@"时间排序"]},@{@"是否消费型":@[@"不限",@"消费型",@"返还型"]}];
        [self createCollectionView];
        [self createBottomButtonsView];
    }
    return self;
}

- (void)createCollectionView
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-50)
                                              ScrollDirection:UICollectionViewScrollDirectionVertical
                                                CellClassName:@"ScreehnBaseViewCell"];
    [m_ContentView registerClass:[UICollectionReusableView class]
      forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
             withReuseIdentifier:@"HeaderView"];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
    [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [self addSubview:lineT];
}

- (void)createBottomButtonsView
{
    UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-50, self.width, 50)];
    [botView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [self addSubview:botView];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [botView addSubview:lineT];
    
    UIButton *successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [successBtn setFrame:CGRectMake(0, 1, 132, 49)];
    [successBtn setRight:botView.width];
    [successBtn setImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    [botView addSubview:successBtn];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setFrame:CGRectMake(0, 1, 132, 49)];
    [cleanBtn setImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    [botView addSubview:cleanBtn];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return m_ContentArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary *dic = m_ContentArr[section];
    return [dic[dic.allKeys.firstObject] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    ScreehnBaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *dic = m_ContentArr[indexPath.section];
    NSArray *titles = dic[dic.allKeys.firstObject];
    NSString *contentTitle = titles[indexPath.row];
    [cell.titleLab setText:contentTitle];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader)
    {
        NSDictionary *dic = m_ContentArr[indexPath.section];
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                          withReuseIdentifier:@"HeaderView"
                                                                 forIndexPath:indexPath];
        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(10), DIF_PX(100), DIF_PX(13))];
        [subTitle setTextColor:DIF_HEXCOLOR(@"#999999")];
        [subTitle setFont:DIF_DIFONTOFSIZE(12)];
        [reusableview addSubview:subTitle];
        [subTitle setText:dic.allKeys.firstObject];
    }
    return reusableview;
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ScreehnBaseViewCell *cell = (ScreehnBaseViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.titleLab.textColor isEqual:DIF_HEXCOLOR(@"#333333")])
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"017aff")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"017aff").CGColor];
    }
    else
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(12))/3;
    return CGSizeMake(widht, DIF_PX(31));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(12), DIF_PX(0), DIF_PX(12));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(12);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return DIF_PX(10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(33));
}

@end

