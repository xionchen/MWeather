//
//  MainController.m
//  MWeather
//
//  Created by LiDan on 16/3/15.
//  Copyright © 2016年 com.lidan. All rights reserved.
//

#import "MainController.h"
#import "Default.pch"
#import "WeatherCell.h"
#import "SubCell.h"
#import "CalendarCell.h"
#import "WeatherModel.h"
#import "ForecastWeather.h"
#import "UIImageView+WebCache.h"

@interface MainController() <UISearchBarDelegate>

@property (nonatomic,assign) NSInteger R;
@property (nonatomic,assign) NSInteger G;
@property (nonatomic,assign) NSInteger B;

@property (nonatomic,strong) WeatherCell *weatherCell;
@property (nonatomic,strong) WeatherModel *weatherModel;
@property (nonatomic,strong) NSMutableArray *forecastArray;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,assign) BOOL switchTip;

@end

@implementation MainController

-(NSMutableArray *)forecastArray
{
    if (!_forecastArray)
    {
        _forecastArray = [NSMutableArray array];
    }
    return _forecastArray;
}

-(WeatherCell *)weatherCell
{
    if (!_weatherCell)
    {
        _weatherCell = [[WeatherCell alloc]init];
        _weatherCell = [[WeatherCell alloc]init];
        [_weatherCell addTarget:self action:@selector(weatherClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weatherCell;
}

-(NSArray *)basicArrary
{
    if (!_basicArrary)
    {
        _basicArrary = [NSArray array];
    }
    return _basicArrary;
}

-(WeatherModel *)weatherModel
{
    if(!_weatherModel)
    {
        _weatherModel = [[WeatherModel alloc]init];
    }
    return _weatherModel;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setInit];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [self requestWithCity:searchBar.text];
    [self saveCityName:searchBar.text];
    [self.tableView reloadData];
    [self.weatherCell setNeedsLayout];
}

-(void)setInit
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.delegate = self;
    [self.view addSubview:self.searchBar];
    NSString *cityName = [self loadCityName];
    if (cityName == NULL)
    {
        cityName = @"beijing";
    }
    [self requestWithCity:cityName];
}

-(void)saveCityName:(NSString *)cityName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cityName forKey:@"cityName"];
    [defaults synchronize];
}

-(NSString *)loadCityName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *cityName = [defaults objectForKey:@"cityName"];
    return cityName;
}

-(void)requestWithCity:(NSString *)cityName
{
    NSString *key = @"93dd697eeeae4c61a283d82dd78afdb1";
    NSString *city = cityName;
    NSString *httpurl = [NSString stringWithFormat:@"https://api.heweather.com/x3/weather?city=%@&key=%@",city,key];
    NSURL *url = [NSURL URLWithString:httpurl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error)
    {
        NSLog(@"Httperror: %@%ld", error.localizedDescription, error.code);
    }
    else
    {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *allArray = dict[@"HeWeather data service 3.0"];
        NSDictionary *dicts = allArray[0];
        self.weatherModel = [WeatherModel weatherWithDict:dicts];
        NSArray *tmpArray = dicts[@"daily_forecast"];
        int count = 0;
        if (self.forecastArray.count != 0)
        {
            self.forecastArray = nil;
        }
        for (NSDictionary *dict in tmpArray)
        {
            if (count != 0)
            {
                ForecastWeather * forecast = [ForecastWeather forecastWithDict:dict];
                [self.forecastArray addObject:forecast];
            }
            count ++;
        }
    }
    _R = arc4random() % 190 + 50;
    _G = arc4random() % 190 + 50;
    _B = arc4random() % 190 + 50;
    self.weatherCell.backgroundColor = RGBColor(_R, _G, _B);
}

-(void)weatherClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationFade];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.weatherCell.isSelected)
    {
        return self.forecastArray.count;
    }
    else if(section == 1)
    {
        return 0;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubCell *cell;
    NSInteger rowIndex = indexPath.row + 1;
    cell = [[SubCell alloc]init];
    cell.backgroundColor = RGBColor(_R - 12 * rowIndex, _G - 12 * rowIndex, _B - 12 * rowIndex);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ForecastWeather *forecast = self.forecastArray[indexPath.row];
    cell.temperature.text = forecast.temperature;
    cell.date.text = forecast.date;
    cell.weather.text = forecast.weather;
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    if (scrollView.contentOffset.y < 0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.searchBar.frame = CGRectMake(0, -44, self.view.width, 44);
            self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
        }];
        self.switchTip = YES;
    }
    else if (scrollView.contentOffset.y > -44)
    {
        self.searchBar.frame = CGRectMake(0, 0, 0, 0);
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.switchTip = NO;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        self.weatherCell.cityName.text = self.weatherModel.city;
        if (self.weatherCell.cityName.text.length == 4)
        {
            self.weatherCell.cityName.font = [UIFont systemFontOfSize:35];
        }
        else if(self.weatherCell.cityName.text.length == 3)
        {
            self.weatherCell.cityName.font = [UIFont systemFontOfSize:40];
        }
        else
        {
            self.weatherCell.cityName.font = [UIFont systemFontOfSize:48];
        }
        self.weatherCell.currentTemp.text = [NSString stringWithFormat:@"%@℃",self.weatherModel.temperature];
        self.weatherCell.weather.text = self.weatherModel.weather;
        self.weatherCell.date.text = self.weatherModel.date;
        self.weatherCell.temperature.text = self.weatherModel.minMaxWeather;
        self.weatherCell.dayWeather.text = self.weatherModel.dayWeather;
        self.weatherCell.backgroundColor = RGBColor(_R, _G, _B);
        [self.weatherCell.icon sd_setImageWithURL:[NSURL URLWithString:self.weatherModel.iconUrl]];
        return self.weatherCell;
    }
    else
    {
        CalendarCell * calendarcell = [[CalendarCell alloc]init];
        calendarcell.backgroundColor = RandomColor;
        return calendarcell;
    }
}

@end
