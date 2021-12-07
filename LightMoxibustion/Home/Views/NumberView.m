//
//  NumberView.m
//  LightMoxibustion
//
//  Created by flyliu on 2021/12/3.
//

#import "NumberView.h"

@interface NumberView()
@property(nonatomic,strong)UIImageView *firstImg;
@property(nonatomic,strong)UIImageView *sencondImg;
@property(nonatomic,assign)TemperatureType type;


@end

@implementation NumberView
-(id)initWithFrame:(CGRect)frame withTemType:(TemperatureType)type{
    self = [super initWithFrame:frame];
    if(self){
        self.type = type;
        [self creatSubView];

    }
    
    return self;
}

- (void)creatSubView{
    
    _firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width / 2.0 - 2, self.height)];
    [self addSubview:_firstImg];
    
    _sencondImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.width / 2.0 + 1,0, self.width / 2.0 - 2, self.height)];
    [self addSubview:_sencondImg];
    
    self.number = -1;
}

- (void)setNumber:(int)number
{
    _number = number;
    if (_number == -1) {
           
        self.firstImg.image = [[UIImage imageNamed:@"b_seg_o" ] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
           
        self.sencondImg.image = [[UIImage imageNamed:@"b_seg_f"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
        if (_type == TemperatureTypeSet) {
            self.firstImg.tintColor = [UIColor blackColor];
            self.sencondImg.tintColor = [UIColor blackColor];

        }else{
            self.firstImg.tintColor = [UIColor redColor];
            self.sencondImg.tintColor = [UIColor redColor];
        }
        return;
    }
    
    int first = number / 10;
    [self layoutImgswithNumber:first imagView:self.firstImg];
    
    int sencond = number % 10;
    [self layoutImgswithNumber:sencond imagView:self.sencondImg];
        
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
    
    imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    if (_type == TemperatureTypeSet) {
        imageView.tintColor = [UIColor blackColor];
    }else{
        imageView.tintColor = [UIColor redColor];
    }
    
}




@end
