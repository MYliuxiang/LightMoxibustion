//
//  NumberView.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/3.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TemperatureType)
{
    TemperatureTypeSet           = 0,
    TemperatureTypeCurrent,
   
};

NS_ASSUME_NONNULL_BEGIN

@interface NumberView : UIView
@property(nonatomic,assign)int  number;
- (id)initWithFrame:(CGRect)frame withTemType:(TemperatureType)type;
@end

NS_ASSUME_NONNULL_END
