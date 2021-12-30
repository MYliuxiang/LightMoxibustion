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
#import "LxView.h"
#import "DisconnectedAlert.h"


#define PROGRESS_HEIGHT 200
#define LEFT_MAGAN 60 * WidthScale



@interface HomeVC ()<LxUnitSliderDelegate>

@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) NSTimer *animationTimer;
@property(nonatomic,strong) NSTimer *chargeAnimationTimer;

@property(nonatomic,strong) NSTimer *temAnimationTimer;

@property(nonatomic,strong) NSTimer *quantityAnimationTimer;

@property(nonatomic,strong) UILabel *quantityTemL;
@property(nonatomic,strong) UILabel *temTipL;


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
@property (weak, nonatomic) IBOutlet UIButton *laserB;

@property (nonatomic, strong) LxView *laserConnectedV;
@property (nonatomic, strong) LxView *blueConnectedV;

@property (nonatomic, assign) BOOL autoDisconnect;

//@property (nonatomic, assign) BOOL highTemTip;

@property (nonatomic, assign) BOOL menumIsHidden;



@property (weak, nonatomic) IBOutlet UIImageView *quantityI;
@property (weak, nonatomic) IBOutlet UIImageView *laserStateI;


@property (nonatomic, strong) UIView *blueTapV;

@property (nonatomic, assign) BOOL isLower;








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
        
    [self hanleConnectedState];
    [self checkBluethState];
    //蓝牙模块
    [self scanDevice];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:1
                                                   target:self
                                                 selector:@selector(sendHeartBeat:)
                                                   userInfo:nil
                                                  repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
    
    
    self.animationTimer =  [NSTimer scheduledTimerWithTimeInterval:0.35
                                                   target:self
                                                 selector:@selector(animationAC)
                                                   userInfo:nil
                                                  repeats:YES];
    
    
    

    self.chargeAnimationTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(chargeAnimation)
                                                   userInfo:nil
                                                  repeats:YES];
    [self.chargeAnimationTimer setFireDate:[NSDate distantFuture]];
    
    self.temAnimationTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(temAnimation)
                                                   userInfo:nil
                                                  repeats:YES];
    [self.temAnimationTimer setFireDate:[NSDate distantFuture]];
    
    
    self.quantityAnimationTimer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(quantityAnimation)
                                                   userInfo:nil
                                                  repeats:YES];
    [self.quantityAnimationTimer setFireDate:[NSDate distantFuture]];

    [self setBlueCallBack];

}

#pragma mark ----------- LxUnitSliderDelegate -----------
- (void)unitSliderView:(LxUnitSlider *)slider didChangePercent:(NSInteger)percent
{

    
}

#pragma mark ----------- 动画 -----------
static int imageindex = 0;

- (void)chargeAnimation{
    imageindex++;
    if (imageindex >= 4) {
        imageindex = 0;
    }
    
    NSArray *imageArr = @[[UIImage imageNamed:@"bl0"],[UIImage imageNamed:@"bl1"],[UIImage imageNamed:@"bl2"],[UIImage imageNamed:@"bl3"]];
    self.quantityI.image = imageArr[imageindex];
    
}

- (void)temAnimation{
    self.temTipL.hidden = !self.temTipL.hidden;
}

- (void)quantityAnimation{
    self.quantityTemL.hidden = !self.quantityTemL.hidden;

}

- (void)animationAC{
  
    self.blueStateI.hidden = !self.blueStateI.hidden;
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
//                NSLog(@"设置温度成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
                
            }
                break;
            case 4:
            {
//                NSLog(@"设置频率成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);

            }
                break;
            case 6:
            {
//                NSLog(@"设置激光档位成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
//                NSLog(@"%@",data);


            }
                break;
                
            case 8:
            {
                QuantityModel *quantityModel = [[QuantityModel alloc] initWithData:data];
                switch (quantityModel.quantity) {
                    case 0:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl0"];
                        [self.quantityAnimationTimer setFireDate:[NSDate date]];

                        self.isLower = YES;
                    }
                        break;
                    case 1:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl1"];
                        [self.quantityAnimationTimer setFireDate:[NSDate distantFuture]];
                        self.isLower = NO;

                    }
                        break;
                    case 2:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl2"];
                        [self.quantityAnimationTimer setFireDate:[NSDate distantFuture]];
                        self.isLower = NO;

                    }
                        break;
                    case 3:
                    {
                        self.quantityI.image = [UIImage imageNamed:@"bl3"];
                        [self.quantityAnimationTimer setFireDate:[NSDate distantFuture]];
                        self.isLower = NO;
                     

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
                WorkCountdownModel *workCuountdown = [[WorkCountdownModel alloc] initWithData:data];
//                if (workCuountdown.second == 0) {
//                    [SendData getCurrentSetTime];
//                }
                [self.progress configWorkDownSencond:workCuountdown.second withTintColor:[UIColor blackColor]];
//                NSLog(@"倒计时%d",workCuountdown.second);
                
                
            }
                break;
            case 11:
            {

                CurrentLaserModel *currentLaser = [[CurrentLaserModel alloc] initWithData:data];
                self.redSlider.currentPercent = currentLaser.laser;
                if (currentLaser.laser == 0) {
                    self.laserStateI.image = [UIImage imageNamed:@"text_laser_off"];
                    self.laserConnectedV.hidden = YES;
                }else{
                    self.laserStateI.image = [UIImage imageNamed:@"text_laser_on"];
                    self.laserConnectedV.hidden = NO;

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
                if (currentTem.currentTem < 30) {
                    [SendData getCurrentSetTime];
                    [self.progress configIsTouch:YES];
                }else{
                    [self.progress configIsTouch:NO];

                }
                if (currentTem.currentTem > 45) {
                    [self.progress configSetTem:currentTem.currentTem withTintColor:[UIColor yellowColor]];
                    if(!self.isLower){
                      [self.temAnimationTimer setFireDate:[NSDate date]];
                    }
                    

                }else{
                    [self.progress configSetTem:currentTem.currentTem withTintColor:[UIColor blackColor]];
                    [self.temAnimationTimer setFireDate:[NSDate distantFuture]];
                }
                
                NSLog(@"当前设置温度：%d",currentTem.currentTem);
//                NSLog(@"highTemTip：%d",self.highTemTip);

            }
                break;   
            case 15:
            {
                VersionModel *version = [[VersionModel alloc] initWithData:data];
                [LxUserDefaults setObject:version.version forKey:BlueVersion];
                
                AboutView *view = [[AboutView alloc] initAlert];
                [view show];
               
            }
                break;
            case 16:
            {
                ChargeStateModel *stateModel = [[ChargeStateModel alloc] initWithData:data];
//                当CHG为0 与SATANDBY 为1时表示正在充电，CHG为1与STANDBY为0表示充电完成。其它情况表示没有插入充电器。
                if (stateModel.CHG == 0 && stateModel.STANDBY == 1) {
                    [self.chargeAnimationTimer setFireDate:[NSDate date]];
                }else{
                    [self.chargeAnimationTimer setFireDate:[NSDate distantFuture]];

                }
                NSLog(@"CHG信号:%d,STANDBY信号:%d",stateModel.CHG,stateModel.STANDBY);
            }
                break;
                
            case 18:
            {
//                NSLog(@"设置工作时间（弧形）成功");
//                NSLog(@"第三位：%d,第四位：%d",mbuf[3],mbuf[4]);
            }
                break;
                
            case 19:
            {
                CurrentSetTimeModel *setTime = [[CurrentSetTimeModel alloc] initWithData:data];
                [self.progress configSetTime:setTime.second];
                [self.progress configWorkDownSencond:setTime.second * 60 withTintColor:[UIColor blueColor]];
//                NSLog(@"设置时间%d",setTime.second);             
            }
                break;
                
            default:
                break;
        }
        
    };
}
#pragma mark ----------- 蓝牙链接状态处理 -----------
- (void)checkBluethState{
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    manager.stateUpdateBlock = ^(CBCentralManager *central) {
        NSString *info = nil;
        switch (central.state) {
            case CBManagerStatePoweredOn:
                info = @"蓝牙已打开，并且可用";
                [self scanDevice];
                break;
                
            case CBManagerStatePoweredOff:
                info = @"蓝牙未打开，请前往设置打开";
//                [HLBLEManager sharedInstance].connectedPerpheral = nil;
                [SVProgressHUD showErrorWithStatus:info];
                break;
            case CBManagerStateUnsupported:
                info = @"SDK不支持";
                [SVProgressHUD showErrorWithStatus:info];

                break;
            case CBManagerStateUnauthorized:
                info = @"程序未授权，请前往设置种授权";
                [SVProgressHUD showErrorWithStatus:info];
                break;
            case CBManagerStateResetting:
                info = @"CBCentralManagerStateResetting";
                [SVProgressHUD showErrorWithStatus:info];

                break;
            case CBManagerStateUnknown:
                info = @"CBCentralManagerStateUnknown";
                [SVProgressHUD showErrorWithStatus:info];
                break;
        }
        [self hanleConnectedState];
    };
}

#pragma mark ----------- 扫描蓝牙设备 -----------
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
        U8 *mbuf = (U8 *)data.bytes;
        if (mbuf != NULL) {
            NSString *mac =[[NSString alloc] initWithFormat:@"%.2x:%.2x:%.2x:%.2x:%.2x:%.2x",mbuf[0],mbuf[1],mbuf[2],mbuf[3],mbuf[4],mbuf[5]];
            per.macAddress = mac;
        }
       
        per.RSSI = RSSI;
        
        NSString *lastMac = [NSString stringWithFormat:@"%@",[LxUserDefaults objectForKey:MACADRESS]];
        if ([lastMac isEqualToString:per.macAddress] && weakManager.connectedPerpheral == nil && !self.autoDisconnect ) {
               
            UIApplicationState state = [UIApplication sharedApplication].applicationState;
            if(state == UIApplicationStateActive){
                [self connectDevice:per];
             }
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

#pragma mark ----------- 链接蓝牙 -----------
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

#pragma mark ----------- 发送心跳包 -----------
- (void)sendHeartBeat:(NSTimer *)timer{
    [SendData sendHeartBeat];
}


- (IBAction)blueAC:(id)sender {
    self.menumIsHidden = !self.menumIsHidden;
    [self annimationMenumIsHidden:self.menumIsHidden];
    
}

#pragma mark ----------- 链接成功之后初始化蓝牙 -----------
- (void)initBlue{
    //初试化蓝牙
    [SendData sendHeartBeat];
    [self.timer setFireDate:[NSDate date]];
    [SendData updateQuantiy];
    
    [SendData getCurrentLaser];

    [SendData getCurrentRate];
    
    [SendData getCurrentTem];
    
    [SendData getCurrentSetTime];
    
    [SendData getChargeState];

    
    
            

}

#pragma mark ----------- 蓝牙链接状态UI处理逻辑 -----------
- (void)hanleConnectedState{
    if ([HLBLEManager sharedInstance].connectedPerpheral == nil) {
        //断开链接
                
        _blueConnectedV.hidden = YES;

//        self.highTemTip = NO;
        self.rxcharacter = nil;
        self.txcharacter = nil;
        [self.timer setFireDate:[NSDate distantFuture]];
        if (_autoDisconnect) {
            UIApplicationState state = [UIApplication sharedApplication].applicationState;
            if(state == UIApplicationStateActive){
                [self scanDevice];
                    
             }
        }
        
        self.blueStateI.image = [[UIImage imageNamed:@"text_no_connect"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.blueStateI.tintColor = [UIColor redColor];
        self.laserStateI.image = [UIImage imageNamed:@"text_laser_off"];
        
        self.redSlider.currentPercent = 0;
        self.temSlider.currentPercent = 0;
        self.rateSlider.currentPercent = 0;
        
        [self.progress configSetTem:-1 withTintColor:[UIColor blackColor]];
        [self.progress configCurrentTem:-1];
        [self.progress configWorkDownSencond:0 withTintColor:[UIColor blueColor]];
        [self.progress configSetTime:0];
        
        self.progress.userInteractionEnabled = NO;
        self.redSlider.userInteractionEnabled = NO;
        self.rateSlider.userInteractionEnabled = NO;
        self.temSlider.userInteractionEnabled = NO;
        [self.animationTimer setFireDate:[NSDate date]];
        
        [self.chargeAnimationTimer setFireDate:[NSDate distantFuture]];
        self.quantityI.image = [UIImage imageNamed:@"bl3"];
        
        [self.temAnimationTimer setFireDate:[NSDate distantFuture]];
        [self.quantityAnimationTimer setFireDate:[NSDate distantFuture]];

        self.temTipL.hidden = YES;
        self.quantityTemL.hidden = YES;
        self.isLower = NO;
        
    }else{
        
        NSLog(@"连接成功");
        _blueConnectedV.hidden = NO;
     
        [[NSNotificationCenter defaultCenter] postNotificationName:DeviceChange object:@{@"devices":self.deviceArray}];
        self.autoDisconnect = NO;
        self.blueStateI.image = [[UIImage imageNamed:@"text_bel_connected"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.blueStateI.tintColor = [UIColor whiteColor];
        
        self.progress.userInteractionEnabled = YES;
        self.redSlider.userInteractionEnabled = YES;
        self.rateSlider.userInteractionEnabled = YES;
        self.temSlider.userInteractionEnabled = YES;
        [self.animationTimer setFireDate:[NSDate distantFuture]];
        self.blueStateI.hidden = NO;


    }
}


#pragma mark ----------- 创建试图 -----------
- (void)creatSubViews{
    
    __weak typeof(self) weakSelf = self;
    
    _quantityTemL = [[UILabel alloc] init];
    _quantityTemL.text = @"光灸仪电量过低，无法启动工作";
    _quantityTemL.font = [UIFont systemFontOfSize:16 * WidthScale];
    _quantityTemL.textColor = [UIColor redColor];
    _quantityTemL.numberOfLines = 0;
    _quantityTemL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_quantityTemL];
    [_quantityTemL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.mas_equalTo(Height_StatusBar + 34 * WidthScale);
    }];
    _quantityTemL.hidden = YES;
    

   
    
    
    _temTipL = [[UILabel alloc] init];
    _temTipL.text = @"温度设置过高，因人而异，请注意是否会灼伤您的皮肤！";
    _temTipL.font = [UIFont systemFontOfSize:14 * WidthScale];
    _temTipL.textColor = [UIColor redColor];
    _temTipL.numberOfLines = 0;
    _temTipL.textAlignment = NSTextAlignmentCenter;

    [self.view addSubview:_temTipL];
    
    [_temTipL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.mas_equalTo(Height_StatusBar + 34 * WidthScale);
    }];
    _temTipL.hidden = YES;
   
    
    _progress = [[MLMProgressView alloc] initWithFrame:CGRectMake(LEFT_MAGAN , Height_StatusBar + 44 * WidthScale + 60 * WidthScale, (kScreenWidth - 2 * LEFT_MAGAN), kScreenWidth - 2 * LEFT_MAGAN)];
    _progress.cancleBlock = ^{
//        weakSelf.highTemTip = NO;
    };
   
    [self.view addSubview:[_progress speedDialType]];
    _progress.progress = 0.5;
    [_progress configSetTime:10];
    
    
    _rateSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale, kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"常亮",@"1",@"2",@"3",@"4",@"5"] total:5.0 thumbTitle:@"频率"];
    _rateSlider.delegate = self;
    [self.view addSubview:_rateSlider];
    _rateSlider.centerX = kScreenWidth / 2.0;
    
    _temSlider = [[LxUnitSlider alloc]initWithFrame:CGRectMake(100, (kScreenHeight + 100) / 2.0 + 10 * WidthScale, 80 * WidthScale , kScreenHeight - (kScreenHeight + 100) / 2.0 - kBottomSafeHeight - 10 * WidthScale) titles:@[@"关闭",@"1",@"2",@"3",@"4",@"5"] total:22.0 thumbTitle:@"温度"];
    _temSlider.delegate = self;
    [self.view addSubview:_temSlider];
    
    _temSlider.right = kScreenWidth / 2.0 - 80 * WidthScale / 2;
    
    _temSlider.hightTemTipBlock = ^(int tem) {
        if (tem > 45) {
            [weakSelf.progress hightTemTip:tem];
        }else{
            [SendData setTemperature:tem];
        }
//        weakSelf.highTemTip = tem > 45 ?  YES : NO;
                    
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
    
    _laserConnectedV = [[LxView alloc] init];
    _laserConnectedV.frame = CGRectMake(0, 0, 25, 25);
    _laserConnectedV.layer.cornerRadius = 12.5;
    _laserConnectedV.layer.masksToBounds = YES;
    _laserConnectedV.backgroundColor = [[UIColor colorWithHexString:@"#ff0000"] colorWithAlphaComponent:0.5];
    _laserConnectedV.hidden = YES;
    [self.laserB addSubview:_laserConnectedV];
    
    _blueConnectedV = [[LxView alloc] init];
    _blueConnectedV.frame = CGRectMake(0, 0, 25, 25);
    _blueConnectedV.layer.cornerRadius = 12.5;
    _blueConnectedV.layer.masksToBounds = YES;
    _blueConnectedV.backgroundColor = [[UIColor colorWithHexString:@"#00ff00"] colorWithAlphaComponent:0.3];
    _blueConnectedV.hidden = YES;
    [self.blueB addSubview:_blueConnectedV];
    
    _blueTapV = [[UIView alloc] initWithFrame:CGRectMake(self.blueB.left, self.blueB.top - 5, 100, 30)];
    _blueTapV.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:_blueTapV belowSubview:self.blueStateI];
    [_blueTapV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueB.mas_left);
        make.right.equalTo(self.blueStateI.mas_right);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.blueB.mas_centerY);

    }];
    

    [_blueTapV tapHandle:^{
        weakSelf.menumIsHidden = !weakSelf.menumIsHidden;
        [self annimationMenumIsHidden:weakSelf.menumIsHidden];
    }];
  
    
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
            
            if ([HLBLEManager sharedInstance].connectedPerpheral == nil) {
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
            }else{
                DisconnectedAlert *alert = [[DisconnectedAlert alloc] initAlert];
                [alert show];
            }
            
            
            
            
            
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
            
            
//            AboutVC *vc = [[AboutVC alloc] init];
//            vc.version = version.version;
//            [self.navigationController pushViewController:vc animated:YES];
            [SendData getVersion];

            if ([HLBLEManager sharedInstance].connectedPerpheral == nil) {
                AboutView *view = [[AboutView alloc] initAlert];
                [view show];
            }
           
            
            
//            if ([HLBLEManager sharedInstance].connectedPerpheral == nil){
//                [SVProgressHUD showErrorWithStatus:@"请先连接蓝牙"];
//            }else{
//            }
        }
            break;
        case 3:
        {
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

#pragma mark ----------- 闪烁动画 -----------

- (void)blueStateIAnimation:(BOOL)isStart{
    if (isStart) {
        [self.blueStateI.layer removeAnimationForKey:@"opacity"];
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        scaleAnimation.fromValue=@1.f;
        scaleAnimation.toValue=@0;
        scaleAnimation.autoreverses=YES;
        scaleAnimation.repeatCount=MAXFLOAT;
        scaleAnimation.duration=.35f;
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.fillMode = kCAFillModeForwards;
        [self.blueStateI.layer addAnimation:scaleAnimation forKey:@"opacity"];
        
        
    }else{
        [self.blueStateI.layer removeAnimationForKey:@"opacity"];
        
    }
    

}

@end
