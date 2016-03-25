//
//  MainCell.m
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import "WeatherCell.h"
#import "Default.pch"

@interface WeatherCell()



@end

@implementation WeatherCell

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setInit];
        self.selected = NO;
    }
    return self;
}

-(void)setInit
{
    UILabel *cityName = [[UILabel alloc]init];
    cityName.text = @"北京";
    [cityName setTextColor:[UIColor whiteColor]];
    cityName.font = [UIFont systemFontOfSize:48];
    
    UILabel *currentTemp = [[UILabel alloc]init];
    currentTemp.text = @"25℃";
    [currentTemp setTextColor:[UIColor whiteColor]];
    currentTemp.font = [UIFont systemFontOfSize:48];
    
    UILabel *temperature = [[UILabel alloc]init];
    temperature.text = @"15℃ ~ 25℃ ";
    [temperature setTextColor:[UIColor whiteColor]];
    temperature.font = [UIFont systemFontOfSize:16];
    
    UILabel *weather = [[UILabel alloc]init];
    weather.text = @"晴";
    [weather setTextColor:[UIColor whiteColor]];
    weather.font = [UIFont systemFontOfSize:16];
    
    UILabel *date = [[UILabel alloc]init];
    date.text = @"3月15日";
    [date setTextColor:[UIColor whiteColor]];
    date.font = [UIFont systemFontOfSize:16];
    
    UILabel *dayWeather = [[UILabel alloc]init];
    dayWeather.text = @"阴到多云";
    [dayWeather setTextColor:[UIColor whiteColor]];
    dayWeather.font = [UIFont systemFontOfSize:16];
    
    UIImageView *icon = [[UIImageView alloc]init];
    [icon setImage:[UIImage imageNamed:@"100.png"]];
    
    [self addSubview:cityName];
    [self addSubview:currentTemp];
    [self addSubview:dayWeather];
    [self addSubview:temperature];
    [self addSubview:weather];
    [self addSubview:date];
    [self addSubview:icon];
    
    self.cityName = cityName;
    self.currentTemp = currentTemp;
    self.dayWeather = dayWeather;
    self.temperature = temperature;
    self.weather = weather;
    self.date = date;
    self.icon = icon;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cityName.x = 40;
    self.cityName.y = 40;
    self.cityName.width = [self setViewSize:self.cityName.font Text:self.cityName.text].width;
    self.cityName.height = [self setViewSize:self.cityName.font Text:self.cityName.text].height;
    
    self.date.x = 40;
    self.date.y = self.cityName.y + self.cityName.height + 10;
    self.date.width = [self setViewSize:self.date.font Text:self.date.text].width;
    self.date.height = [self setViewSize:self.date.font Text:self.date.text].height;
    
    self.temperature.x = self.date.x;
    self.temperature.y = self.date.y + self.date.height + 10;
    self.temperature.width = [self setViewSize:self.temperature.font Text:self.temperature.text].width;
    self.temperature.height = [self setViewSize:self.temperature.font Text:self.temperature.text].height;

    
    self.currentTemp.x = self.cityName.width + 30 + self.cityName.x;
    self.currentTemp.y = self.cityName.y;
    self.currentTemp.width = [self setViewSize:self.currentTemp.font Text:self.currentTemp.text].width;
    self.currentTemp.height = [self setViewSize:self.currentTemp.font Text:self.currentTemp.text].height;
    
    self.dayWeather.width = [self setViewSize:self.dayWeather.font Text:self.dayWeather.text].width;
    self.dayWeather.height = [self setViewSize:self.dayWeather.font Text:self.dayWeather.text].height;
    self.dayWeather.x = self.currentTemp.x + self.currentTemp.width - self.dayWeather.width;
    self.dayWeather.y = self.temperature.y;
    
    self.icon.x = self.currentTemp.x + self.currentTemp.width + 10;
    self.icon.y = self.currentTemp.y;
    self.icon.width = 80;
    self.icon.height = 80;
    
    self.weather.width = [self setViewSize:self.weather.font Text:self.weather.text].width;
    self.weather.height = [self setViewSize:self.weather.font Text:self.weather.text].height;
    self.weather.x = self.currentTemp.x + self.currentTemp.width - self.weather.width;
    self.weather.y = self.date.y;
}

-(CGSize)setViewSize:(UIFont *)font Text:(NSString *)text
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(self.width, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

@end
