//
//  HomeVC.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "HomeVC.h"

#import "CRC16.h"
#import "IntToByte.h"
#import "MLMProgressView.h"
#import "CustomSliderView.h"
#import "LxUnitSlider.h"
#import "HRNumberUnitView.h"
#import "DevicesVC.h"


#define PROGRESS_HEIGHT 200
#define LEFT_MAGAN 55 * WidthScale



@interface HomeVC ()<LxUnitSliderDelegate>

@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,strong) CBCharacteristic *txcharacter;
@property(nonatomic,strong) CBCharacteristic *rxcharacter;
#pragma mark ----------- Constraint -----------

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quantityHC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quantityWC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navCH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgCE;

@property (nonatomic, strong) LxUnitSlider *rateSlider;
@property (nonatomic, strong) LxUnitSlider *redSlider;
@property (nonatomic, strong) LxUnitSlider *temSlider;
@property (nonatomic, strong) MLMProgressView *progress;




@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.title = @"首页";
    self.customNavBar.hidden = YES;
    self.deviceArray = [NSMutableArray array];
    [self creatSubViews];
    [self sizeofWidth];
    
        
//蓝牙模块
//    [self scanDevice];
//    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1
//                                                   target:self
//                                                 selector:@selector(sendHeartBeat:)
//                                                   userInfo:nil
//                                                  repeats:YES];
//    [self.timer setFireDate:[NSDate distantFuture]];
//
//    [self setBlueCallBack];

}

#pragma mark ----------- LxUnitSliderDelegate -----------
- (void)unitSliderView:(LxUnitSlider *)slider didChangePercent:(NSInteger)percent
{
    NSLog(@"percent:%d",percent);
    
}

#pragma mark --------------蓝牙回调处理--------------
- (void)setBlueCallBack{
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    manager.didDisconnectBlock = ^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"蓝牙断开连接了 %@",error);
        self.rxcharacter = nil;
        self.txcharacter = nil;
        [self.timer setFireDate:[NSDate distantFuture]];
        [self scanDevice];

    };
    manager.receiveDataBlock = ^(NSData *data) {
        int cmd = [HandleData verificationData:data];
        U8 *mbuf = (U8 *)data.bytes;

        switch (cmd) {
            case 0:
            {
                NSLog(@"数据验证失败");
            }
                break;
            case 3:
            {
                NSLog(@"设置温度成功");
                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
                
            }
                break;
            case 4:
            {
                NSLog(@"设置频率成功");
                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);

            }
                break;
            case 6:
            {
                NSLog(@"设置激光档位成功");
                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);

            }
                break;
                
            case 8:
            {
                QuantityModel *quantityModel = [[QuantityModel alloc] initWithData:data];
                NSLog(@"更新电量:%d",quantityModel.quantity);

            }
                break;
            case 9:
            {
                CurrentTemModel *tem = [[CurrentTemModel alloc] initWithData:data];
//                NSLog(@"实时温度:%d",tem.currentTem);

            }
                break;
            case 10:
            {
                WorkCountdownModel *workCuountdown = [[WorkCountdownModel alloc] initWithData:data];
//                NSLog(@"工作倒计时:%ds",workCuountdown.second);
            }
                break;
            case 11:
            {
                CurrentLaserModel *currentLaser = [[CurrentLaserModel alloc] initWithData:data];
                NSLog(@"获取激光设置档位:%d",currentLaser.laser);
            }
                break;
                
            case 12:
            {
                CurrentRateModel *currentRate = [[CurrentRateModel alloc] initWithData:data];
                NSLog(@"获取当前灯光闪动频率档位:%d",currentRate.rate);
            }
                break;
                
            case 13:
            {
                CurrentTemModel *currentTem = [[CurrentTemModel alloc] initWithData:data];
                NSLog(@"获取仪器当前的设置温度:%d",currentTem.currentTem);
            }
                break;
            case 15:
            {
                VersionModel *version = [[VersionModel alloc] initWithData:data];
                NSLog(@"获取仪器的固件版本号:%@",version.version);
            }
                break;
            case 16:
            {
                ChargeStateModel *stateModel = [[ChargeStateModel alloc] initWithData:data];
                NSLog(@"CHG信号:%d,STANDBY信号:%d",stateModel.CHG,stateModel.STANDBY);
            }
                break;
                
            case 18:
            {
                NSLog(@"设置工作时间（弧形）成功");
                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
            }
                break;
                
            case 20:
            {
                CurrentSetTimeModel *setTime = [[CurrentSetTimeModel alloc] initWithData:data];
                NSLog(@"获取仪器当前的设置时间:%d",setTime.second);
            }
                break;
                
            default:
                break;
        }
        
    };
}

- (void)scanDevice{
    //开始扫描
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    
    __weak HLBLEManager *weakManager = manager;
    manager.stateUpdateBlock = ^(CBCentralManager *central) {
        NSString *info = nil;
        switch (central.state) {
            case CBManagerStatePoweredOn:
                info = @"蓝牙已打开，并且可用";
                //三种种方式
                // 方式1
                //                [weakManager scanForPeripheralsWithServiceUUIDs:@[[HLBLEManager devServiceUUID]] options:nil];
                [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil];
                break;
                
            case CBManagerStatePoweredOff:
                info = @"蓝牙可用，未打开";
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:info ];
                break;
            case CBManagerStateUnsupported:
                info = @"SDK不支持";
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:info ];
                break;
            case CBManagerStateUnauthorized:
                info = @"程序未授权";
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:info ];
                break;
            case CBManagerStateResetting:
                info = @"CBCentralManagerStateResetting";
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:info ];
                break;
            case CBManagerStateUnknown:
                info = @"CBCentralManagerStateUnknown";
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD showInfoWithStatus:info ];
                break;
        }
    };
    
    
    manager.discoverPeripheralBlcok = ^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        if (peripheral.name.length <= 0 || [peripheral.name rangeOfString:@"PEL-IR_ACUPUNCTURE"].location == NSNotFound) {
            return ;
        }
        
        BleDevice *per = [[BleDevice alloc] init];
        per.peripheral = peripheral;
        per.deviceName = peripheral.name;
        per.uuidString = peripheral.identifier.UUIDString;
        NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
        NSString *mac =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        mac = [mac stringByReplacingOccurrencesOfString:@" " withString:@""];
        per.macAddress = mac;
        per.RSSI = RSSI;
        
        NSString *lastMac = [NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:MACADRESS]];
        if ([lastMac isEqualToString:per.uuidString]) {
            [self connectDevice:per];
        }
        
        if (self.deviceArray.count == 0) {
            [self.deviceArray addObject:per];
        } else {
            BOOL isExist = NO;
            for (int i = 0; i < self.deviceArray.count; i++) {
                BleDevice *device = [self.deviceArray objectAtIndex:i];
                if([device.uuidString isEqualToString:peripheral.identifier.UUIDString]){
                    isExist = YES;
                    [_deviceArray replaceObjectAtIndex:i withObject:device];
                }
                
            }
            
            if (!isExist) {
                [self.deviceArray addObject:per];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DeviceChange object:@{@"devices":self.deviceArray}];
        
    };
}

- (void)connectDevice:(BleDevice *)device{
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    [manager connectPeripheral:device.peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:YES
               servicesOptions:nil
        characteristicsOptions:nil
                 completeBlock:^(HLOptionStage stage, CBPeripheral *peripheral, CBService *service, CBCharacteristic *character, NSError *error) {
                     switch (stage) {
                         case HLOptionStageConnection:
                         {
                             if (error) {
                                 [SVProgressHUD showErrorWithStatus:@"连接失败"];
                                 
                             } else {
                                 //连接成功
                                 //需要每隔两秒发送心跳包
                                 NSLog(@"连接成功");
                                 [LxUserDefaults setObject:peripheral.identifier.UUIDString forKey:MACADRESS];
                                 if (self.navigationController.viewControllers.count > 1) {
                                     [self.navigationController popToRootViewControllerAnimated:YES];
                                 }

                             }
                             break;
                         }
                         case HLOptionStageSeekServices:
                         {
                             if (error) {
                                 NSLog(@"查找服务失败");
                             } else {
                               
                                 NSLog(@"查找服务成功");

                             }
                             break;
                         }
                         case HLOptionStageSeekCharacteristics:
                         {
                             // 该block会返回多次，每一个服务返回一次
                             if (error) {
                                 NSLog(@"查找特性失败");
                             } else {
                                  NSLog(@"查找特性成功");
                             }
                             break;
                         }
                         case HLOptionStageSeekdescriptors:
                         {
                             // 该block会返回多次，每一个特性返回一次
                            
                             if (error) {
                                 NSLog(@"查找特性的描述失败");
                             } else {
                                 if ([character.UUID.UUIDString isEqualToString:[HLBLEManager txCharacteristicUUID].UUIDString]){
                                     [self.timer setFireDate:[NSDate date]];
                                 }
                                 
                             }
                             break;
                         }
                         default:
                             break;
                     }
                     
                 }];
}

- (void)sendHeartBeat:(NSTimer *)timer{
    [SendData sendHeartBeat];
}


#pragma mark --------------发送蓝牙数据--------------

- (IBAction)connectDeviceAC:(id)sender {
    DevicesVC *vc = [[DevicesVC alloc] init];
    vc.deviceArray = self.deviceArray;
    
    __weak typeof(self) weakSelf = self;
    vc.connetcBleDeviceblock = ^(BleDevice * _Nonnull device) {
        [weakSelf connectDevice:device];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)setTem:(id)sender {
    
    [SendData setTemperature:30];
    
}

- (IBAction)setRate:(id)sender {
    [SendData setRate:2];
}

- (IBAction)setLaser:(id)sender {
    [SendData setLaser:2];
}

- (IBAction)updateQuantity:(id)sender {
    
    [SendData updateQuantiy];
}

- (IBAction)getCurrentLaser:(id)sender {
    [SendData getCurrentLaser];
}

- (IBAction)getCurrentRate:(id)sender {
    
    [SendData getCurrentRate];
}

- (IBAction)getCurrentTem:(id)sender {
    
    [SendData getCurrentTem];
}

- (IBAction)getVersion:(id)sender {
    [SendData getVersion];
}

- (IBAction)getChargeState:(id)sender {
    [SendData getChargeState];
}

- (IBAction)setCurrentWorkTime:(id)sender {
    [SendData setCurrentWorkTime:5];
}

- (IBAction)GetCurrentSetTimePkg:(id)sender {
    [SendData getCurrentSetTime];

}



- (void)creatSubViews{
    _progress = [[MLMProgressView alloc] initWithFrame:CGRectMake(LEFT_MAGAN , Height_StatusBar + 44 * WidthScale + 28 * WidthScale, (kScreenWidth - 2 * LEFT_MAGAN), kScreenWidth - 2 * LEFT_MAGAN)];
    [self.view addSubview:[_progress speedDialType]];
    __weak typeof(self) weakSelf = self;

    [_progress tapHandle:^{
        [weakSelf.progress.circle setProgress:1];
        [weakSelf.progress.incircle setProgress:1];

    }];
    
    
    _rateSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale, kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"常亮",@"1",@"2",@"3",@"4",@"5"] total:5.0 thumbTitle:@"频率"];
    _rateSlider.delegate = self;
    [self.view addSubview:_rateSlider];
    _rateSlider.centerX = kScreenWidth / 2.0;
    
    _temSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale , kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:50.0 thumbTitle:@"温度"];
    _temSlider.delegate = self;
    [self.view addSubview:_temSlider];
    
    _temSlider.right = kScreenWidth / 2.0 - 80 * WidthScale / 2;

        
    _redSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale, kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale)  titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:5.0 thumbTitle:@"红光"];
    _redSlider.delegate = self;
    [self.view addSubview:_redSlider];
    _redSlider.left = kScreenWidth / 2.0 + 80 * WidthScale / 2;
    
}

- (void)sizeofWidth{
    _titleHC.constant = _titleHC.constant * WidthScale;
    _titleWC.constant = _titleWC.constant * WidthScale;
    _quantityHC.constant = _quantityHC.constant * WidthScale;
    _quantityWC.constant = _quantityWC.constant * WidthScale;
    _navCH.constant = _navCH.constant * WidthScale;
    _bgCE.constant = - (fabs(_bgCE.constant) * WidthScale);
    

}

@end
