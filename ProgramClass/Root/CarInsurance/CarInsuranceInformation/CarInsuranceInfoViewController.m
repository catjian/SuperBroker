//
//  CarInsuranceInfoViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/24.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceInfoViewController.h"

@interface CarInsuranceInfoViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"车险服务"];
    [self.contentView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
    
    [self.userIDCardBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:@[@5,@6] color:DIF_HEXCOLOR(@"017aff")];
    [self.driverCardBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:@[@5,@6] color:DIF_HEXCOLOR(@"017aff")];
    [self.cityNumBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:nil color:DIF_HEXCOLOR(@"017aff")];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.contentView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Button Events

- (IBAction)selectCityNumberButtonEvent:(id)sender
{
    [self.view endEditing:YES];
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
        if (component == 1)
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
    }];
}

- (IBAction)selectUserIDCardPictureButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [[CommonPictureSelect sharedPictureSelect] showWithViewController:self
                                                        ResponseBlock:^(UIImage *image) {
                                                        }];
}

- (IBAction)uploadUserIDCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)selectDriverCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [[CommonPictureSelect sharedPictureSelect] showWithViewController:self
                                                        ResponseBlock:^(UIImage *image) {
                                                        }];
}

- (IBAction)uploadDriverCardButtonEvent:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)userServerButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    PopTowBtnMessageAlertView *alertView =
    [[PopTowBtnMessageAlertView alloc] initWithTitle:@"温馨提示"
                                             Message:@"请完整填写车辆信息后\n再进行下一步"
                                          LeftButton:@"取消"
                                         RightButton:@"去填写"
                                               Block:^(NSInteger index) {
                                                   
                                               }];
    [alertView show];
}

- (IBAction)nextButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [self loadViewController:@"CarInsuranceBusinessViewController"];
}

@end
