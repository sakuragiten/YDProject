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
    
    CGSize size = [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    static UICollectionViewLayoutAttributes *attr1 = nil;
    if (indexPath.row == 0) {
        attr.frame = CGRectMake(0, 0, size.width, size.height);
    } else {
        CGFloat x = attr1.frame.origin.x + attr1.frame.size.width + self.minimumInteritemSpacing;
        CGFloat viewWidth = CGRectGetWidth(self.collectionView.frame) - x;
        
        if (viewWidth >= size.width) {
            attr.frame = CGRectMake(x, attr1.frame.origin.y, size.width, size.height);
        } else {
            CGFloat y = attr1.frame.origin.y + attr1.bounds.size.height + self.minimumLineSpacing;
            attr.frame = CGRectMake(0, y, size.width, size.height);
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
        for (int i=0; i<count; i++)
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
    
    self.tagsArray = @[@"托尔斯泰", @"tdsfsdfs", @"电费水费", @"打得过大公鸡分公司", @"d", @"dgsdfhggksdkfg", @"特卖", @"严选", @"停售", @"即将开盘", @"商业", @"在售", @"售罄", @"待售"];
    self.contentEdge = UIEdgeInsetsZero;
    self.textEdge = UIEdgeInsetsMake(3, 10, 3, 10);
    self.font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightMedium];
    if (_styleDict == nil) _styleDict = [LXHouseTagStyle houseTagStyleDict];
    
    [self setupUI];
}


- (void)settingTagStyle:(void (^)(LXHouseTagStyle * _Nonnull, NSString * _Nonnull))styleHandle
{
    _styleHandle = styleHandle;
}


- (void)setupUI
{
    [self addSubview:self.collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}


- (void)reloadData
{
    [self.collectionView reloadData];
}



#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tagsArray.count;
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
    CGFloat maxWidth = self.bounds.size.width - self.contentEdge.left - self.contentEdge.right;
    NSDictionary *attributes = @{NSFontAttributeName : self.font};
    CGSize textSize = [tag boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    textSize.width += self.textEdge.left + self.textEdge.right;
    textSize.height += self.textEdge.top + self.textEdge.bottom;
    
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
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"LXTagViewCell"];
    }
    
    return _collectionView;
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

