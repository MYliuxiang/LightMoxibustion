//
//  DeviceCell.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *macL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

NS_ASSUME_NONNULL_END
