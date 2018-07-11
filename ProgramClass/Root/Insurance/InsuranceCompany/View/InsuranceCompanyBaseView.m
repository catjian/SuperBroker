//
//  InsuranceCompanyBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceCompanyBaseView.h"
#import "InsuranceCompanyViewCell.h"

@interface InsuranceCompanyBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation InsuranceCompanyBaseView
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
        m_ContentArr = @[@"保险",@"车险车险车险",@"信用卡",@"贷款"];
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
                                                CellClassName:@"InsuranceCompanyViewCell"];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
    [m_ContentView setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)createBottomButtonsView
{
    UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-50, self.width, 50)];
    [botView setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:botView];
    
    UIButton *successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [successBtn setFrame:CGRectMake(0, 5, 80, 40)];
    [successBtn setRight:10];
    [successBtn setTitle:@"确定" forState:UIControlStateNormal];
    [successBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [successBtn setBackgroundColor:[UIColor blueColor]];
    [botView addSubview:successBtn];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setFrame:CGRectMake(0, 5, 80, 40)];
    [cleanBtn setRight:successBtn.left-10];
    [cleanBtn setTitle:@"清空" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cleanBtn setBackgroundColor:[UIColor whiteColor]];
    [botView addSubview:cleanBtn];
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
    InsuranceCompanyViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *contentTitle = m_ContentArr[indexPath.row];
    [cell.titleLab setText:contentTitle];
    [cell setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    if (kind == UICollectionElementKindSectionHeader)
//    {
//        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(16), DIF_PX(100), DIF_PX(24))];
//        [subTitle setTextColor:DIF_HEXCOLOR(@"#000000")];
//        [subTitle setFont:DIF_DIFONTOFSIZE(17)];
//        [reusableview addSubview:subTitle];
//        [subTitle setText:@"信息"];
//    }
//    return reusableview;
//}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(30))/3;
    return CGSizeMake(widht, DIF_PX(30));
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
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(20));
}

@end
