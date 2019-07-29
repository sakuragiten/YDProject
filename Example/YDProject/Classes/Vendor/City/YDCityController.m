//
//  YDCityController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/7/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "YDCityController.h"

@interface YDCityController ()


@property (nonatomic, strong) UITableView *tableView;



@end

@implementation YDCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    [self getCityList];
}



- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}


- (void)getCityList
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Area" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *result = dict[@"result"];
    
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    for (int i = 0; i < result.count; i ++) {
        NSArray *subResult = result[i];
        for (NSDictionary *cityDict in subResult) {
            NSString *key = cityDict[@"fullname"];
            if (key.length == 0) {
                NSLog(@"%@", cityDict);
                key = @"没有城市名";
            }
            [tmp setObject:cityDict forKey:key];
            
        }
    }
    
    [self filterArea:tmp];
    
    
    
    
    
//
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *newPath = [path stringByAppendingPathComponent:@"newCity.json"];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmp options:NSJSONWritingPrettyPrinted error:nil];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    [jsonData writeToFile:newPath atomically:YES];
//
//
//
//    NSLog(@"%@", newPath);
}




- (void)filterArea:(NSDictionary *)areaDict
{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    NSArray *cityArray = [self getCityArray];
    for (NSString *cityName in cityArray) {
        if (!areaDict[cityName]) {
//            NSLog(@"%@", cityName);
        } else {
            [tmp setObject:areaDict[cityName] forKey:cityName];
        }
        if ([cityName isEqualToString:@"荆门市"]) {
            NSLog(@"%@", areaDict[cityName]);
        }
    }
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    NSString *newPath = [path stringByAppendingPathComponent:@"filterCity.json"];
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tmp options:NSJSONWritingPrettyPrinted error:nil];
//    [jsonData writeToFile:newPath atomically:YES];
    
    
    [self formateCity];
}





- (NSArray *)getCityArray
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *provinces = dict[@"provinces"];
    
    
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSDictionary *p in provinces) {
        NSArray *citys = p[@"citys"];
        for (NSDictionary *cityDict in citys) {
            [tmp addObject:cityDict[@"citysName"]];
        }
    }
    
    
    return tmp;
}



- (void)formateCity
{
    //    NSLog(@"%@", cityDict);
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filterCity" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *cityDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    //    NSLog(@"%@", cityDict);
    NSMutableDictionary *tmp = [NSMutableDictionary dictionary];
    for (NSString *cityName in cityDict.allKeys) {
        NSDictionary *city = cityDict[cityName];
        
        
        NSString *fullname = city[@"fullname"];
        NSString *name = city[@"name"];
        if (name.length == 0) {
            if ([fullname containsString:@"市"]) {
                name = [fullname substringToIndex:fullname.length - 1];
                if (name.length < 2) {
                    name = fullname;
                }
            }
        }
        if (name.length == 0) {
            NSLog(@"找不到城市名 %@ - %@",cityName,  fullname);
        }
        
        NSMutableString *pinYin = [NSMutableString string];
        NSArray *pyArray = city[@"pinyin"];
        if (pyArray.count) {
            for (int i = 0; i < pyArray.count; i ++) {
                [pinYin appendString:pyArray[i]];
            }
        } else {
            NSLog(@"没有拼音 %@ - %@", cityName, [self transformPinYinWithString:cityName]);
        }
        
        
        
    }
}

- (NSString *)transformPinYinWithString:(NSString *)chinese
{
    NSString  * pinYinStr = [NSString string];
    if (chinese.length){
        NSMutableString * pinYin = [[NSMutableString alloc]initWithString:chinese];
        //1.先转换为带声调的拼音
        if(CFStringTransform((__bridge CFMutableStringRef)pinYin, NULL, kCFStringTransformMandarinLatin, NO)) {
            //            NSLog(@"带声调的pinyin: %@", pinYin);
        }
        //2.再转换为不带声调的拼音
        if (CFStringTransform((__bridge CFMutableStringRef)pinYin, NULL, kCFStringTransformStripDiacritics, NO)) {
            //            NSLog(@"不带声调的pinyin: %@", pinYin);
        }
        //3.去除掉首尾的空白字符和换行字符
        pinYinStr = [pinYin stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //4.去除掉其它位置的空白字符和换行字符
        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        pinYinStr = [pinYinStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        //        NSLog(@"去掉空白字符和换行字符的pinyin: %@", pinYinStr);
        [pinYinStr capitalizedString];
        
    }
    return pinYinStr;
}




@end


/*
冀州市
潞城市
临安市
长乐市
莱芜市
即墨市
宜州市
韩城
华阴
兴平
 */
