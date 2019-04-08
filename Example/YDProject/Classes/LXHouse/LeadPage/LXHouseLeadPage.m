//
//  LXHouseLeadPage.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/4/2.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXHouseLeadPage.h"

@interface LXHouseLeadPage ()

/** 引导页图片数组 */
@property (nonatomic, copy) NSArray *imageArray;

@property(nonatomic, strong) UIPageControl *pageControl;


@end

@implementation LXHouseLeadPage

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 0;
    
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    
    
    // Do any additional setup after loading the view.
    [self setupUI];
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    
    [self.view addSubview:self.pageControl];
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.imageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    UIImage *image = self.imageArray[indexPath.row];
    UIImageView *imageView = [self imageViewFromCell:cell];
    imageView.image = image;
    
    UIButton *finishBtn = [self finishButtonFromCell:cell];
    finishBtn.hidden = indexPath.row != self.imageArray.count - 1;
    
    return cell;
}



- (UIImageView *)imageViewFromCell:(UICollectionViewCell *)cell
{
    UIImageView *imageView = [cell.contentView viewWithTag:123];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.tag = 123;
        [cell.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
    }
    return imageView;
}


- (UIButton *)finishButtonFromCell:(UICollectionViewCell *)cell
{
    UIButton *btn = [cell.contentView viewWithTag:321];
    if (!btn) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 321;
        UIImage *image = [UIImage imageNamed:@"lead_finish_btn"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(cell.contentView.mas_centerX);
            make.bottom.equalTo(cell.contentView.mas_bottom).offset(-18);
            make.size.mas_equalTo(image.size);
        }];
    }
    
    
    return btn;
}


- (void)finishAction
{
    !_finishHandle ? : _finishHandle();
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = round(scrollView.contentOffset.x / kScreenWidth);
    if (page != _pageControl.currentPage) {
        _pageControl.currentPage = page;
    }
    
    //最后一张图过半隐藏
    _pageControl.hidden = scrollView.contentOffset.x > (self.imageArray.count - 1.5) * kScreenWidth;
}



#pragma mark - lazyload
- (NSArray *)imageArray
{
    if (!_imageArray) {
        UIImage *image_1 = [UIImage imageNamed:@"ling.jpg"];
        UIImage *image_2 = [UIImage imageNamed:@"meizi.jpg"];
        UIImage *image_3 = [UIImage imageNamed:@"bajie.jpg"];
        
        _imageArray = @[image_1, image_2, image_3];
    }
    
    return _imageArray;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        
        _pageControl.numberOfPages = self.imageArray.count;
        _pageControl.currentPageIndicatorTintColor = rgb(163, 197, 18);
        _pageControl.pageIndicatorTintColor = rgb(237, 237, 237);
        _pageControl.currentPage = 1;
        // 设置center
        _pageControl.center = CGPointMake(kScreenWidth * 0.5, kScreenHeight - 24);
        
    }
    
    return _pageControl;
}

@end
