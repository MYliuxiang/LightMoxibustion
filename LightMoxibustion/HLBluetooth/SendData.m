//
//  SendData.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import "SendData.h"
#import "HeartbeatPkg.h"
#import "HLBLEManager.h"
#import "TemperaturePkg.h"
#import "RatePkg.h"
#import "LaserPkg.h"
#import "QuantityPkg.h"
#import "CurrentLaserPkg.h"
#import "CurrentRatePkg.h"
#import "CurrentTemPkg.h"
#import "VersionPkg.h"
#import "ChargeStatePkg.h"
#import "SetWorkTimePkg.h"
#import "GetCurrentSetTimePkg.h"



@implementation SendData

+ (void)sendHeartBeat{
    
    HeartbeatPkg *pkg = [[HeartbeatPkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];

}

+ (void)setTemperature:(int)temperature{
    
    TemperaturePkg *pkg = [[TemperaturePkg alloc] initWithTemperature:temperature];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
    [self getCurrentTem];
    
}

+ (void)setRate:(int)rate{
    
    NSLog(@"设置频率:%d",rate);
    RatePkg *pkg = [[RatePkg alloc] initWithRate:rate];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
    [self getCurrentRate];
    
}

+ (void)setLaser:(int)laser{
    
    NSLog(@"设置激光:%d",laser);
    LaserPkg *pkg = [[LaserPkg alloc] initWithLaser:laser];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
    [self getCurrentLaser];

}

+ (void)updateQuantiy{
    
    QuantityPkg *pkg = [[QuantityPkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getCurrentLaser{
    
    CurrentLaserPkg *pkg = [[CurrentLaserPkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getCurrentRate{
    
    CurrentRatePkg *pkg = [[CurrentRatePkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getCurrentTem{
    
    CurrentTemPkg *pkg = [[CurrentTemPkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getVersion{
    
    VersionPkg *pkg = [[VersionPkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getChargeState{
    
    ChargeStatePkg *pkg = [[ChargeStatePkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)setCurrentWorkTime:(int)minute{
    
    SetWorkTimePkg *pkg = [[SetWorkTimePkg alloc] initWithMinute:minute];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}

+ (void)getCurrentSetTime{
    
    GetCurrentSetTimePkg *pkg = [[GetCurrentSetTimePkg alloc] init];
    HLBLEManager *manger = [HLBLEManager sharedInstance];
    [manger writeValue:pkg.buf];
}


@end
