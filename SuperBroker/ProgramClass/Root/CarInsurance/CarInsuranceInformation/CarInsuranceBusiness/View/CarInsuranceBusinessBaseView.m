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

- (void)setCarspeciesList:(NSArray *)carspeciesList
{
    _carspeciesList = carspeciesList;
    [self reloadData];
}

#pragma mark - delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carspeciesList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarsPeciesDataDetailModel *model = [CarsPeciesDataDetailModel mj_objectWithKeyValues:self.carspeciesList[section]];
    return model.insuranceCarSpeciesList.count;
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
    CarsPeciesDataDetailModel *model = [CarsPeciesDataDetailModel mj_objectWithKeyValues:self.carspeciesList[indexPath.section]];
    CarSpeciesDataListDetailModel *detailModel = [CarSpeciesDataListDetailModel mj_objectWithKeyValues:model.insuranceCarSpeciesList[indexPath.row]];
    if (self.isCanEdit)
    {
        NSInteger isDeductible = 0;
        if (detailModel.isDeductible.length == 1)
        {
            isDeductible = detailModel.isDeductible.integerValue;
        }
        CarInsuranceBusinessViewCell *cell =
        [BaseTableViewCell cellClassName:@"CarInsuranceBusinessViewCell"
                             InTableView:tableView
                         forContenteMode:@{@"title":detailModel.speciesName,
                                           @"showAER":isDeductible == 1?@(NO):@(YES),
                                           @"content":detailModel.selectMoney.length>0?detailModel.selectMoney:detailModel.selectList.firstObject,
                                           @"isDeductible": @(YES)}];
        cell.isCanEdit = self.isCanEdit;
        return cell;
    }
    else
    {
        NSInteger isDeductible = 1;
        if (detailModel.isDeductible.length == 1)
        {
            isDeductible = detailModel.isDeductible.integerValue;
        }
        CarInsuranceBusinessViewCell *cell =
        [BaseTableViewCell cellClassName:@"CarInsuranceBusinessViewCell"
                             InTableView:tableView
                         forContenteMode:@{@"title":detailModel.speciesName,
                                           @"showAER":detailModel.isDeductible.length == 0?@(NO):@(YES),
                                           @"content":detailModel.selectMoney.length>0?detailModel.selectMoney:detailModel.selectList.firstObject,
                                           @"isDeductible": @(isDeductible == 0?YES:NO)}];
        cell.isCanEdit = self.isCanEdit;
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CarsPeciesDataDetailModel *model = [CarsPeciesDataDetailModel mj_objectWithKeyValues:self.carspeciesList[section]];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DIF_SCREEN_WIDTH, DIF_PX(50))];
    [view setBackgroundColor:DIF_HEXCOLOR(@"ffffff")];
    
    UIView *lineH = [[UIView alloc] initWithFrame:CGRectMake(DIF_PX(12), 0, DIF_PX(2), DIF_PX(12))];
    [lineH setBackgroundColor:DIF_HEXCOLOR(@"017aff")];
    [lineH setCenterY:view.height/2];
    [view addSubview:lineH];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(lineH.right+DIF_PX(5), 0, view.width-lineH.right-DIF_PX(20), view.height)];
    [lab setTextColor:DIF_HEXCOLOR(@"333333")];
    [lab setFont:DIF_UIFONTOFSIZE(13)];
    [lab setText:model.speciesName];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!self.isCanEdit)
    {
        return;
    }
    if (self.selectBlock)
    {
        self.selectBlock(indexPath, nil);
    }
}

@end
