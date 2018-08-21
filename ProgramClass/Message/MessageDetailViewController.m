//
//  MessageDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/2.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UIView *contentBack;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"消息详情"];
    [self.contentBack.layer setCornerRadius:5];
    
    NSDate *update = [NSDate dateWithTimeIntervalSince1970:self.detailModel.updateTime.integerValue/1000];
    [self.timeLab setText:[CommonDate dateToString:update Formate:@"EEEE HH:mm"]];
    if (self.detailModel.noticeType.integerValue == 62)
    {
        [self.titleLab setText:@"系统消息"];
    }
    else
    {
        [self.titleLab setText:@"财富消息"];
    }
    [self.dateLab setText:[CommonDate dateToString:update Formate:@"yyyy-MM-dd"]];
    [self performSelector:@selector(loadDetailLab) withObject:nil afterDelay:0.2];
}

- (void)loadDetailLab
{
    self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(self.dateLab.left, self.dateLab.bottom, self.contentBack.width-20, 30)];
    [self.detailLab setNumberOfLines:0];
    [self.detailLab setLineBreakMode:NSLineBreakByCharWrapping];
    [self.detailLab setFont:DIF_UIFONTOFSIZE(13)];
    [self.detailLab setTextColor:DIF_HEXCOLOR(@"333333")];
    [self.contentBack addSubview:self.detailLab];
    CGRect attrsRect = [self.detailModel.noticeDetail boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 9999)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                attributes:@{NSFontAttributeName : self.detailLab.font}
                                                                   context:nil];
    NSInteger row = ceil(attrsRect.size.width/self.detailLab.width);
    if (row * attrsRect.size.height > self.detailLab.height)
    {
        [self.detailLab setHeight:row*attrsRect.size.height];
        self.contentBack.height += row*attrsRect.size.height-30;
    }
    [self.detailLab setText:self.detailModel.noticeDetail];
}

@end
