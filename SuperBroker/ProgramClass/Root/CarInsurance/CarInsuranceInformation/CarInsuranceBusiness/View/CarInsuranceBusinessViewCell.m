//
//  CarInsuranceBusinessViewCell.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/7/25.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "CarInsuranceBusinessViewCell.h"

@implementation CarInsuranceBusinessViewCell
{
    UILabel *m_TitleLab;
    UILabel *m_AERLab;
    UILabel *m_ContentLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.isDeductible = YES;
        self.cellHeight = DIF_PX(50);
        self.showLine = YES;
        self.showLineWidht = DIF_SCREEN_WIDTH;
        UIImageView *downIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"延展图标"]];
        [downIcon setRight:DIF_SCREEN_WIDTH-DIF_PX(12)];
        [downIcon setCenterY:self.cellHeight/2];
        [self.contentView addSubview:downIcon];
        
        m_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(DIF_PX(20), 0, DIF_PX(80), self.cellHeight)];
        [m_TitleLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_TitleLab setFont:DIF_UIFONTOFSIZE(13)];
        [self.contentView addSubview:m_TitleLab];
        
        m_AERLab = [[UILabel alloc] initWithFrame:CGRectMake(m_TitleLab.right+DIF_PX(24), 0, DIF_PX(100), self.cellHeight)];
        [m_AERLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_AERLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_AERLab setHidden:YES];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"  不计免赔"];
        [attStr attatchImage:[UIImage imageNamed:@"不计免赔"]
                  imageFrame:CGRectMake(0, -DIF_PX(20)/4, DIF_PX(20), DIF_PX(20))
                       Range:NSMakeRange(0, 0)];
        [m_AERLab setAttributedText:attStr];
        [self.contentView addSubview:m_AERLab];
        
        m_ContentLab = [[UILabel alloc] initWithFrame:CGRectMake(m_AERLab.right+DIF_PX(20), 0, downIcon.left - m_AERLab.right-DIF_PX(40) , self.cellHeight)];
        [m_ContentLab setTextColor:DIF_HEXCOLOR(@"333333")];
        [m_ContentLab setFont:DIF_UIFONTOFSIZE(13)];
        [m_ContentLab setTextAlignment:NSTextAlignmentRight];
        [self.contentView addSubview:m_ContentLab];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ARELableTapGestureRecognizer:)];
        [tapGR setDelegate:self];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)loadData:(NSDictionary *)model
{
    [m_AERLab setHidden:YES];
    [m_TitleLab setText:model[@"title"]];
    [m_AERLab setHidden:![model[@"showAER"] boolValue]];
    [m_ContentLab setText:model[@"content"]];    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"  不计免赔"];
    [attStr attatchImage:[UIImage imageNamed:[model[@"isDeductible"] boolValue]?@"不计免赔":@"不计免赔-未选中"]
              imageFrame:CGRectMake(0, -DIF_PX(20)/4, DIF_PX(20), DIF_PX(20))
                   Range:NSMakeRange(0, 0)];
    [m_AERLab setAttributedText:attStr];
}

- (void)ARELableTapGestureRecognizer:(UIGestureRecognizer *)gesture
{
    if (!self.isCanEdit)
    {
        return;
    }
    self.isDeductible = !self.isDeductible;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"  不计免赔"];
    [attStr attatchImage:[UIImage imageNamed:self.isDeductible?@"不计免赔":@"不计免赔-未选中"]
              imageFrame:CGRectMake(0, -DIF_PX(20)/4, DIF_PX(20), DIF_PX(20))
                   Range:NSMakeRange(0, 0)];
    [m_AERLab setAttributedText:attStr];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    UIView *grLab = gestureRecognizer.view;
    CGPoint point = [touch locationInView:grLab];
    CGRect labFrame = m_AERLab.frame;
    if (CGRectContainsPoint(labFrame, point))
    {
        return YES;
    }
    return NO;
}

@end
