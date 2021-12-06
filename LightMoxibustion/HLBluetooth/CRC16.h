//
//  CRC16.h
//  LightMoxibustion
//
//  Created by flyliu on 2021/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

int CRC16_CCITT(unsigned char *bytes,int len);
@interface CRC16 : NSObject

@end

NS_ASSUME_NONNULL_END
