//
//  BleDevice.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

/*
 蓝牙设备模型
 */

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface BleDevice : NSObject
@property(nonatomic,strong) CBPeripheral *peripheral;
@property(nonatomic,copy) NSString *deviceName;
@property(nonatomic,copy) NSString *uuidString;
@property(nonatomic,copy) NSString *macAddress;
@property(nonatomic,assign) NSNumber *RSSI;

@end

NS_ASSUME_NONNULL_END
