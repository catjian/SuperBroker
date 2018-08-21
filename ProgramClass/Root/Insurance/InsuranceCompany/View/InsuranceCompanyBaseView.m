//
//  InsuranceCompanyBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/12.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceCompanyBaseView.h"

@interface InsuranceCompanyBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation InsuranceCompanyBaseView
{
    UILabel *m_NoticeLab;
    BaseCollectionView *m_ContentView;
    NSMutableArray *m_selectIndexPath;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_selectIndexPath = [NSMutableArray array];
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
    [successBtn setTag:1001];
    [successBtn addTarget:self
                   action:@selector(bottomButtonsEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:successBtn];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn setFrame:CGRectMake(0, 1, 132, 49)];
    [cleanBtn setImage:[UIImage imageNamed:@"清空"] forState:UIControlStateNormal];
    [cleanBtn setTag:1002];
    [cleanBtn addTarget:self
                   action:@selector(bottomButtonsEvent:)
         forControlEvents:UIControlEventTouchUpInside];
    [botView addSubview:cleanBtn];
}

- (void)setCompanyArr:(NSArray *)companyArr
{
    _companyArr = companyArr;
    [m_ContentView reloadData];
}

- (void)bottomButtonsEvent:(UIButton *)btn
{
    if (btn.tag == 1001)
    {
        if (self.block)
        {
            self.block(m_selectIndexPath);
        }
    }
    else
    {
        if (self.block)
        {
            self.block(nil);
        }
        self.compIdStr = nil;
        [m_selectIndexPath removeAllObjects];
        [m_ContentView reloadData];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.companyArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    InsuranceCompanyViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    InsuranceCompanyModel *model = [InsuranceCompanyModel mj_objectWithKeyValues:self.companyArr[indexPath.row]];
    [cell.titleLab setText:model.fullName];
    if (m_selectIndexPath.count == 0)
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
    if (self.compIdStr &&
        [[self.compIdStr componentsSeparatedByString:@","] indexOfObject:model.compId] != NSNotFound)
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"017aff")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"017aff").CGColor];
        [m_selectIndexPath addObject:indexPath];
    }
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
    InsuranceCompanyViewCell *cell = (InsuranceCompanyViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.titleLab.textColor isEqual:DIF_HEXCOLOR(@"#333333")])
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"017aff")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"017aff").CGColor];
        [m_selectIndexPath addObject:indexPath];
    }
    else
    {
        [m_selectIndexPath removeObject:indexPath];
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
    return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(12));
}

@end
