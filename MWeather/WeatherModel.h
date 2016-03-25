//
//  WeatherModel.h
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherModel : NSObject

@property (nonatomic,copy) NSString *city;
@property (nonatomic,copy) NSString *temperature;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *weather;
@property (nonatomic,copy) NSString *iconUrl;
@property (nonatomic,copy) NSString *minMaxWeather;
@property (nonatomic,copy) NSString *dayWeather;


+(instancetype) weatherWithDict:(NSDictionary *)dict;

@end
