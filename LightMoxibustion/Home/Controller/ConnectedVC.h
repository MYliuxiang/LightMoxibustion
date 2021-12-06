//
//  ConnectedVC.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/7.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConnectedVC : BaseViewController
@property (strong, nonatomic)   NSArray              *deviceArray;  /**< 蓝牙设备个数 */

@property (nonatomic,copy) void (^connetcBleDeviceblock)(BleDevice *device);
@property (nonatomic,copy) void (^reScanBleDeviceblock)(void);

@end

NS_ASSUME_NONNULL_END
