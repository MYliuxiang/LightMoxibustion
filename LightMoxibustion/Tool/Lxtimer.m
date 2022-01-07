//
//  Lxtimer.m
//  LightMoxibustion
//
//  Created by flyliu on 2022/1/7.
//

#import "Lxtimer.h"
@interface Lxtimer ()


@property(nonatomic,strong)NSTimer *timer;

@end

@implementation Lxtimer
+ (Lxtimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{
    
    Lxtimer *timer = [[Lxtimer alloc] init];
    timer.timer = [NSTimer scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
//    [timer.timer setFireDate:[NSDate distantFuture]];
    timer.runState = YES;
    return timer;
}

- (void)start{
    if (!self.runState) {
        self.runState = YES;
        [self.timer setFireDate:[NSDate date]];
    }
}
- (void)stop{
    self.runState = NO;
    [self.timer setFireDate:[NSDate distantFuture]];

}

@end
