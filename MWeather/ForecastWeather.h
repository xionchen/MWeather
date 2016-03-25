//
//  ForecastWeather.h
//  MWeather
//
//  Created by LiDan on 16/3/24.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastWeather : NSObject

@property (nonatomic,copy) NSString *temperature;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *weather;

+(instancetype) forecastWithDict:(NSDictionary *)dict;

@end
