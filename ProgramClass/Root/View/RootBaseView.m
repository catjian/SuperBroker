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
    UILabel *m_NoticeLab;
    BaseCollectionView *m_ContentView;
    NSArray *m_ContentArr;
    UIView *m_NoticeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        m_ContentArr = @[@"保险",@"车险",@"信用卡",@"贷款",@"违章代缴",@"更多"];
        [self createCollectionViewW];
    }
    return self;
}

- (UILabel *)noticeLabWithleft:(CGFloat)left
{
    if (!m_NoticeLab)
    {
        m_NoticeLab = [[UILabel alloc] initWithFrame:CGRectMake(left+DIF_PX(10), DIF_PX(12), self.width-DIF_PX(14*2), DIF_PX(18))];
        [m_NoticeLab setBackgroundColor:DIF_HEXCOLOR(@"")];
        [m_NoticeLab setFont:DIF_DIFONTOFSIZE(13)];
        [m_NoticeLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_NoticeLab setText:@"消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭消息喇叭"];
    }
    return m_NoticeLab;
}

- (UIView *)createNoticeView
{
    if (!m_NoticeView)
    {
        m_NoticeView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_PX(150), self.width, DIF_PX(42))];
        [m_NoticeView setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"消息喇叭"]];
        [imageView setLeft:DIF_PX(12)];
        [imageView setCenterY:m_NoticeView.height/2];
        [m_NoticeView addSubview:imageView];
        [m_NoticeView addSubview:[self noticeLabWithleft:imageView.right]];
        
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
            return 4;
        default:
            return 5;
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
            NSString *contentTitle = m_ContentArr[indexPath.row];
            [cell.imageView setImage:[UIImage imageNamed:contentTitle]];
            [cell.titleLab setText:@"全家出行旅游意外保险"];
            [cell.detailLab setText:@"优质产品，性价比高"];
            [cell.moneyLab setText:@"推广奖励：20-80元"];
            return cell;
        }
        default:
        {
            [m_ContentView registerClass:[RooViewNewsCell class] forCellWithReuseIdentifier:@"RooViewNewsCell_CELLIDENTIFIER"];
            static NSString *cellIdentifier = @"RooViewNewsCell_CELLIDENTIFIER";
            RooViewNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
            NSString *contentTitle = m_ContentArr[indexPath.row];
            [cell.imageView setImage:[UIImage imageNamed:contentTitle]];
            [cell.titleLab setText:contentTitle];
            [cell.detailLab setText:@"不限社保用药"];
            [cell.companyLab setText:@"中国人保财险"];
            [cell.readNumLab setText:@"99999阅读"];
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
                }
                else
                {
                    adView = [[CommonADAutoView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(150))];
                    [adView setTag:1000];
                    [adView setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
                    [reusableview addSubview:adView];
                }
                [m_NoticeView removeFromSuperview];
                [reusableview addSubview:[self createNoticeView]];
            }
                break;
            default:
            {
                UIView *titleView;
                if ([reusableview viewWithTag:1000])
                {
                    [m_NoticeView removeFromSuperview];
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

#pragma mark - UICollecrtionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            if (self.selectBlock)
            {
                self.selectBlock(indexPath, nil);
            }
        }
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
    switch (indexPath.section)
    {
        case 0:
        {
            CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(33))/3;
            return CGSizeMake(widht, DIF_PX(97+24));
        }
        case 1:
        {
            CGFloat widht = (DIF_SCREEN_WIDTH-4*DIF_PX(12))/2;
            return CGSizeMake(widht, DIF_PX(190));
        }
        default:
        {
            return CGSizeMake(DIF_SCREEN_WIDTH, DIF_PX(95));
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return UIEdgeInsetsMake(DIF_PX(0), DIF_PX(33), DIF_PX(24), DIF_PX(33));
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
