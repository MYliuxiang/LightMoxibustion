//
//  LxCustomAlert.h
//  BiDui
//
//  Created by 刘翔 on 2018/5/26.
//  Copyright © 2018年 刘翔. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LxCustomAlertType)
{
    LxCustomAlertTypeAlert           = 0,
    LxCustomAlertTypeSheet,
   
};


@interface LxCustomAlert : UIView<UIGestureRecognizerDelegate>

@property(nonatomic,retain)UIView *maskView;
@property(nonatomic,assign)LxCustomAlertType type;
@property(nonatomic,retain)UIViewController *topVC;
@property(nonatomic,assign) CGFloat offsetBotom;
@property(nonatomic,copy) void(^dismisBlock)(void);
@property(nonatomic,strong)UITapGestureRecognizer *missTapGesture;


- (void)show;
- (void)disMiss;
- (void)misstap;

@end
