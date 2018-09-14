//
//  LoanScreenBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanScreenBaseView.h"

@interface LoanScreenBaseView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation LoanScreenBaseView

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
                                                CellClassName:@"LoanScreenBaseViewCell"];
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

- (void)setScreenDataArr:(NSArray *)screenDataArr
{
    _screenDataArr = screenDataArr;
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
        self.screenIdStr = nil;
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
    return self.screenDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CELLIDENTIFIER";
    LoanScreenBaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    LoanScreenModel *model = [LoanScreenModel mj_objectWithKeyValues:self.screenDataArr[indexPath.row]];
    [cell.titleLab setText:model.speciesName?model.speciesName:model.dictName];
    if (m_selectIndexPath.count == 0)
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
    if (self.screenIdStr &&
        [[self.screenIdStr componentsSeparatedByString:@","] indexOfObject:model.speciesId?model.speciesId:model.dictId] != NSNotFound)
    {
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"017aff")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"017aff").CGColor];
        [m_selectIndexPath addObject:indexPath];
    }
    return cell;
}

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSingle)
    {
        for (int i = 0; i < self.screenDataArr.count; i++)
        {
            LoanScreenBaseViewCell *cell = (LoanScreenBaseViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [m_selectIndexPath removeObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
            [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        }
    }
    else if (indexPath.row == 0)
    {
        for (int i = 0; i < self.screenDataArr.count; i++)
        {
            LoanScreenBaseViewCell *cell = (LoanScreenBaseViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            [m_selectIndexPath removeObject:[NSIndexPath indexPathForRow:i inSection:0]];
            [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
            [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        }
    }
    else
    {
        LoanScreenBaseViewCell *cell = (LoanScreenBaseViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [m_selectIndexPath removeObject:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.titleLab setTextColor:DIF_HEXCOLOR(@"#333333")];
        [cell.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
    }
    LoanScreenBaseViewCell *cell = (LoanScreenBaseViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
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
