//
//  DevicesVC.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import "DevicesVC.h"
#import "DeviceCell.h"
#import "HLBLEManager.h"
#import "HomeVC.h"


@interface DevicesVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation DevicesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceChange:) name:DeviceChange object:nil];
    
       
}

- (void)deviceChange:(NSNotification *)noti
{
    self.deviceArray = noti.object[@"devices"];
    [self.tableView reloadData];
}

#pragma  mark --------UITableView Delegete----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifire = @"cellID";
    DeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    BleDevice *device = [self.deviceArray objectAtIndex:indexPath.row];
    cell.titleL.text = [NSString stringWithFormat:@"名称:%@",device.deviceName];
    cell.macL.text = [NSString stringWithFormat:@"MAC:%@",device.uuidString];
    if (device.peripheral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BleDevice *device = self.deviceArray[indexPath.row];
    if (self.connetcBleDeviceblock) {
        self.connetcBleDeviceblock(device);
    }
}

- (void)connectDevice:(BleDevice *)device{
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    
    [manager connectPeripheral:device.peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:YES
               servicesOptions:@[[HLBLEManager servicesUUID]]
        characteristicsOptions:@[[HLBLEManager txCharacteristicUUID],[HLBLEManager rxCharacteristicUUID]]
                 completeBlock:^(HLOptionStage stage, CBPeripheral *peripheral, CBService *service, CBCharacteristic *character, NSError *error) {
                     switch (stage) {
                         case HLOptionStageConnection:
                         {
                             if (error) {
                                 [SVProgressHUD showErrorWithStatus:@"连接失败"];
                                 
                             } else {
                                 [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                                 //需要每隔两秒发送心跳包
                                 
                                 
                             }
                             break;
                         }
                         case HLOptionStageSeekServices:
                         {
                             if (error) {
                                 [SVProgressHUD showSuccessWithStatus:@"查找服务失败"];
                             } else {
//                                 [SVProgressHUD showSuccessWithStatus:@"查找服务成功"];
//                                 [_infos addObjectsFromArray:peripheral.services];
//                                 [_tableView reloadData];
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
//                                 NSLog(@"查找特性的描述成功");
                             }
                             break;
                         }
                         default:
                             break;
                     }
                 }];
}



@end
