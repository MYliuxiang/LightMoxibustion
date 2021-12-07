//
//  HomeVC.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import "HomeVC.h"

#import "CRC16.h"
#import "MLMProgressView.h"
#import "LxUnitSlider.h"
#import "HRNumberUnitView.h"
#import "ConnectedVC.h"


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

@property (nonatomic, strong) UIView *meumView;
@property (weak, nonatomic) IBOutlet UIButton *blueB;
@property (weak, nonatomic) IBOutlet UIImageView *blueStateI;

@property (nonatomic, assign) BOOL autoDisconnect;

@property (nonatomic, assign) BOOL highTemTip;


@property (weak, nonatomic) IBOutlet UIImageView *quantityI;
@property (weak, nonatomic) IBOutlet UIImageView *laserStateI;



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
        

    
        
    [self checkBluethState];
    //蓝牙模块
    [self scanDevice];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(sendHeartBeat:)
                                                   userInfo:nil
                                                  repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];

    [self setBlueCallBack];

}

#pragma mark ----------- LxUnitSliderDelegate -----------
- (void)unitSliderView:(LxUnitSlider *)slider didChangePercent:(NSInteger)percent
{
//    if (slider == self.temSlider) {
//        if (!self.highTemTip) {
//            self.highTemTip = YES;
//            [self.progress hightTemTip];
//        }
//    }
//    NSLog(@"percent:%ld",(long)percent);
    
}

#pragma mark --------------蓝牙回调处理--------------
- (void)setBlueCallBack{
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    manager.didDisconnectBlock = ^(CBPeripheral *peripheral, NSError *error) {
        NSLog(@"蓝牙断开连接了 %@",error);
        [self hanleConnectedState];
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
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
                
            }
                break;
            case 4:
            {
                NSLog(@"设置频率成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);

            }
                break;
            case 6:
            {
                NSLog(@"设置激光档位成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);

            }
                break;
                
            case 8:
            {
                QuantityModel *quantityModel = [[QuantityModel alloc] initWithData:data];
                switch (quantityModel.quantity) {
                    case 0:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl0"];
                    }
                        break;
                    case 1:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl1"];

                    }
                        break;
                    case 2:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl2"];

                    }
                        break;
                    case 3:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl3"];

                    }
                        break;
                        
                    default:
                        break;
                }

            }
                break;
            case 9:
            {
                RealTimeTemModel *tem = [[RealTimeTemModel alloc] initWithData:data];
                [self.progress configCurrentTem:tem.tem];

            }
                break;
            case 10:
            {
//                WorkCountdownModel *workCuountdown = [[WorkCountdownModel alloc] initWithData:data];
//                NSLog(@"工作倒计时:%ds",workCuountdown.second);
            }
                break;
            case 11:
            {
                CurrentLaserModel *currentLaser = [[CurrentLaserModel alloc] initWithData:data];
                self.redSlider.currentPercent = currentLaser.laser;
                if (currentLaser.laser == 0) {
                    self.laserStateI.image = [UIImage imageNamed:@"text_laser_off"];
                }else{
                    self.laserStateI.image = [UIImage imageNamed:@"text_laser_on"];
                }

            }
                break;
                
            case 12:
            {
                CurrentRateModel *currentRate = [[CurrentRateModel alloc] initWithData:data];
                self.rateSlider.currentPercent = currentRate.rate;

            }
                break;
                
            case 13:
            {
                CurrentTemModel *currentTem = [[CurrentTemModel alloc] initWithData:data];
                self.temSlider.currentPercent = currentTem.currentTem - 29;
                [self.progress configSetTem:currentTem.currentTem];
                NSLog(@"当前设置温度：%d",currentTem.currentTem);
                
                
            }
                break;
            case 15:
            {
                VersionModel *version = [[VersionModel alloc] initWithData:data];
                AboutVC *vc = [[AboutVC alloc] init];
                vc.version = version.version;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 16:
            {
//                ChargeStateModel *stateModel = [[ChargeStateModel alloc] initWithData:data];
//                NSLog(@"CHG信号:%d,STANDBY信号:%d",stateModel.CHG,stateModel.STANDBY);
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

- (void)checkBluethState{
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
}

- (void)scanDevice{
    //开始扫描
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    if (manager.connectedPerpheral == nil) {
        [self.deviceArray removeAllObjects];
    }else{
        BleDevice *connectedDevice;
        for (BleDevice *device in self.deviceArray) {
            if ([device.peripheral.identifier.UUIDString isEqualToString:manager.connectedPerpheral.identifier.UUIDString]) {
                connectedDevice = device;
            }
        }
        [self.deviceArray removeAllObjects];
        if (connectedDevice) {
            [self.deviceArray addObject:connectedDevice];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DeviceChange object:@{@"devices":self.deviceArray}];
   
    [manager stopScan];
    [manager scanForPeripheralsWithServiceUUIDs:nil options:nil];
    __weak HLBLEManager *weakManager = manager;
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
        if ([lastMac isEqualToString:per.uuidString] && weakManager.connectedPerpheral == nil && !self.autoDisconnect ) {
               
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
                    [self.deviceArray replaceObjectAtIndex:i withObject:per];
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
    self.blueStateI.image = [[UIImage imageNamed:@"text_connecting"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.blueStateI.tintColor = [UIColor whiteColor];
    [self blueStateIAnimation:NO];

    
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    [manager connectPeripheral:device.peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:NO
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
                                 [self hanleConnectedState];
                             }
                             break;
                         }
                         case HLOptionStageSeekServices:
                         {
                             if (error) {
                                 NSLog(@"查找服务失败");
                             } else {
                               
//                                 NSLog(@"查找服务成功");

                             }
                             break;
                         }
                         case HLOptionStageSeekCharacteristics:
                         {
                             // 该block会返回多次，每一个服务返回一次
                             if (error) {
                                 NSLog(@"查找特性失败");
                             } else {
//                                  NSLog(@"查找特性成功");
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
                                     [self initBlue];
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

- (IBAction)getChargeState:(id)sender {
    
    [SendData getChargeState];
}

- (IBAction)setCurrentWorkTime:(id)sender {
    [SendData setCurrentWorkTime:5];
}


- (IBAction)blueAC:(id)sender {
    [self annimationMenumIsHidden:NO];
}

- (void)initBlue{
    //初试化蓝牙
    [SendData sendHeartBeat];
    [self.timer setFireDate:[NSDate date]];
    [SendData updateQuantiy];
    
    [SendData getCurrentLaser];

    [SendData getCurrentRate];
    
    [SendData getCurrentTem];
    
    [SendData getCurrentSetTime];

}

- (void)hanleConnectedState{
    if ([HLBLEManager sharedInstance].connectedPerpheral == nil) {
        //断开链接
        self.highTemTip = NO;
        self.quantityI.image = [UIImage imageNamed:@"bl3"];
        self.rxcharacter = nil;
        self.txcharacter = nil;
        [self.timer setFireDate:[NSDate distantFuture]];
        if (_autoDisconnect) {
            [self scanDevice];
        }
        
//        [self.blueB setImage:[UIImage imageNamed:@"ble_bmp"] forState:UIControlStateNormal];
        self.blueStateI.image = [[UIImage imageNamed:@"text_no_connect"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.blueStateI.tintColor = [UIColor redColor];
        [self blueStateIAnimation:YES];
        self.laserStateI.image = [UIImage imageNamed:@"text_laser_off"];
        
        self.redSlider.currentPercent = 0;
        self.temSlider.currentPercent = 0;
        self.rateSlider.currentPercent = 0;
        
        [self.progress configSetTem:-1];
        [self.progress configCurrentTem:-1];
        
        
    }else{
        
        NSLog(@"连接成功");
        [LxUserDefaults setObject:[HLBLEManager sharedInstance].connectedPerpheral.identifier.UUIDString forKey:MACADRESS];
        [[NSNotificationCenter defaultCenter] postNotificationName:DeviceChange object:@{@"devices":self.deviceArray}];
        self.autoDisconnect = NO;
        //
//        [self.blueB setImage:[UIImage imageNamed:@"ble_bmp"] forState:UIControlStateNormal];
        self.blueStateI.image = [[UIImage imageNamed:@"text_bel_connected"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.blueStateI.tintColor = [UIColor whiteColor];
        [self blueStateIAnimation:NO];


    }
}

- (void)creatSubViews{
    
    _progress = [[MLMProgressView alloc] initWithFrame:CGRectMake(LEFT_MAGAN , Height_StatusBar + 44 * WidthScale + 28 * WidthScale, (kScreenWidth - 2 * LEFT_MAGAN), kScreenWidth - 2 * LEFT_MAGAN)];
    [self.view addSubview:[_progress speedDialType]];
    __weak typeof(self) weakSelf = self;

//    [_progress tapHandle:^{
//        [weakSelf.progress.circle setProgress:1];
//        [weakSelf.progress.incircle setProgress:1];
//
//    }];
    
    
    _rateSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale, kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"常亮",@"1",@"2",@"3",@"4",@"5"] total:5.0 thumbTitle:@"频率"];
    _rateSlider.delegate = self;
    [self.view addSubview:_rateSlider];
    _rateSlider.centerX = kScreenWidth / 2.0;
    
    _temSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale , kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:21.0 thumbTitle:@"温度"];
    _temSlider.delegate = self;
    [self.view addSubview:_temSlider];
    
    _temSlider.right = kScreenWidth / 2.0 - 80 * WidthScale / 2;
    
    _temSlider.hightTemTipBlock = ^(int tem) {
        if (!weakSelf.highTemTip) {
            [weakSelf.progress hightTemTip:tem];
            weakSelf.highTemTip = YES;
        }
    };

        
    _redSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale, kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale)  titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:5.0 thumbTitle:@"红光"];
    _redSlider.delegate = self;
    [self.view addSubview:_redSlider];
    _redSlider.left = kScreenWidth / 2.0 + 80 * WidthScale / 2;
    
    _meumView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 135 * WidthScale, self.blueB.bottom + 20 * WidthScale, 135 * WidthScale, 193 * WidthScale)];
    _meumView.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    _meumView.layer.cornerRadius = 2;
    [self.view addSubview:_meumView];
    
    NSArray *titles = @[@"连接设备",@"断开连接",@"关于",@"退出应用"];
    
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 193 * WidthScale / 4.0 * i, 135 * WidthScale, 193 * WidthScale / 4.0);
        btn.titleLabel.font = [UIFont systemFontOfSize:20];
        btn.tag = i + 100;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20 * WidthScale, 0, 0);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_meumView addSubview:btn];
    }
    _meumView.hidden = YES;
    
    
}

- (void)sizeofWidth{
    _titleHC.constant = _titleHC.constant * WidthScale;
    _titleWC.constant = _titleWC.constant * WidthScale;
    _quantityHC.constant = _quantityHC.constant * WidthScale;
    _quantityWC.constant = _quantityWC.constant * WidthScale;
    _navCH.constant = _navCH.constant * WidthScale;
    _bgCE.constant = - (fabs(_bgCE.constant) * WidthScale);

}

- (void)buttonClicked:(UIButton *)btn{
    NSInteger index = btn.tag - 100;
    switch (index) {
        case 0:
        {
            //连接设备
            ConnectedVC *vc = [[ConnectedVC alloc] init];
            vc.deviceArray = self.deviceArray;
            if ([HLBLEManager sharedInstance].connectedPerpheral == nil) {
                [self scanDevice];
            }

            __weak typeof(self) weakSelf = self;
            vc.connetcBleDeviceblock = ^(BleDevice * _Nonnull device) {
                [weakSelf connectDevice:device];
            };
            vc.reScanBleDeviceblock = ^{
                [weakSelf scanDevice];
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            //断开连接
            NSLog(@"断开连接");
            self.autoDisconnect = YES;
            [[HLBLEManager sharedInstance] cancelPeripheralConnection];
        }
            break;
        case 2:
        {
            //关于
            if ([HLBLEManager sharedInstance].connectedPerpheral == nil){
              
                [SVProgressHUD showErrorWithStatus:@"请先连接蓝牙"];
            }else{
                [SendData getVersion];
            }
        }
            break;
        case 3:
        {
//            [self exitApplication];
            exit(0);

            
        }
            break;
            
        default:
            break;
    }
    
    [self annimationMenumIsHidden:YES];
    
}

- (void)annimationMenumIsHidden:(BOOL)isHidden{
    [UIView animateWithDuration:0.35 animations:^{
        self.meumView.hidden = isHidden;
    }];
}

- (void)exitApplication {
    //直接退，看起来好像是 crash 所以做个动画
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
     if ([animationID compare:@"exitApplication"] == 0) {
        //退出代码
        exit(0);
    }
}

- (void)blueStateIAnimation:(BOOL)isStart{
     
    if (isStart) {
        [self.blueStateI.layer removeAnimationForKey:@"opacity"];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        scaleAnimation.fromValue=@1.f;
        scaleAnimation.toValue=@0.1f;
        scaleAnimation.autoreverses=YES;
        scaleAnimation.repeatCount=MAXFLOAT;
        scaleAnimation.duration=1.f;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.fillMode = kCAFillModeForwards;
        [self.blueStateI.layer addAnimation:scaleAnimation forKey:@"opacity"];
    }else{
        [self.blueStateI.layer removeAnimationForKey:@"opacity"];

    }
    

}

@end
