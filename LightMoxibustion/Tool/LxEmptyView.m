//
//  LxEmptyView.m
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LxEmptyView.h"

@implementation LxEmptyView

+ (instancetype)noDataEmptyWith:(NSString *)titleStr
{
    return [LxEmptyView emptyActionViewWithImageStr:@"baocuofankui"
                                           titleStr:titleStr
                                          detailStr:@""
                                        btnTitleStr:@""
                                      btnClickBlock:^(){
                                      }];
    
}

+ (instancetype)noNetWorkEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock{
    
    return [LxEmptyView emptyActionViewWithImageStr:@"网络连接失败" titleStr:@"网络连接失败" detailStr:@"请检查您的网络设置或重新加载" btnTitleStr:@"设置" btnClickBlock:^{
        btnClickBlock();
    }];
}

+ (instancetype)systemExceptionEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock
{
    return [LxEmptyView emptyActionViewWithImageStr:@"系统异常" titleStr:@"系统异常，请稍后重试" detailStr:@"" btnTitleStr:@"重新加载" btnClickBlock:^{
        btnClickBlock();
    }];
    
}



- (void)prepare{
    [super prepare];
    
    self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了

    
    self.titleLabTextColor = Color_9;
    self.titleLabFont = [UIFont systemFontOfSize:15];
    self.detailLabFont = [UIFont systemFontOfSize:14];
    self.detailLabTextColor = [UIColor colorWithHexString:@"#383B44"];
    self.actionBtnFont = [UIFont systemFontOfSize:14];
    self.actionBtnTitleColor = [UIColor whiteColor];
    self.actionBtnBorderColor = [UIColor colorWithHexString:@"#D6D6E1"];
    self.actionBtnBorderWidth = 1;
    self.actionBtnBackGroundColor = [UIColor clearColor];
    self.actionBtnHeight = 36;
    self.actionBtnCornerRadius = 18;
    self.actionBtnTitleColor = [UIColor colorWithHexString:@"#BEBBD1"];

//    self.contentViewY = 150;
    self.subViewMargin = 20;
//    self.imageMargin = 0;
//    self.titleMargin = 20;
//    self.detailMargin = 10;
    self.actionBtnHorizontalMargin = 50;
//    self.emptyViewIsCompleteCoverSuperView = YES;
//    self.backgroundColor = [MyColor colorWithHexString:@"#F7F9FD"];
    
}



@end
