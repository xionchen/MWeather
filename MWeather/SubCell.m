//
//  SubCell.m
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import "SubCell.h"
#import "Default.pch"

@interface SubCell()



@end

@implementation SubCell

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setInit];
    }
    return self;
}

-(void)setInit
{
    
    UILabel *temperature = [[UILabel alloc]init];
    temperature.text = @"15℃ ~ 25℃ ";
    [temperature setTextColor:[UIColor whiteColor]];
    temperature.font = [UIFont systemFontOfSize:18];
    
    UILabel *weather = [[UILabel alloc]init];
    weather.text = @"晴";
    [weather setTextColor:[UIColor whiteColor]];
    weather.font = [UIFont systemFontOfSize:18];
    
    UILabel *date = [[UILabel alloc]init];
    date.text = @"3月15日";
    [date setTextColor:[UIColor whiteColor]];
    date.font = [UIFont systemFontOfSize:18];
    
    UIImageView *icon = [[UIImageView alloc]init];
    [icon setImage:[UIImage imageNamed:@"sun16"]];
    
    [self addSubview:temperature];
    [self addSubview:weather];
    [self addSubview:date];
    [self addSubview:icon];
    
    self.temperature = temperature;
    self.weather = weather;
    self.date = date;
    self.icon = icon;
}

-(void)layoutSubviews
{
    
    self.date.x = 40;
    self.date.y = 25;
    self.date.width = [self setViewSize:self.date.font Text:self.date.text].width;
    self.date.height = [self setViewSize:self.date.font Text:self.date.text].height;

    self.temperature.x = self.date.x + self.date.width + 20;
    self.temperature.y = self.date.y;
    self.temperature.width = [self setViewSize:self.temperature.font Text:self.temperature.text].width;
    self.temperature.height = [self setViewSize:self.temperature.font Text:self.temperature.text].height;
    
    self.weather.width = [self setViewSize:self.weather.font Text:self.weather.text].width;
    self.weather.height = [self setViewSize:self.weather.font Text:self.weather.text].height;
    self.weather.x = self.width - self.weather.width - 30;
    self.weather.y = self.date.y;
    
    self.icon.x = self.weather.x + self.weather.width + 5;
    self.icon.y = self.date.y - 5;
    self.icon.width = 30;
    self.icon.height = 30;
}

-(CGSize)setViewSize:(UIFont *)font Text:(NSString *)text
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(self.width, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}


@end
