//
//  LoanInformationViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/9/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "LoanInformationViewController.h"
#import "LoanCommitViewController.h"
#import "LoanScreenModel.h"

@interface LoanInformationViewController () <UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *speciesBtn;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (weak, nonatomic) IBOutlet UITextField *customNameTF;
@property (weak, nonatomic) IBOutlet UITextField *customPhoneTF;
@property (weak, nonatomic) IBOutlet UITextField *customCardIdTF;
@property (weak, nonatomic) IBOutlet UIView *remarkBackView;
@property (weak, nonatomic) IBOutlet UIButton *userIDCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadIDCardBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation LoanInformationViewController
{
    NSString *m_userIDCardPicUrl;
    PlaceTextView *m_RemarkTV;
    NSArray<LoanScreenModel *> *m_SpeciesArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavTarBarTitle:@"填写贷款信息"];
    [self httpRequestLoanproductSpecies];
    
    [self.userIDCardBtn setlayerCornerSquareWithCornerRadius:5 lineWidth:1 DashPattern:@[@5,@6] color:DIF_HEXCOLOR(@"017aff")];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoardEvent:)];
    [self.scrollView addGestureRecognizer:tapGR];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.scrollView.delegate == NULL)
    {
        [self.scrollView setContentSize:CGSizeMake(DIF_SCREEN_WIDTH, self.bottomView.bottom)];
        [self.uploadIDCardBtn.layer setCornerRadius:5];
        [self.remarkBackView.layer setCornerRadius:5];
        [self.remarkBackView.layer setBorderColor:DIF_HEXCOLOR(@"dedede").CGColor];
        [self.remarkBackView.layer setBorderWidth:1];
        if(!m_RemarkTV)
        {
            m_RemarkTV = [[PlaceTextView alloc] initWithFrame:CGRectMake(DIF_PX(10), DIF_PX(10),
                                                                         self.remarkBackView.width-DIF_PX(20), self.remarkBackView.height-DIF_PX(20))];
            [m_RemarkTV setFont:DIF_DIFONTOFSIZE(14)];
            [m_RemarkTV setPlaceholder:@"请输入其他贷款材料补充说明"];
            [m_RemarkTV setPlaceColor:DIF_HEXCOLOR(@"999999")];
            [m_RemarkTV setRealTextColor:DIF_HEXCOLOR(@"333333")];
            [self.remarkBackView addSubview:m_RemarkTV];
        }
        [self.scrollView setDelegate:self];
    }
}

- (void)hideKeyBoardEvent:(UIGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
}

#pragma mark - Button Events

- (IBAction)customServerButtonEvent:(id)sender
{
    [self.view endEditing:YES];
    [self loadViewController:@"CustomerServerViewController" hidesBottomBarWhenPushed:YES];
}

- (IBAction)selectSpeciseButtoEvent:(UIButton *)sender
{
    [self.view endEditing:YES];
    NSMutableArray *pickerData = [NSMutableArray array];
    for (LoanScreenModel *model in m_SpeciesArray)
    {
        [pickerData addObject:model.speciesName];
    }
    __block CommonBottomPopView *popPickerView = [[CommonBottomPopView alloc] init];
    [popPickerView setHeight:DIF_PX(270)];
    CommonPickerView *pickerView = [[CommonPickerView alloc] initWithFrame:CGRectMake(0, 0, popPickerView.width, popPickerView.height)];
    [pickerView setPickerDatas:pickerData];
    [popPickerView addSubview:pickerView];
    [popPickerView showPopView];
    DIF_WeakSelf(self)
    [pickerView.racSignal subscribeNext:^(id  _Nullable x) {
        DIF_StrongSelf
        [popPickerView hidePopView];
        if ([x isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *content = [x objectForKey:@"SuccessButtonEvent"];
            [strongSelf.speciesBtn setTitleColor:DIF_HEXCOLOR(@"333333")
                                        forState:UIControlStateNormal];
            [strongSelf.speciesBtn setTitle:content[@"content"]
                                   forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)addUserCardIdImageButtonEvent:(UIButton *)sender
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
                 [strongSelf uploadUserCardIdImageButtonEvent:nil];
             });
         }
         else if (!self.userIDCardBtn.currentBackgroundImage)
         {
             [strongSelf.userIDCardBtn setTitle:@"请上传清晰的身份证照片" forState:UIControlStateNormal];
             [strongSelf.userIDCardBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
         }
     }];
}

- (IBAction)uploadUserCardIdImageButtonEvent:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (!self.userIDCardBtn.currentBackgroundImage)
    {
        [self addUserCardIdImageButtonEvent:nil];
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


- (IBAction)commitLoanInformationButtonEvent:(id)sender
{
    [self.view endEditing:YES];    
    if ([self.speciesBtn.titleLabel.text isEqualToString:@"请选择"])
    {
        [self.view makeToast:@"请选择贷款类型"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.moneyTF.text.integerValue <= 0)
    {
        [self.view makeToast:@"请输入期待金额"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.customNameTF.text.length < 2)
    {
        [self.view makeToast:@"请输入投保人姓名"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if ( ![CommonVerify isMobileNumber:self.customPhoneTF.text])
    {
        [self.view makeToast:@"请输入手机号码"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    if (![CommonVerify isIdentityCard:self.customCardIdTF.text])
    {
        [self.view makeToast:@"请输入身份证号"
                    duration:2 position:CSToastPositionCenter];
        return;
    }
    
    if (self.customNameTF.text.length < 2 || ![CommonVerify isMobileNumber:self.customPhoneTF.text]||
        self.moneyTF.text.integerValue <= 0 || ![CommonVerify isIdentityCard:self.customCardIdTF.text] ||
        m_userIDCardPicUrl.length < 1)
    {
        PopTowBtnMessageAlertView *alertView =
        [[PopTowBtnMessageAlertView alloc] initWithTitle:@"温馨提示"
                                                 Message:@"请完整填写贷款信息后\n再进行下一步"
                                              LeftButton:@"取消"
                                             RightButton:@"去填写"
                                                   Block:^(NSInteger index) {
                                                       
                                                   }];
        [alertView show];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.listDetailModel.productId forKey:@"loanProductId"];
    for (LoanScreenModel *model in m_SpeciesArray)
    {
        if ([self.speciesBtn.titleLabel.text isEqualToString:model.speciesName])
        {
            [params setObject:model.speciesId forKey:@"loanType"];
            break;
        }
    }
    [params setObject:self.moneyTF.text forKey:@"expectAmount"];
    [params setObject:self.customNameTF.text forKey:@"borrowerName"];
    [params setObject:self.customPhoneTF.text forKey:@"borrowerPhone"];
    [params setObject:self.customCardIdTF.text forKey:@"identityCard"];
    if (![m_RemarkTV.textColor isEqual:m_RemarkTV.placeColor] && [m_RemarkTV.placeholder rangeOfString:m_RemarkTV.text].location == NSNotFound)
    {
        [params setObject:m_RemarkTV.text forKey:@"remark"];
    }
    [params setObject:m_userIDCardPicUrl forKey:@"borrowerCertificateUrl"];
    [self httpRequestCommitLoanOrderWithParmas:params];
}

#pragma mark - Http Request
//贷款资质（name=speciesId）列表：http://localhost:40002/api/loanproduct/species
- (void)httpRequestLoanproductSpecies
{
    [CommonHUD showHUD];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoanproductSpeciesWithParameters:nil
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             NSArray *data = responseModel[@"data"];
             NSMutableArray *modelDic = [NSMutableArray array];
             for (NSDictionary *dic in data)
             {
                 LoanScreenModel *model = [LoanScreenModel mj_objectWithKeyValues:dic];
                 [modelDic addObject:model];
             }
             strongSelf->m_SpeciesArray = modelDic;
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

- (void)httpRequestCommitLoanOrderWithParmas:(NSDictionary *)params
{
    [CommonHUD showHUDWithMessage:@"提交中..."];
    DIF_WeakSelf(self)
    [DIF_CommonHttpAdapter
     httpRequestLoanOrderWithParameters:params
     ResponseBlock:^(ENUM_COMMONHTTP_RESPONSE_TYPE type, id responseModel) {
         DIF_StrongSelf
         if(type == ENUM_COMMONHTTP_RESPONSE_TYPE_SUCCESS)
         {
             [CommonHUD hideHUD];
             LoanCommitViewController *vc = [strongSelf loadViewController:@"LoanCommitViewController"];
             vc.detailModel = strongSelf.detailModel;
             vc.orderModel = [LoadCommitOrderModel mj_objectWithKeyValues:responseModel[@"data"]];
         }
         else
         {
             [CommonHUD delayShowHUDWithMessage:responseModel[@"message"]];
         }
     } FailedBlcok:^(NSError *error) {
         [CommonHUD delayShowHUDWithMessage:DIF_Request_NET_ERROR];
     }];
}

@end
