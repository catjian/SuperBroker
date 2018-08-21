//
//  CarInsuranceProvince.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/27.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceProvince.h"


@implementation CarInsuranceUploadParamsModel

@end

@implementation CarsPeciesDataDetailModel

@end

@implementation CarSpeciesDataListDetailModel

- (void)setSelectList:(NSArray *)selectList
{
    _selectList = selectList;
    if (selectList.count > 0)
    {
        self.selectMoney = selectList.firstObject;
    }
    else
    {
        self.selectMoney = @"不投保";
    }
}

@end

@implementation CarInsuranceCustomerDetail

@end

@implementation CarInsuranceProvince

+ (NSArray *)getProvinceArray
{
    NSArray *provinceArr = @[@"京", @"津", @"冀", @"晋", @"蒙", @"辽", @"吉", @"黑", @"沪",
                             @"苏", @"浙", @"皖", @"闽", @"赣", @"鲁", @"豫", @"鄂", @"湘",
                             @"粤", @"桂", @"琼", @"渝", @"川", @"贵", @"云", @"藏", @"陕",
                             @"甘", @"青", @"宁", @"新"];
    
    return provinceArr;
}

+ (NSArray *)getCityArrWithProvince:(NSString *)province
{
    NSMutableArray *cities = [NSMutableArray array];
    if ([province isEqualToString:@"京"])
    {
        for (char i = 'A'; i <= 'M'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities addObject:@"Y"];
    }
    else if ([province isEqualToString:@"津"])
    {
        for (char i = 'A'; i <= 'H'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
    }
    else if ([province isEqualToString:@"冀"])
    {
        for (char i = 'A'; i <= 'H'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities addObject:@"J"];
        [cities addObject:@"R"];
        [cities addObject:@"S"];
        [cities addObject:@"T"];
    }
    else if ([province isEqualToString:@"晋"])
    {
        for (char i = 'A'; i <= 'M'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"G"];
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"蒙"])
    {
        for (char i = 'A'; i <= 'M'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"辽"])
    {
        for (char i = 'A'; i <= 'P'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"吉"])
    {
        for (char i = 'A'; i <= 'K'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"黑"])
    {
        for (char i = 'A'; i <= 'R'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"沪"])
    {
        for (char i = 'A'; i <= 'D'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities addObject:@"R"];
    }
    else if ([province isEqualToString:@"苏"])
    {
        for (char i = 'A'; i <= 'N'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"浙"])
    {
        for (char i = 'A'; i <= 'L'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"皖"])
    {
        for (char i = 'A'; i <= 'S'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"闽"])
    {
        for (char i = 'A'; i <= 'K'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"赣"])
    {
        for (char i = 'A'; i <= 'M'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"鲁"])
    {
        for (char i = 'A'; i <= 'V'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
        [cities removeObject:@"T"];
        [cities addObject:@"Y"];
    }
    else if ([province isEqualToString:@"豫"])
    {
        for (char i = 'A'; i <= 'U'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
        [cities removeObject:@"T"];
    }
    else if ([province isEqualToString:@"鄂"])
    {
        for (char i = 'A'; i <= 'S'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"湘"])
    {
        for (char i = 'A'; i <= 'N'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
        [cities addObject:@"U"];
    }
    else if ([province isEqualToString:@"粤"])
    {
        for (char i = 'A'; i <= 'Z'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"桂"])
    {
        for (char i = 'A'; i <= 'P'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
        [cities addObject:@"R"];
    }
    else if ([province isEqualToString:@"琼"] || [province isEqualToString:@"宁"])
    {
        for (char i = 'A'; i <= 'E'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
    }
    else if ([province isEqualToString:@"渝"])
    {
        for (char i = 'A'; i <= 'D'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"D"];
        [cities removeObject:@"E"];
    }
    else if ([province isEqualToString:@"川"])
    {
        for (char i = 'A'; i <= 'Z'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"G"];
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"贵"] || [province isEqualToString:@"藏"])
    {
        for (char i = 'A'; i <= 'J'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
    }
    else if ([province isEqualToString:@"云"])
    {
        [cities addObject:@"A-V"]; //昆明市东川区（原东川市）
        for (char i = 'A'; i <= 'S'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"B"];
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"陕"])
    {
        for (char i = 'A'; i <= 'K'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities addObject:@"V"];
    }
    else if ([province isEqualToString:@"甘"])
    {
        for (char i = 'A'; i <= 'P'; i++) {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    else if ([province isEqualToString:@"青"])
    {
        for (char i = 'A'; i <= 'H'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
    }
    else if ([province isEqualToString:@"新"])
    {
        for (char i = 'A'; i <= 'R'; i++)
        {
            [cities addObject:[NSString stringWithFormat:@"%c",i]];
        }
        [cities removeObject:@"I"];
        [cities removeObject:@"O"];
    }
    return cities;
}

@end
