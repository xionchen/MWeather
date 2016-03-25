//
//  ForecastWeather.m
//  MWeather
//
//  Created by LiDan on 16/3/24.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import "ForecastWeather.h"

@implementation ForecastWeather

+(instancetype) forecastWithDict:(NSDictionary *)dict
{
    ForecastWeather *forecast = [[ForecastWeather alloc]init];
    
    NSArray *split = [dict[@"date"] componentsSeparatedByString:@"-"];
    forecast.date = [NSString stringWithFormat:@"%@月%@日",split[1],split[2]];
    
    NSDictionary *cond = dict[@"cond"];
    if(![cond[@"txt_d"] isEqualToString:cond[@"txt_n"]])
    {
        forecast.weather = [NSString stringWithFormat:@"%@转%@",cond[@"txt_d"],cond[@"txt_n"]];
    }
    else
    {
        forecast.weather = [NSString stringWithFormat:@"%@",cond[@"txt_d"]];
    }
    
    NSDictionary *tmp = dict[@"tmp"];
    forecast.temperature = [NSString stringWithFormat:@"%@℃ ~ %@℃",tmp[@"min"],tmp[@"max"]];
    
    
    return forecast;
}

@end
