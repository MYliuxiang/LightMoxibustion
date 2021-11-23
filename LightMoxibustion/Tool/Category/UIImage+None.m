//
//  UIImage+None.m
//  Pos
//
//  Created by tenvine on 2021/6/28.
//

#import "UIImage+None.h"
#import <objc/runtime.h>


@implementation UIImage (None)
+(void)load{
    
    Method imageNamed = class_getClassMethod(self,@selector(imageNamed:));
    Method looha_ImageNamed =class_getClassMethod(self,@selector(looha_none_imageNamed:));
    method_exchangeImplementations(imageNamed, looha_ImageNamed);
   
}

+(instancetype)looha_none_imageNamed:(NSString*)name{
 
    if (![name isEqualToString:@""]) {//判断是否为空的方法，不提供，自行搞定
        
      return  [self looha_none_imageNamed:name];
        
    }else{
        
        return nil;
    }
}
@end
