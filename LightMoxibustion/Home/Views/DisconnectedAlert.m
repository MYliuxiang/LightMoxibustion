//
//  DisconnectedAlert.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/27.
//

#import "DisconnectedAlert.h"

@implementation DisconnectedAlert

- (instancetype)initAlert{
    
    self = [super init];
    if (self) {
        
        self.width = kScreenWidth - 100;
        self.doneB.layer.cornerRadius = 15;
        self.doneB.layer.masksToBounds = YES;
        
        [self setupAutoHeightWithBottomView:self.doneB bottomMargin:30];
        
        LXViewBorder(self, 5);
                       
    }
    return self;
    
}

- (IBAction)doneAC:(id)sender {
    [self disMiss];
}

@end
