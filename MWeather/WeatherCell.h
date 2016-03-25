//
//  MainCell.h
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UIButton

@property (nonatomic,weak) UILabel *cityName;
@property (nonatomic,weak) UILabel *temperature;
@property (nonatomic,weak) UILabel *currentTemp;
@property (nonatomic,weak) UILabel *weather;
@property (nonatomic,weak) UILabel *dayWeather;
@property (nonatomic,weak) UILabel *date;
@property (nonatomic,weak) UIImageView *icon;

@end
