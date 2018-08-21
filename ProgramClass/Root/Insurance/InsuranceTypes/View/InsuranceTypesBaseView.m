//
//  InsuranceTypesBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/11.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "InsuranceTypesBaseView.h"

@interface InsuranceTypesBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation InsuranceTypesBaseView
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
        [self createTopSearchView];
        [self createCollectionView];
        [self createBottomButtonsView];
    }
    return self;
}

- (void)createTopSearchView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(42))];
    [topView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self addSubview:topView];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineT];
    
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, topView.height-1, DIF_SCREEN_WIDTH, 1)];
    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [topView addSubview:lineB];
    
    UITextField *searchTF = [[UITextField alloc] initWithFrame:CGRectMake(12, 7, topView.width-24, topView.height-14)];
    [topView addSubview:searchTF];
    [searchTF setFont:DIF_UIFONTOFSIZE(14)];
    [searchTF setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    [searchTF.layer setBorderWidth:1];
    [searchTF.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    [searchTF.layer setCornerRadius:5];
    
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"搜索"];
    [placeholder FontAttributeNameWithFont:DIF_UIFONTOFSIZE(14) Range:NSMakeRange(0, placeholder.length)];
    [placeholder ForegroundColorAttributeNamWithColor:DIF_HEXCOLOR(@"cccccc") Range:NSMakeRange(0, placeholder.length)];
    [placeholder attatchImage:[UIImage imageNamed:@"搜索"]
              imageFrame:CGRectMake(-5, -(searchTF.height-18)/2, 18, 18)
                   Range:NSMakeRange(0, 0)];
    [placeholder ParagraphStyleAttributeNameWithStyle:NSTextAlignmentCenter Range:NSMakeRange(0, placeholder.length)];
    [searchTF setAttributedPlaceholder:placeholder];
}

- (void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    m_ContentView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 42, self.width, self.height-50-42)
                                              ScrollDirection:UICollectionViewScrollDirectionVertical
                                                CellClassName:@"InsuranceTypesViewCell"];
//    [m_ContentView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self addSubview:m_ContentView];
    [m_ContentView setDelegate:self];
    [m_ContentView setDataSource:self];
    [m_ContentView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
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

- (void)setTypeArr:(NSArray *)typeArr
{
    _typeArr = typeArr;
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
        self.speciesIdStr = nil;
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
    return self.typeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    InsuranceTypesViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    InsuranceSpeciesDetailModel *model = [InsuranceSpeciesDetailModel mj_objectWithKeyValues:self.typeArr[indexPath.row]];
    [cell.titleLab setText:model.speciesName];
    if (m_selectIndexPath.count == 0)
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
    if (self.speciesIdStr &&
        [[self.speciesIdStr componentsSeparatedByString:@","] indexOfObject:model.speciesId] != NSNotFound)
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
////    if (kind == UICollectionElementKindSectionHeader)
////    {
////        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
////        UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(14), DIF_PX(16), DIF_PX(100), DIF_PX(24))];
////        [subTitle setTextColor:DIF_HEXCOLOR(@"#000000")];
////        [subTitle setFont:DIF_DIFONTOFSIZE(17)];
////        [reusableview addSubview:subTitle];
////        [subTitle setText:@"信息"];
////    }
//    return reusableview;
//}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    InsuranceTypesViewCell *cell = (InsuranceTypesViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
