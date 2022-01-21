//
//  NumberView.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/3.
//

/*
 温度Led灯显示效果
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TemperatureType)
{
    TemperatureTypeSet           = 0,
    TemperatureTypeCurrent,
   
};

NS_ASSUME_NONNULL_BEGIN

@interface NumberView : UIView
@property(nonatomic,assign)int  number;
@property(nonatomic,strong) UIColor *tintColor;

- (id)initWithFrame:(CGRect)frame withTemType:(TemperatureType)type;
@end

NS_ASSUME_NONNULL_END
