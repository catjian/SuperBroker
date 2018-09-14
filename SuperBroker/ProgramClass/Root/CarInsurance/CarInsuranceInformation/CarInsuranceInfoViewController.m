//
//  CarInsuranceInfoViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceInfoViewController.h"
#import "CarInsuranceBusinessViewController.h"

@interface CarInsuranceInfoViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *userIDCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadIDCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *driverCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadDriCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *userServerBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityNumBtn;
@property (weak, nonatomic) IBOutlet UITextField *plateNumTF;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *VINinputTF;
@property (weak, nonatomic) IBOutlet UITextField *engineNumTF;
@property (weak, nonatomic) IBOutlet UIButton *registerDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *oilTypeBtn;
@property (weak, nonatomic) IBOutlet UITextField *carOwnerTF;
@property (weak, nonatomic) IBOutlet UITextField *ownerCardIdTF;

@end

@implementation CarInsuranceInfoViewController
{
    NSString *m_userIDCardPicUrl;
    NSString *m_driverCardPicUrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险服务"];
    [self.contentView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
    [self.contentView setDelegate:self];
    
    [self.userIDCardBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:@[@5,@6] color:DIF_HEXCOLOR(@"017aff")];
    [self.driverCardBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:@[@5,@6] color:DIF_HEXCOLOR(@"017aff")];
    [self.cityNumBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:nil color:DIF_HEXCOLOR(@"017aff")];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.contentView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
    [self.uploadIDCardBtn.layer setCornerRadius:5];
    [self.uploadDriCardBtn.layer setCornerRadius:5];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self.view endEditing:YES];
}

#pragma mark - Button Events

- (IBAction)selectProvinceCityButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@".plist"]];
    __block NSMutableArray *provinceArr = [NSMutableArray array];
    for (int i = 0; i <= 33; i++)
    {
        NSDictionary *subDic = [dic objectForKey:[@(i) stringValue]];
        [provinceArr addObject:subDic.allKeys.firstObject];
    }
    NSDictionary *provDic = [[dic objectForKey:@"0"] objectForKey:provinceArr.firstObject];
    NSMutableArray *city = [NSMutableArray array];
    for (int i = 0; i < provDic.count; i++)
    {
        NSDictionary *subDic = [provDic objectForKey:[@(i) stringValue]];
        [city addObject:subDic.allKeys.firstObject];
    }
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    __block CommonMorePickerView *pickerView = [[CommonMorePickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:@[provinceArr,city]];
    [pickerView setSelectBlock:^(NSInteger component, NSInteger row) {
        if (component == 0)
        {
            NSDictionary *provDic = [[dic objectForKey:[@(row) stringValue]] objectForKey:provinceArr[row]];
            NSMutableArray *city = [NSMutableArray array];
            for (int i = 0; i < provDic.count; i++)
            {
                NSDictionary *subDic = [provDic objectForKey:[@(i) stringValue]];
                [city addObject:subDic.allKeys.firstObject];
            }
            NSMutableArray *pickerArr = [NSMutableArray arrayWithArray:pickerView.pickerDatas];
            [pickerArr replaceObjectAtIndex:1 withObject:city];
            [pickerView setPickerDatas:pickerArr];
            [pickerView reloadComponent:component+1 SelectRow:0];
        }
    }];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            NSArray *content = [x objectForKey:@"SuccessButtonEvent"];
            [strongSelf.cityBtn setTitle:[NSString stringWithFormat:@"%@ %@",content[0],content[1]] forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)selectCityNumberButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    __block CommonMorePickerView *pickerView = [[CommonMorePickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    NSArray *provinceArr = [CarInsuranceProvince getProvinceArray];
    [pickerView setPickerDatas:@[provinceArr,[CarInsuranceProvince getCityArrWithProvince:provinceArr.firstObject]]];
    [pickerView setSelectBlock:^(NSInteger component, NSInteger row) {
        if (component == 0)
        {
            NSMutableArray *pickerArr = [NSMutableArray arrayWithArray:pickerView.pickerDatas];
            [pickerArr replaceObjectAtIndex:1
                                 withObject:[CarInsuranceProvince getCityArrWithProvince:[pickerArr.firstObject objectAtIndex:row]]];
            [pickerView setPickerDatas:pickerArr];
            [pickerView reloadComponent:component+1 SelectRow:0];
        }
    }];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            NSArray *content = [x objectForKey:@"SuccessButtonEvent"];
            [strongSelf.cityNumBtn setTitle:[content.firstObject stringByAppendingString:content.lastObject]
                                forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)selectRegisterDateButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    __block CommonMorePickerView *pickerView = [[CommonMorePickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    int year = [CommonDate getNowDateWithFormate:@"yyyy"].intValue;
    NSMutableArray *years = [NSMutableArray array];
    for(int star = 2000; star <= year; star++)
    {
        [years addObject:[@(star) stringValue]];
    }
    NSMutableArray *months = [NSMutableArray array];
    for(int month = 1; month <= 12; month++)
    {
        [months addObject:[NSString stringWithFormat:@"%02d", month]];
    }
    NSMutableArray *days = [NSMutableArray array];
    for(int day = 1; day <= 31; day++)
    {
        [days addObject:[NSString stringWithFormat:@"%02d", day]];
    }
    [pickerView setPickerDatas:@[years,months,days]];
    [pickerView setSelectBlock:^(NSInteger component, NSInteger row) {
        if (component == 0)
        {
            NSString *calendarStr = [NSString stringWithFormat:@"%@01",pickerView.selectPickerDatas[0]];
            NSDate *calendarDate = [CommonDate dateStringToDate:calendarStr Formate:@"yyyyMM"];
            NSInteger monthDays = [CommonDate totaldaysInThisMonth:calendarDate];
            NSMutableArray *days = [NSMutableArray array];
            for(int day = 1; day <= monthDays; day++)
            {
                [days addObject:[NSString stringWithFormat:@"%02d", day]];
            }
            NSMutableArray *pickerArr = [NSMutableArray arrayWithArray:pickerView.pickerDatas];
            [pickerArr replaceObjectAtIndex:2 withObject:days];
            [pickerView setPickerDatas:pickerArr];
            [pickerView reloadComponent:component+1 SelectRow:0];
        }
        else if (component == 1)
        {
            NSString *calendarStr = [NSString stringWithFormat:@"%@%@",pickerView.selectPickerDatas[0],pickerView.selectPickerDatas[1]];
            NSDate *calendarDate = [CommonDate dateStringToDate:calendarStr Formate:@"yyyyMM"];
            NSInteger monthDays = [CommonDate totaldaysInThisMonth:calendarDate];
            NSMutableArray *days = [NSMutableArray array];
            for(int day = 1; day <= monthDays; day++)
            {
                [days addObject:[NSString stringWithFormat:@"%02d", day]];
            }
            NSMutableArray *pickerArr = [NSMutableArray arrayWithArray:pickerView.pickerDatas];
            [pickerArr replaceObjectAtIndex:2 withObject:days];
            [pickerView setPickerDatas:pickerArr];
            [pickerView reloadComponent:component+1 SelectRow:0];
        }
        else
        {
            for (component++; component < 3; component++)
            {
                [pickerView reloadComponent:component SelectRow:0];
            }
        }
    }];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            NSArray *content = [x objectForKey:@"SuccessButtonEvent"];
            [strongSelf.registerDateBtn setTitle:[NSString stringWithFormat:@"%@-%@-%@",content[0],content[1],content[2]]
                                   forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)selectOldTypeButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:@[@"汽油",@"柴油"]];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *content = [x objectForKey:@"SuccessButtonEvent"];
            [strongSelf.oilTypeBtn setTitle:content[@"content"]
                                        forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)selectUserIDCardPictureButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    DIF_WeakSelf(self)
    [[CommonPictureSelect sharedPictureSelect]
     showWithViewController:self
     ResponseBlock:^(UIImage *image) {
         DIF_StrongSelf
         if (image)
         {
             strongSelf->m_userIDCardPicUrl = nil;
             [strongSelf.userIDCardBtn setBackgroundImage:image forState:UIControlStateNormal];
             [strongSelf.userIDCardBtn setTitle:@"" forState:UIControlStateNormal];
             [strongSelf.userIDCardBtn setImage:nil forState:UIControlStateNormal];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [strongSelf uploadUserIDCardButtonEvent:nil];
             });
         }
         else if (!self.userIDCardBtn.currentBackgroundImage)
         {
             [strongSelf.userIDCardBtn setTitle:@"请上传清晰的身份证照片" forState:UIControlStateNormal];
             [strongSelf.userIDCardBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
         }
//         [strongSelf.userIDCardBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 96, 0, 20)];
//         [strongSelf.userIDCardBtn setTitleEdgeInsets:UIEdgeInsetsMake(65, 0, 25, 0)];
     }];
}

- (IBAction)uploadUserIDCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    if (!self.userIDCardBtn.currentBackgroundImage)
    {
//        [CommonHUD delayShowHUDWithMessage:@"请选择图片!"];
        [self selectUserIDCardPictureButtonEvent:nil];
        return;
    }
    if (m_userIDCardPicUrl.length > 0)
    {
        [self.view makeToast:@"身份证已上传成功" duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUDWithMessage:@"正在上传中..."];
    DIF_WeakSelf(self)
    dispatch_async(dispatch_queue_create("com.uploadPic.queue", NULL), ^{
        DIF_StrongSelf
        strongSelf->m_userIDCardPicUrl = [DIF_CommonHttpAdapter httpRequestUploadImageFile:strongSelf.userIDCardBtn.currentBackgroundImage
                                                                 ResponseBlock:nil
                                                                   FailedBlcok:nil];
        if(strongSelf->m_userIDCardPicUrl)
        {
            [CommonHUD delayShowHUDWithMessage:@"上传成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.uploadIDCardBtn setTitle:@"已上传" forState:UIControlStateNormal];
            });
        }
        else
        {
            [CommonHUD delayShowHUDWithMessage:@"上传失败，请重试!"];
        }
    });
}

- (IBAction)selectDriverCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    DIF_WeakSelf(self)
    [[CommonPictureSelect sharedPictureSelect]
     showWithViewController:self
     ResponseBlock:^(UIImage *image) {
         DIF_StrongSelf
         if (image)
         {
             strongSelf->m_driverCardPicUrl = nil;
             [strongSelf.driverCardBtn setBackgroundImage:image forState:UIControlStateNormal];
             [strongSelf.driverCardBtn setTitle:@"" forState:UIControlStateNormal];
             [strongSelf.driverCardBtn setImage:nil forState:UIControlStateNormal];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [strongSelf uploadDriverCardButtonEvent:nil];
             });
         }
         else if (!self.driverCardBtn.currentBackgroundImage)
         {
             [strongSelf.driverCardBtn setTitle:@"请上传清晰的行驶证照片" forState:UIControlStateNormal];
             [strongSelf.driverCardBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
         }
     }];
}

- (IBAction)uploadDriverCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    if (!self.driverCardBtn.currentBackgroundImage)
    {
//        [CommonHUD delayShowHUDWithMessage:@"请选择图片!"];
        [self selectDriverCardButtonEvent:nil];
        return;
    }
    if (m_driverCardPicUrl.length > 0)
    {
        [self.view makeToast:@"行驶证已上传成功" duration:2 position:CSToastPositionCenter];
        return;
    }
    [CommonHUD showHUDWithMessage:@"正在上传中..."];
    DIF_WeakSelf(self)
    dispatch_async(dispatch_queue_create("com.uploadPic.queue", NULL), ^{
        DIF_StrongSelf
        strongSelf->m_driverCardPicUrl = [DIF_CommonHttpAdapter httpRequestUploadImageFile:strongSelf.driverCardBtn.currentBackgroundImage
                                                                 ResponseBlock:nil
                                                                   FailedBlcok:nil];
        if(strongSelf->m_driverCardPicUrl)
        {
            [CommonHUD delayShowHUDWithMessage:@"上传成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.uploadDriCardBtn setTitle:@"已上传" forState:UIControlStateNormal];
            });
        }
        else
        {
            [CommonHUD delayShowHUDWithMessage:@"上传失败，请重试!"];
        }
    });
}

- (IBAction)userServerButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)nextButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    if (self.plateNumTF.text.length < 5)
    {
        [self.view makeToast:@"请输入车牌号"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.userNameTF.text.length < 2)
    {
        [self.view makeToast:@"请输入投保人姓名"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if ( ![CommonVerify isMobileNumber:self.userPhoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.VINinputTF.text.length < 5)
    {
        [self.view makeToast:@"请输入车辆识别代号"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.engineNumTF.text.length < 2)
    {
        [self.view makeToast:@"请输入发动机号"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.registerDateBtn.titleLabel.text.length < 6)
    {
        [self.view makeToast:@"请选择注册日期"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.oilTypeBtn.titleLabel.text.length != 2)
    {
        [self.view makeToast:@"请选择燃油类型"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.carOwnerTF.text.length < 2)
    {
        [self.view makeToast:@"请输入车主姓名"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![CommonVerify isIdentityCard:self.ownerCardIdTF.text])
    {
        [self.view makeToast:@"请输入身份证号"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    
    if (self.userNameTF.text.length < 2 || ![CommonVerify isMobileNumber:self.userPhoneTF.text]||
        self.VINinputTF.text.length < 5 || self.engineNumTF.text.length < 5 ||
        self.registerDateBtn.titleLabel.text.length < 1 || self.oilTypeBtn.titleLabel.text.length < 1 ||
        self.carOwnerTF.text.length < 1 || self.ownerCardIdTF.text.length < 17 ||
        //[CommonVerify isIdentityCard:self.ownerCardIdTF.text] ||
        m_userIDCardPicUrl.length < 1 || m_driverCardPicUrl.length < 1)
    {
        PopTowBtnMessageAlertView *alertView =
        [[PopTowBtnMessageAlertView alloc] initWithTitle:@"温馨提示"
                                                 Message:@"请完整填写车辆信息后\n再进行下一步"
                                              LeftButton:@"取消"
                                             RightButton:@"去填写"
                                                   Block:^(NSInteger index) {

                                                   }];
        [alertView show];
        return;
    }
    CarInsuranceCustomerDetail *buyUserDetail = [CarInsuranceCustomerDetail new];
    buyUserDetail.city = self.cityBtn.titleLabel.text;
    buyUserDetail.cityNum = self.cityNumBtn.titleLabel.text;
    buyUserDetail.plateNum = self.plateNumTF.text;
    buyUserDetail.userName = self.userNameTF.text;
    buyUserDetail.userPhone = self.userPhoneTF.text;
    buyUserDetail.VINStr = self.VINinputTF.text;
    buyUserDetail.engineNum = self.engineNumTF.text;
    buyUserDetail.registerDate = self.registerDateBtn.titleLabel.text;
    buyUserDetail.oilType = self.oilTypeBtn.titleLabel.text;
    buyUserDetail.carOwner = self.carOwnerTF.text;
    buyUserDetail.ownerCardId = self.ownerCardIdTF.text;
    buyUserDetail.userIDCardPic = m_userIDCardPicUrl;
    buyUserDetail.driverCardPic = m_driverCardPicUrl;
    CarInsuranceBusinessViewController *vc = [self loadViewController:@"CarInsuranceBusinessViewController"];
    vc.isCanEdit = YES;
    vc.detailModel = self.detailModel;
    vc.buyCustomDetail = buyUserDetail;
    vc.generalizeAmountNum = self.detailModel.generalizeAmount;
}

@end
