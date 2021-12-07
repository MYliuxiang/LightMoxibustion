//
//  TimeView.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/3.
//

#import "TimeView.h"
@interface TimeView()
@property(nonatomic,strong)UIImageView *minute1I;
@property(nonatomic,strong)UIImageView *minute2I;
@property(nonatomic,strong)UIImageView *colonI;

@property(nonatomic,strong)UIImageView *second1I;
@property(nonatomic,strong)UIImageView *second2I;

@end

@implementation TimeView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self creatSubView];

    }
    
    return self;
}

- (void)creatSubView{
    
    CGFloat width = (self.width - 12) / 6.0;
    
    _minute1I = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width , self.height)];
    [self addSubview:_minute1I];
    
    _minute2I = [[UIImageView alloc] initWithFrame:CGRectMake(self.width /6.0, 0, width, self.height)];
    [self addSubview:_minute2I];
    
    _colonI = [[UIImageView alloc] initWithFrame:CGRectMake(self.width /6.0 * 3, self.height / 4.0, self.height / 4.0, self.height / 2.0)];
    _colonI.centerX = self.width / 2.0;
    _colonI.image = [UIImage imageNamed:@"b_num_seg_point"];
    [self addSubview:_colonI];
    
    _second1I = [[UIImageView alloc] initWithFrame:CGRectMake(self.width /6.0 * 4, 0, width, self.height)];
    [self addSubview:_second1I];
    
    _second2I = [[UIImageView alloc] initWithFrame:CGRectMake(self.width /6.0 * 5, 0, width, self.height)];
    [self addSubview:_second2I];
    
    self.time = 0;
    
   
}

- (void)setTime:(int)time
{
    if (time > 60 * 60 && time < 0) {
        return;
    }
    _time = time;
    
    int minute = _time / 60;
    
    [self layoutImgswithNumber:minute / 10 imagView:self.minute1I];
    [self layoutImgswithNumber:minute % 10 imagView:self.minute2I];
    
    int second = _time % 60;
    [self layoutImgswithNumber:second / 10 imagView:self.second1I];
    [self layoutImgswithNumber:second % 10 imagView:self.second2I];

}


- (void)layoutImgswithNumber:(int)number imagView:(UIImageView *)imageView{
    
    UIImage *image;
    switch (number) {
        case 0:{
            image = [UIImage imageNamed:@"b_num_seg_0"];
        }
            break;
        case 1:{
            image = [UIImage imageNamed:@"b_num_seg_1"];
        }
            break;
        case 2:{
            image = [UIImage imageNamed:@"b_num_seg_2"];
        }
            break;
        case 3:{
            image = [UIImage imageNamed:@"b_num_seg_3"];
        }
            break;
        case 4:{
            image = [UIImage imageNamed:@"b_num_seg_4"];
        }
            break;
        case 5:{
            image = [UIImage imageNamed:@"b_num_seg_5"];
        }
            break;
        case 6:{
            image = [UIImage imageNamed:@"b_num_seg_6"];
        }
            break;
        case 7:{
            image = [UIImage imageNamed:@"b_num_seg_7"];
        }
            break;
        case 8:{
            image = [UIImage imageNamed:@"b_num_seg_8"];
        }
            break;
        case 9:{
            image = [UIImage imageNamed:@"b_num_seg_9"];
        }
            break;
            
        default:{
            image = [UIImage imageNamed:@"b_num_seg_0"];
        }
            break;
    }
    
    imageView.image = image;
    
    
}

@end
