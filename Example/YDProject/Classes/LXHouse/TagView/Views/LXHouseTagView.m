//
//  LXHouseTagView.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXHouseTagView.h" 

@interface LXHouseTagFlowLayout : UICollectionViewFlowLayout


@end


@implementation LXHouseTagFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    LXHouseTagView *tagView = (LXHouseTagView *)delegate;
    
    CGSize size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    static UICollectionViewLayoutAttributes *attr1 = nil;
    static int numberOfLine = 0;
    if (indexPath.row == 0) {
        attr.frame = CGRectMake(0, 0, size.width, size.height);
        numberOfLine = 0;
    } else {
        attr.frame = CGRectZero;
        if (tagView.maxNumberOfLines == 0 || numberOfLine < tagView.maxNumberOfLines) {
            CGFloat x = attr1.frame.origin.x + attr1.frame.size.width + self.minimumInteritemSpacing;
            CGFloat viewWidth = CGRectGetWidth(self.collectionView.frame) - x;
            
            if (viewWidth >= size.width) {
                attr.frame = CGRectMake(x, attr1.frame.origin.y, size.width, size.height);
            } else {
                numberOfLine ++; //换行了
                if (tagView.maxNumberOfLines == 0 || numberOfLine < tagView.maxNumberOfLines) {
                    CGFloat y = attr1.frame.origin.y + attr1.bounds.size.height + self.minimumLineSpacing;
                    attr.frame = CGRectMake(0, y, size.width, size.height);
                } else {
                    NSLog(@"bkx");
                    return attr;
                }
            }
        }
    }
    attr1 = attr;
    return attr;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *array = [NSMutableArray array];
    NSInteger section = [self.collectionView numberOfSections];
    
    for (int b = 0; b < section; b ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:b];
        //add cells
        for (int i = 0; i<count; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:b];
            
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            
            [array addObject:attributes];
        }
        
    }
    return array;
}
@end






@interface LXHouseTagView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) UICollectionView *collectionView;


@property(nonatomic, copy) void (^styleHandle)(LXHouseTagStyle * _Nonnull style, NSString * _Nonnull title);

/** 文字标签的缓存 */
@property(nonatomic, strong) NSMutableDictionary *tagSizeCache;

/** 不能直接用 maxNumberOfTags 因为可能设置了行数 */
@property(nonatomic, assign) NSInteger maxCount;

@end


static NSDictionary *_styleDict = nil;

@implementation LXHouseTagView


- (instancetype)init
{
    if (self = [super init]) {
        [self setupConfiguration];
    }
    
    return self;
}






- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupConfiguration];
    }
    
    return self;
}

- (void)setupConfiguration
{
    
//    self.tagsArray = @[@"托尔斯泰", @"tdsfsdfs", @"电费水费", @"打得过大公鸡分公司", @"d", @"dgsdfhggksdkfg", @"特卖", @"严选", @"停售", @"即将开盘", @"商业", @"在售", @"售罄", @"待售"];
    self.contentEdge = UIEdgeInsetsZero;
    self.textEdge = UIEdgeInsetsMake(3, 10, 3, 10);
    self.minimumLineSpacing = 6.0;
    self.minimumInteritemSpacing = 6.0;
    
    self.font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightMedium];
//    self.maxNumberOfLines = 2;
    if (_styleDict == nil) _styleDict = [LXHouseTagStyle houseTagStyleDict];
    
    @weakify(self)
    [[[RACObserve(self.collectionView, contentSize)
       skip:1]
      distinctUntilChanged]
     subscribeNext:^(id x) {
         @strongify(self)
         CGFloat height = [x CGSizeValue].height;
         !self.heightRefresh ? : self.heightRefresh(height);
         NSLog(@"%@", x);
    }];
    
    
    [self setupUI];
}





- (void)reloadTagView:(NSArray<NSString *> *)tagsArray heightRefresh:(void (^)(CGFloat))heightRefresh
{
    self.heightRefresh = heightRefresh;
    
    [self reloadTagView:[self sortedTagArray:tagsArray]];
}


- (void)reloadTagView:(NSArray<NSString *> *)tagsArray
{
    if (tagsArray.count == 0) {
        !self.heightRefresh ? : self.heightRefresh(0);
        return;
    }
    
    _tagsArray = tagsArray;
    
    [self reloadData];
}


- (NSArray *)sortedTagArray:(NSArray *)tagArray
{
    //前三个 按 在售 住宅 榜单  中间正常显示  长的放在后面
    NSMutableArray *tmp = [NSMutableArray array];
    NSMutableArray *lengthTagArray = [NSMutableArray array];
    NSMutableArray *bdArray = [NSMutableArray array]; //榜单可以有多种  比如 热卖 热搜 需要同时显示
    NSString *selling, *residence, *special, *strict;
    
    for (NSString *tagName in tagArray) {
        //过滤掉空字符串
        if (tagName.length == 0) continue;
        
        NSString *tag = tagName;
        if (tagName.length > 12) {
            tag = [NSString stringWithFormat:@"%@...", [tagName substringToIndex:12]];
        }
        
        if ([@[@"在售", @"待售",  @"即将开盘", @"售罄", @"尾盘"] containsObject:tag]) {
            selling = tag;
        } else if ([@[@"商业", @"住宅",  @"办公", @"别墅", @"公寓", @"其他"] containsObject:tag]) {
            residence = tag;
        } else if ([tag hasPrefix:@"BD"]) {
            [bdArray addObject:[tag substringFromIndex:2]];
        } else if ([tag isEqualToString:@"特卖"]) {
            special = tag;
        } else if ([tag isEqualToString:@"严选"]) {
            strict = tag;
        } else if (tag.length > 9) {
            [lengthTagArray addObject:tag];
        } else {
            [tmp addObject:tag];
        }
    }
    //严选优先级最高
    
    if (bdArray.count) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, bdArray.count)];
        [tmp insertObjects:bdArray atIndexes:indexSet];
    }
    if (residence) [tmp insertObject:residence atIndex:0];
    if (selling) [tmp insertObject:selling atIndex:0];
    if (special) [tmp insertObject:special atIndex:0];
    if (strict) [tmp insertObject:strict atIndex:0];
    
    
    [tmp addObjectsFromArray:lengthTagArray];
    
    return tmp;
}


- (void)settingTagStyle:(void (^)(LXHouseTagStyle * _Nonnull, NSString * _Nonnull))styleHandle
{
    _styleHandle = styleHandle;
}


- (void)layoutSubviews
{
    
    [self collectionLayout];
}

- (void)collectionLayout
{
    CGFloat x = self.contentEdge.left;
    CGFloat y = self.contentEdge.top;
    CGFloat w = self.frame.size.width - x - self.contentEdge.right;
    CGFloat h = self.frame.size.height - y - self.contentEdge.bottom;
    self.collectionView.frame = CGRectMake(x, y, w, h);
}

- (void)setupUI
{
    [self addSubview:self.collectionView];
    _collectionView.backgroundColor = [UIColor greenColor];
    [self collectionLayout];
}


- (void)reloadData
{
    self.maxCount = [self getMaxCountInLines];
    [self.collectionView reloadData];
}


//指定行数内 最多显示多少个
- (NSInteger)getMaxCountInLines
{
    if (self.maxNumberOfLines > 0) {
        NSInteger numberOfLine = 0;
        CGFloat currentWidth = 0;
        CGFloat space = 0;
        for (int i = 0; i < self.tagsArray.count; i ++) {
            NSString *tag = self.tagsArray[i];
            CGSize size = [self sizeOfTag:tag];
            
            CGFloat needWidth = size.width + space + currentWidth;
            CGFloat contentWidth = self.collectionView.frame.size.width - self.contentEdge.left - self.contentEdge.right;
            if (needWidth < contentWidth) {
                currentWidth = needWidth;
            } else {
                //换行了
                numberOfLine ++;
                if (numberOfLine < self.maxNumberOfLines) {
                    currentWidth = size.width;
                } else {
                    if (self.maxNumberOfTags == 0 || self.maxNumberOfTags > i) {
                        return i > 0 ? i - 1 : 0;
                    } else {
                        return self.maxNumberOfTags;
                    }
                }
            }
            space = self.minimumInteritemSpacing;
        }
        
        return self.tagsArray.count;
        
    } else {
        if (self.maxNumberOfTags == 0) {
            return self.tagsArray.count;
        }
        return self.maxNumberOfTags;
    }
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"maxCount == %ld", self.maxCount);
    return self.maxCount;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LXTagViewCell" forIndexPath:indexPath];
    
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tag = self.tagsArray[indexPath.row];
    
    return [self sizeOfTag:tag];
}


- (CGSize)sizeOfTag:(NSString *)tag
{
    if (self.tagSizeCache[tag]) {
        return [self.tagSizeCache[tag] CGSizeValue];
    }
    
    CGFloat maxWidth = self.bounds.size.width - self.contentEdge.left - self.contentEdge.right;
    NSDictionary *attributes = @{NSFontAttributeName : self.font};
    CGSize textSize = [tag boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    textSize.width += self.textEdge.left + self.textEdge.right;
    textSize.height += self.textEdge.top + self.textEdge.bottom;
    self.tagSizeCache[tag] = [NSValue valueWithCGSize:textSize];
    return textSize;
}



- (void)configCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *tagLabel = [self tagLabelInCell:cell];
    NSString *title = self.tagsArray[indexPath.row];
    LXHouseTagStyle *tagStyle = [self houseTagFromTitle:title];
    
    !_styleHandle ? : _styleHandle(tagStyle, title);
    tagLabel.text = title;
    
    tagLabel.layer.cornerRadius = tagStyle.cornerRadius;
    tagLabel.layer.borderWidth = tagStyle.borderWidth;
    tagLabel.layer.borderColor = tagStyle.borderColor.CGColor;
    tagLabel.textColor = tagStyle.textColor;
    tagLabel.layer.backgroundColor = tagStyle.backgroundColor.CGColor;
    
}


- (UILabel *)tagLabelInCell:(UICollectionViewCell *)cell
{
    UILabel *tagLabel = [cell.contentView viewWithTag:123];
    if (!tagLabel) {
        tagLabel = [[UILabel alloc] init];
        tagLabel.tag = 123;
        tagLabel.font = self.font;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell addSubview:tagLabel];
        
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
    }
    
    return tagLabel;
}


- (LXHouseTagStyle *)houseTagFromTitle:(NSString *)title
{
    LXHouseTagStyle *style = _styleDict[title];
    if (!style) style = [LXHouseTagStyle defaultStyle];
    
    return style;
}




#pragma mark - lazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        LXHouseTagFlowLayout *layout = [[LXHouseTagFlowLayout alloc] init];
        layout.minimumLineSpacing = 10.0;
        layout.minimumInteritemSpacing = 10.0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = self.scrollEnable;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LXTagViewCell"];
    }
    
    return _collectionView;
}

- (NSMutableDictionary *)tagSizeCache
{
    if (!_tagSizeCache) {
        _tagSizeCache = [NSMutableDictionary dictionary];
    }
    return _tagSizeCache;
}


@end













@implementation LXHouseTagStyle

+ (instancetype)defaultStyle
{
    LXHouseTagStyle *style = [[self alloc] init];
    
    style.cornerRadius = 2.0;
    style.borderColor = [UIColor clearColor];
    style.borderWidth = 0.0;
    style.textColor = [UIColor colorWithHexString:@"#798089"];
    style.backgroundColor = [UIColor colorWithHexString:@"#F0F2F5"];
    
    return style;
}


+ (NSDictionary *)houseTagStyleDict
{
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"HouseTagStyle" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSMutableDictionary *styleDict = [NSMutableDictionary dictionary];
    [rootDict.allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        
        NSDictionary *subDict = rootDict[key];
        LXHouseTagStyle *style = [LXHouseTagStyle new];
        style.cornerRadius = [subDict[@"cornerRadius"] floatValue];
        style.borderWidth = [subDict[@"borderWidth"] floatValue];
        style.borderColor = [UIColor colorWithHexString:subDict[@"borderColor"]];
        style.borderColor = [UIColor colorWithHexString:subDict[@"borderColor"]];
        style.textColor = [UIColor colorWithHexString:subDict[@"textColor"]];
        style.backgroundColor = [UIColor colorWithHexString:subDict[@"backgroundColor"]];
        [styleDict setObject:style forKey:key];
    }];
    
    return styleDict;
}





@end

