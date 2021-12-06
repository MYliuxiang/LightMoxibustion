//
//  DevicesVC.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DevicesVC : UIViewController
@property (strong, nonatomic)   NSArray              *deviceArray;  /**< 蓝牙设备个数 */

@property (nonatomic,copy) void (^connetcBleDeviceblock)(BleDevice *device);

@end

NS_ASSUME_NONNULL_END
