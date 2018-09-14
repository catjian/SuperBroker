//
//  SpecialNewsDetailViewController.m
//  SuperBroker
//
//  Created by zhang_jian on 2018/8/4.
//  Copyright © 2018年 zhangjian. All rights reserved.
//

#import "SpecialNewsDetailViewController.h"

@interface SpecialNewsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation SpecialNewsDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavTarBarTitle:@"文章详情"];
//    NSString *htmlStr = self.detailModel.detail;
//    NSMutableString *mutStr = [NSMutableString stringWithString:htmlStr];
//    NSRange range = NSMakeRange(0, 0);
//    range = [htmlStr rangeOfString:@"<img"];
//    if (range.location == NSNotFound)
//    {
//        [mutStr appendString:htmlStr];
//    }
//    else
//    {
//        while (1)
//        {
//            range = [[mutStr substringFromIndex:range.location] rangeOfString:@"<img"];
//            if (range.location == NSNotFound)
//            {
//                break;
//            }
//            NSRange rangewidth = [[mutStr substringFromIndex:range.location] rangeOfString:@"width="];
//            NSRange rangeheight = [[mutStr substringFromIndex:range.location] rangeOfString:@"height="];
//            NSRange rangeEnd = [[mutStr substringFromIndex:range.location+rangeheight.location+rangeheight.length+1] rangeOfString:@"\""];
//            [mutStr replaceCharactersInRange:
//             NSMakeRange(rangewidth.location+range.location,
//                         rangeEnd.location+rangeheight.location+rangeheight.length+1-rangewidth.location+1)
//                                  withString:@"style=\"width:100%; height:auto\""];
//            range = NSMakeRange(rangeheight.location+rangeheight.length+range.location, 1);
//        }
//    }
//    [self.webView loadHTMLString:mutStr baseURL:nil];
    [CommonHUD delayShowHUDWithMessage:@"加载详情中..." delayTime:2];
    [self.webView
     loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       [NSString stringWithFormat:@"%@art?artId=%@", self.detailModel.shareDomain,self.detailModel.articleId]]]];
}

@end
