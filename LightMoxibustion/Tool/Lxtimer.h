//
//  Lxtimer.h
//  LightMoxibustion
//
//  Created by flyliu on 2022/1/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lxtimer : NSObject
@property(nonatomic,assign)BOOL runState;


+ (Lxtimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;

- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
