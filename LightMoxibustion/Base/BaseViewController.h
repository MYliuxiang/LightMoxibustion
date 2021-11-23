//
//  BaseViewController.h
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LxEmptyView.h"

@interface BaseViewController : UIViewController


@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, copy) NSString *rightTitle;
@property (nonatomic, strong) UIColor *rightColor;
@property (nonatomic, strong) NSString *rightImageName;


@property (nonatomic, strong)LxEmptyView *nodataView;


//是否显示NavigationBar
- (BOOL)isNaviBarVisible;
//是否显示statusBar
- (BOOL)isStatusBarVisible;

- (void)doRightNavBarRightBtnAction;



@end
