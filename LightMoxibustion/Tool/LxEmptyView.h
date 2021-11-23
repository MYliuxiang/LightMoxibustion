//
//  LxEmptyView.h
//  WaiHui
//
//  Created by liuxiang on 2018/12/13.
//  Copyright © 2018年 faxian. All rights reserved.
//

#import "LYEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LxEmptyView : LYEmptyView

+ (instancetype)noDataEmptyWith:(NSString *)titleStr;

+ (instancetype)noNetWorkEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock;

+ (instancetype)systemExceptionEmptyWithClickBlock:(LYActionTapBlock)btnClickBlock;



@end

NS_ASSUME_NONNULL_END
