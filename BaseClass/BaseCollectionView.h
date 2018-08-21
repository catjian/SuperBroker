//
//  BaseCollectionView.h
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/10.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^collectionViewTouchBeginEventBlock)(UICollectionView *collectionView, NSSet *touches, UIEvent *event);
typedef void(^collectionViewTouchEndEventBlock)(UICollectionView *collectionView, NSSet *touches, UIEvent *event);
typedef void(^collectionViewTouchMoveEventBlock)(UICollectionView *collectionView, NSSet *touches, UIEvent *event);
typedef void(^collectionViewTouchCancelEventBlock)(UICollectionView *collectionView, NSSet *touches, UIEvent *event);
typedef void(^collectionViewScrollEventlock)(UICollectionView *collectionView, UIScrollView *scrollView);

typedef void(^collectionViewSelectRowAtIndexPathBlock)(NSIndexPath *indexPath, id model);

typedef void(^collectionViewHeaderRefreshBlock)(void);
typedef void(^collectionViewLoadMoreBlock)(NSInteger page);

@interface BaseCollectionView : UICollectionView <UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, copy, readwrite) collectionViewTouchBeginEventBlock touchBeginBlock;
@property (nonatomic, copy, readwrite) collectionViewTouchEndEventBlock touchEndBlock;
@property (nonatomic, copy, readwrite) collectionViewTouchMoveEventBlock touchMoveBlock;
@property (nonatomic, copy, readwrite) collectionViewTouchCancelEventBlock touchCancelBlock;
@property (nonatomic, copy, readwrite) collectionViewScrollEventlock scrollBlock;

@property (nonatomic, copy, readwrite) collectionViewSelectRowAtIndexPathBlock selectBlock;

@property (nonatomic, copy, readwrite) collectionViewHeaderRefreshBlock refreshBlock;
@property (nonatomic, copy, readwrite) collectionViewLoadMoreBlock loadMoreBlock;

- (instancetype)initWithFrame:(CGRect)frame
              ScrollDirection:(UICollectionViewScrollDirection)scrollDirection
                CellClassName:(NSString *)className;

- (void)refreshAction;

- (void)loadMoreAction;

- (void)endRefresh;

@end
