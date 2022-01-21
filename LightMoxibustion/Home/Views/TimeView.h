//
//  TimeView.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/3.
//

/*
 时间led显示效果
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeView : UIView
@property(nonatomic,assign)int time;
@property(nonatomic,strong) UIColor *tintColor;

- (id)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
