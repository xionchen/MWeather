//
//  SubCell.h
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCell : UITableViewCell

@property (nonatomic,weak) UILabel *temperature;
@property (nonatomic,weak) UILabel *weather;
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UILabel *date;

@end
