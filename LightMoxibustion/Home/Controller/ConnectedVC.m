//
//  ConnectedVC.m
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/7.
//

#import "ConnectedVC.h"
#import "DeviceCell.h"

@interface ConnectedVC ()<CBPeripheralDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ConnectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.customNavBar.backgroundColor = [UIColor colorWithHexString:@"#0E81DE"];
    self.customNavBar.title = @"扫描光灸仪中...";
    self.customNavBar.titleLabelFont = [UIFont systemFontOfSize:22];
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceChange:) name:DeviceChange object:nil];
   LxResfreshHeader *header = [LxResfreshHeader headerWithRefreshingBlock:^{
       [self reloadScan];
   }];
   self.tableView.mj_header = header;

}



- (void)reloadScan{
    
    if (self.reScanBleDeviceblock) {
        self.reScanBleDeviceblock();
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
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
    cell.macL.text = [NSString stringWithFormat:@"MAC:%@ Rssi %@ ",device.uuidString, device.RSSI];
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
    [self.navigationController popViewControllerAnimated:YES];
    if (self.connetcBleDeviceblock) {
        self.connetcBleDeviceblock(device);
    }
}


@end
