//
//  DisconnectedAlert.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/27.
//

#import "LxCustomAlert.h"

NS_ASSUME_NONNULL_BEGIN

@interface DisconnectedAlert : LxCustomAlert
@property (weak, nonatomic) IBOutlet UIButton *doneB;

- (instancetype)initAlert;

@end

NS_ASSUME_NONNULL_END
