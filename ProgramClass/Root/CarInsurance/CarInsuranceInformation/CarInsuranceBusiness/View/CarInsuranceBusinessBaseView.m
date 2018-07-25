//
//  CarInsuranceBusinessBaseView.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceBusinessBaseView.h"

@implementation CarInsuranceBusinessBaseView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return self;
}

#pragma mark - delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0?1:10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DIF_PX(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return DIF_PX(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return section == 0? DIF_PX(12):DIF_PX(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarInsuranceBusinessViewCell *cell = [BaseTableViewCell cellClassName:@"CarInsuranceBusinessViewCell"
                                                              InTableView:tableView
                                                          forContenteMode:@{@"title":@"机动车车损险",@"showAER":@(YES),@"content":@"不投保"}];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(50))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(2), DIF_PX(12))];
    [lineH setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
    [lineH setCenterY:view.height/2];
    [view addSubview:lineH];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lineH.right+DIF_PX(5), 0, view.width-lineH.right-DIF_PX(20), view.height)];
    [lab setTextColor:DIF_HEXCOLOR(@"333333")];
    [lab setFont:DIF_UIFONTOFSIZE(13)];
    [lab setText:(section==0?@"交强险调整":@"商业险调整")];
    [view addSubview:lab];
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:lineT];
    
    UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, DIF_SCREEN_WIDTH, 1)];
    [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:lineB];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, section == 0? DIF_PX(12):DIF_PX(50))];
    [view setBackgroundColor:DIF_HEXCOLOR(section == 0?@"f4f4f4":@"ffffff")];
    
    if (section == 1)
    {
        UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_SCREEN_WIDTH-DIF_PX(24), view.height)];
        [messageLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [messageLab setFont:DIF_UIFONTOFSIZE(13)];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"  在确认提交后，请及时与保险经理联系或者咨询客服！"];
        [attStr attatchImage:[UIImage imageNamed:@"注意"]
                  imageFrame:CGRectMake(0, -DIF_PX(13)/4, DIF_PX(13), DIF_PX(13))
                       Range:NSMakeRange(0, 0)];
        [messageLab setAttributedText:attStr];
        [view addSubview:messageLab];
    }
    
    UIView *lineT = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, 1)];
    [lineT setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
    [view addSubview:lineT];
    
    if (section == 0)
    {
        UIView *lineB = [[UIView alloc] initWithFrame:CGRectMake(0, view.height-1, DIF_SCREEN_WIDTH, 1)];
        [lineB setBackgroundColor:DIF_HEXCOLOR(@"dedede")];
        [view addSubview:lineB];
    }
    
    return view;
}

@end
