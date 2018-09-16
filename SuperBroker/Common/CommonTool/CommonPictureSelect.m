//
//  CommonPictureSelect.m
//  uavsystem
//
//  Created by zhang_jian on 16/7/7.
//  Copyright © 2018年 . All rights reserved.
//

#import "CommonPictureSelect.h"

#ifndef DIF_PictureSelect_BtnTitles
#define DIF_PictureSelect_BtnTitles @[@"从相册中选择", @"拍照", @"取消"]
#endif

CommonPictureSelect *picSel = nil;
const CGFloat btnBackView_height = 160;

@interface CommonPictureSelect () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CommonPictureSelect
{
    BOOL isShowController;
    UIViewController *m_VC;
    UIView *m_BtnView;
    
    CommonPictureSelectResponse m_Block;
}

+ (CommonPictureSelect *)sharedPictureSelect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picSel = [[CommonPictureSelect alloc] initWithFrame:CGRectZero];
    });
    return picSel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
//        [self setTop:self.height];
        [self setBackgroundColor:[UIColor colorWithRed:0.7556 green:0.7556 blue:0.7556 alpha:0.4]];
        [self setAlpha:0];
        [self initSelectView];
    }
    return self;
}

- (void)initSelectView
{
    DIF_WeakSelf(self);
    m_BtnView = [[UIView alloc] initWithFrame:CGRectMake(0, DIF_SCREEN_HEIGHT+(is_iPHONE_X?39:0), DIF_SCREEN_WIDTH, btnBackView_height)];
    [m_BtnView setBackgroundColor:DIF_HEXCOLOR(@"f4f4f4")];
    [self addSubview:m_BtnView];
//    [m_BtnView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_offset(btnBackView_height);
//        make.left.equalTo(weakSelf);
//        make.right.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.mas_bottom).offset(is_iPHONE_X?39:0);
////        make.bottom.equalTo(weakSelf).offset(is_iPHONE_X?-39:0);
//    }];
    
    [DIF_PictureSelect_BtnTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        DIF_StrongSelf
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, idx*(50)+(idx == 2?10:0), DIF_SCREEN_WIDTH, 50)];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
        [btn setTitleColor:DIF_HEXCOLOR(@"333333") forState:UIControlStateNormal];
        [btn.titleLabel setFont:DIF_UIFONTOFSIZE(18)];
        [btn setTag:idx+100];
        [btn addTarget:weakSelf action:@selector(SelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [strongSelf->m_BtnView addSubview:btn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (idx == 2?(idx*(50)+10):(idx+1)*(49.5)), DIF_SCREEN_WIDTH, 1)];
        [line setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [strongSelf->m_BtnView addSubview:line];
    }];
}

- (void)showWithViewController:(UIViewController *)vc ResponseBlock:(CommonPictureSelectResponse)block
{
    m_VC = vc;
    m_Block = block;
    [DIF_APPDELEGATE.window addSubview:self];
    DIF_WeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        DIF_StrongSelf
        [weakSelf setAlpha:1];
        [strongSelf->m_BtnView setTop:strongSelf.bottom-btnBackView_height-(is_iPHONE_X?39:0)];
    }];
}

- (void)hide
{
    m_VC = nil;
    DIF_WeakSelf(self);
    [UIView animateWithDuration:0.5 animations:^{
        DIF_StrongSelf
        [strongSelf->m_BtnView setTop:DIF_SCREEN_HEIGHT+(is_iPHONE_X?39:0)];
        [weakSelf setAlpha:0];
    } completion:^(BOOL finished) {
        DIF_StrongSelf
        if (!strongSelf->isShowController)
        {
            [strongSelf removeFromSuperview];
        }
    }];
}

- (void)SelectButtonAction:(UIButton *)btn
{
    isShowController = YES;
    switch (btn.tag-100)
    {
        case 1:
        {
            [self showCameraController];
        }
            break;
        case 0:
        {
            [self showPhotoLibraryController];
        }
            break;
        default:
        {
            isShowController = NO;
            if (m_Block)
            {
                m_Block(nil);
            }
        }
            break;
    }
    [self hide];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showCameraController
{
    DIF_ReviewCamareAuthorizationStatus;
    if ([self isCameraAvailable])
    {
        UIImagePickerController *cameraCon = [[UIImagePickerController alloc] init];
        [cameraCon setSourceType:UIImagePickerControllerSourceTypeCamera];
        [cameraCon setAllowsEditing:NO];
        [cameraCon setDelegate:self];
        UIViewController *vc = m_VC;
        [vc presentViewController:cameraCon animated:YES completion:^{
            
        }];
    }
    else
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:@"错误" Message:@"没有找到设备的摄像头" ButtonTitle:@"确定"];
    }
}

- (void)showPhotoLibraryController
{
    DIF_ReviewLibraryAuthorizationStatus;
    if ([self isPhotoLibraryAvailable])
    {
        UIImagePickerController *photoLibController = [[UIImagePickerController alloc] init];
        [photoLibController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [photoLibController setDelegate:self];
        UIViewController *vc = m_VC;
        [vc presentViewController:photoLibController animated:YES completion:^{
            
        }];
    }
    else
    {
        [CommonAlertView showAlertViewOneBtnWithTitle:@"错误" Message:@"相册不可用" ButtonTitle:@"确定"];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (m_Block)
    {
        m_Block(nil);
    }
//    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
//        [weakSelf removeFromSuperview];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if (image.imageOrientation != UIImageOrientationUp)
    {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0,0,image.size}];
        UIImage * normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        image = normalizedImage;
    }
    if (m_Block)
    {
        m_Block(image);
    }
//    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
//        [weakSelf removeFromSuperview];
    }];
}

@end
