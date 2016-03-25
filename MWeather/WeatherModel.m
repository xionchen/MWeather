//
//  WeatherModel.m
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel


+(instancetype) weatherWithDict:(NSDictionary *)dict
{
    WeatherModel *weather = [[WeatherModel alloc]init];
    
    NSDictionary *basic = dict[@"basic"];
    weather.city = basic[@"city"];
    
    NSArray *dailyArray = dict[@"daily_forecast"];
    NSDictionary *daily = dailyArray[0];
    NSArray *split = [daily[@"date"] componentsSeparatedByString:@"-"];
    weather.date = [NSString stringWithFormat:@"%@月%@日",split[1],split[2]];
    
    NSDictionary *tmp = daily[@"tmp"];
    weather.minMaxWeather = [NSString stringWithFormat:@"%@℃~%@℃",tmp[@"min"],tmp[@"max"]];
    NSDictionary *dailycond = daily[@"cond"];
    if(![dailycond[@"txt_d"] isEqualToString:dailycond[@"txt_n"]])
    {
        weather.dayWeather = [NSString stringWithFormat:@"全天 %@转%@",dailycond[@"txt_d"],dailycond[@"txt_n"]];
    }
    else
    {
        weather.dayWeather = [NSString stringWithFormat:@"全天 %@",dailycond[@"txt_d"]];
    }
    
    NSDictionary *now = dict[@"now"];
    weather.temperature = now[@"tmp"];
    
    NSDictionary *cond = now[@"cond"];
    weather.weather = cond[@"txt"];
    
    NSString *url = [NSString stringWithFormat:@"http://files.heweather.com/cond_icon/%@.png",cond[@"code"]];
    weather.iconUrl = url;
    
    
    
    return weather;
}

@end
