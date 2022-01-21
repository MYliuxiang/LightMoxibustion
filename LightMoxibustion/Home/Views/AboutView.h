//
//  AboutView.h
//  LightMoxibustion
//
//  Created by 刘翔 on 2021/12/18.
//

/*关于toast*/

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface AboutView : LxCustomAlert
@property (weak, nonatomic) IBOutlet UILabel *appVersionL;
@property (weak, nonatomic) IBOutlet UILabel *blueVersionL;
@property (weak, nonatomic) IBOutlet UIButton *doneB;

- (instancetype)initAlert;
@end

NS_ASSUME_NONNULL_END
