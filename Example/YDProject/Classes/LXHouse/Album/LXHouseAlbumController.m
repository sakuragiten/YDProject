//
//  LXHouseAlbumController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/10.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXHouseAlbumController.h"

#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import <objc/runtime.h>

@interface LXHouseAlbumController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LXAlbumTitlesDelegate>


@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) LXAlbumTitlesView *albumTitleView;
@property(nonatomic, strong) LXHouseAlbumNavigationView *navgationView;

@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;

@end

@implementation LXHouseAlbumController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    //初始化player数据
    [self videoConfiguration];
}




- (void)setupUI
{
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.navgationView];
    [self.view addSubview:self.albumTitleView];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _albumTitleView.titlesArray = @[@"meizi", @"ling", @"gaoyuanyuan", @"bajie", @"erKang_1", @"dog", @"Elephant"];
    _albumTitleView.titleLabel.text = @"meizi";
    

    [self autoLayout];
    
}

- (void)autoLayout
{
    CGFloat height = 100.0;
    if (@available(iOS 11.0, *)) {
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {
            height = 120;
        }
    }
    [_albumTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(height);
    }];
    
}


- (void)videoConfiguration
{
    /// playerManager
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    
    /// player的tag值必须在cell里设置
    self.player = [ZFPlayerController playerWithScrollView:self.collectionView playerManager:playerManager containerViewTag:100];
    self.player.controlView = self.controlView;
    NSURL *url = [NSURL URLWithString:@"http://www.w3school.com.cn/example/html5/mov_bbb.mp4"];
    self.player.assetURLs = @[url, url, url];
    self.player.shouldAutoPlay = YES;
    self.player.disablePanMovingDirection = ZFPlayerDisablePanMovingDirectionAll;
    /// 1.0是消失100%时候
    self.player.playerDisapperaPercent = 1.0;
    
    @weakify(self)
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
        self.collectionView.scrollsToTop = !isFullScreen;
        if (isFullScreen) {
            self.player.disablePanMovingDirection = ZFPlayerDisablePanMovingDirectionNone;
        } else {
            self.player.disablePanMovingDirection = ZFPlayerDisablePanMovingDirectionAll;
        }
    };
    
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        @strongify(self)
        [self.player.currentPlayerManager replay];
    };
    
}



#pragma mark - 转屏和状态栏
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    /// 如果只是支持iOS9+ 那直接return NO即可，这里为了适配iOS8
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 3) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lx_videoCell" forIndexPath:indexPath];
        UIImageView *imageView = [self videoImageViewFromeCell:cell];
        imageView.image = [UIImage imageNamed:@"erKang_1"];
        UIButton *btn = [self videoPlayButtonFromCell:cell];
        btn.hidden = NO;
        btn.rac_command = [self videoPlayCommandAtIndexPath:indexPath];
        return cell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lx_albumCell" forIndexPath:indexPath];
    
    NSString *imageName = @[@"meizi", @"ling", @"gaoyuanyuan", @"bajie", @"erKang_1", @"dog", @"Elephant"][indexPath.item % 7];
    UIImageView *imageView = [self imageViewFromeCell:cell];
    imageView.image= [UIImage imageNamed:imageName];
    
//
    NSLog(@"item is: %ld", indexPath.item);
    
    return cell;
}


- (UIImageView *)imageViewFromeCell:(UICollectionViewCell *)cell
{
    UIScrollView *scrollView = [cell.contentView viewWithTag:12345];
    if (!scrollView) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.maximumZoomScale = 2.0;
        scrollView.minimumZoomScale = 1.0;
        scrollView.delegate = self;
        scrollView.tag = 12345;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [scrollView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        doubleClick.numberOfTapsRequired = 2;
        [scrollView addGestureRecognizer:doubleClick];
        
        [tap requireGestureRecognizerToFail:doubleClick];
        
        [cell.contentView addSubview:scrollView];
    }
    scrollView.zoomScale = 1.0;
    UIImageView *imageView = [scrollView viewWithTag:54321];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 54321;
        [scrollView addSubview:imageView];
    }
    
    return imageView;
}

- (UIImageView *)videoImageViewFromeCell:(UICollectionViewCell *)cell
{
    UIImageView *imageView = [cell.contentView viewWithTag:100];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [imageView addGestureRecognizer:tap];
        [cell.contentView  addSubview:imageView];
    }
    
    return imageView;
}


- (UIButton *)videoPlayButtonFromCell:(UICollectionViewCell *)cell
{
    UIImageView *imageView = [cell.contentView viewWithTag:100];
    if (!imageView) imageView = [self videoImageViewFromeCell:cell];
    
    UIButton *btn = [imageView viewWithTag:1234567];
    if (!btn) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 44, 44);
        btn.center = cell.contentView.center;
        btn.tag = 1234567;
        [imageView addSubview:btn];
    }
    
    return btn;
}






#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, kScreenHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag == 12345) {
        UIImageView *imageView = [scrollView viewWithTag:54321];
        return imageView;
    }
    
    return nil;
}

// 滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.collectionView) {
        // 滚动页数
        NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
        NSInteger numberOfItem = [self.collectionView numberOfItemsInSection:0];
        if (page < 0 || page >= numberOfItem) return;
        
        [self selectImageAtIndex:page];
        
         [scrollView zf_scrollViewDidEndDecelerating];
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (scrollView == self.collectionView) {
        [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
     if (scrollView == self.collectionView) {
         [scrollView zf_scrollViewDidScrollToTop];
     }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.collectionView) {
        [scrollView zf_scrollViewDidScroll];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (scrollView == self.collectionView) {
        [scrollView zf_scrollViewWillBeginDragging];
    }
    
}


- (void)selectImageAtIndex:(NSInteger)index
{
    if (index == _currentIndex) return;
    
    _currentIndex = index;
    
    [self setCurrentTitleAtIndex:index];
    self.albumTitleView.selectIndex = index % 7;
}


#pragma mark - LXAlbumTitlesDelegate
- (void)albumTitleView:(LXAlbumTitlesView *)titleView didSelectTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"did select %@", title);
    
    self.currentIndex = index;
}






#pragma mark - action

/** singal click */
- (void)singleTap:(UITapGestureRecognizer *)tap
{
    BOOL hidden = !self.navgationView.isHidden;
    
    [self setNavigationViewAndAlbumsViewHidden:hidden];
}



/** double click */
- (void)doubleClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"double click");
    
    UIScrollView *scrollView = (UIScrollView *)tap.view;
    
    CGFloat scale = scrollView.zoomScale > 1 ? 1 : 1.6;
    [scrollView setZoomScale:scale animated:YES];
}

- (RACCommand *)videoPlayCommandAtIndexPath:(NSIndexPath *)indexPath
{
    @weakify(self)
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(UIButton *sender) {
        sender.hidden = YES;
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}

#pragma mark - play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    [self.player playTheIndexPath:indexPath scrollToTop:scrollToTop];
    LXNewHouseImageModel *model = [LXNewHouseImageModel new];
    model.videoUrl = @"meizi";
    [self.controlView showTitle:@"" coverURLString:model.videoUrl placeholderImage:nil fullScreenMode:ZFFullScreenModeLandscape];
//    [self.controlView showTitle:@"没有标题"
//                 coverURLString:model.videoUrl
//                 fullScreenMode:ZFFullScreenModeLandscape];
}


#pragma mark - setter
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    [self selectImageAtIndex:currentIndex];
    
    [self.collectionView setContentOffset:CGPointMake(currentIndex * self.collectionView.bounds.size.width, 0)];
}

- (void)setImageModelArray:(NSArray *)imageModelArray
{
    _imageModelArray = imageModelArray;
    
    [self.collectionView reloadData];
    
    [self setCurrentIndex:_currentIndex];
    
}

- (void)setCurrentTitleAtIndex:(NSInteger)index
{
    self.navgationView.title = [NSString stringWithFormat:@"%ld/%ld", index + 1, self.imageModelArray.count];
    self.albumTitleView.titleLabel.text = [NSString stringWithFormat:@"index of image is: %ld", index];
}
- (void)setNavigationViewAndAlbumsViewHidden:(BOOL)hidden
{
    [self.navgationView setNavigationView:hidden animated:YES];
    [self.albumTitleView setAlbumTitleView:hidden animated:YES];
}



#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.zf_scrollViewDirection = ZFPlayerScrollViewDirectionHorizontal;
        /// 停止的时候找出最合适的播放
        @weakify(self)
        _collectionView.zf_scrollViewDidStopScrollCallback = ^(NSIndexPath * _Nonnull indexPath) {
            @strongify(self)
            [self playTheVideoAtIndexPath:indexPath scrollToTop:NO];
        };
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"lx_albumCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"lx_videoCell"];
    }
    
    return _collectionView;
}

- (LXHouseAlbumNavigationView *)navgationView
{
    if (!_navgationView) {
        
        _navgationView = [LXHouseAlbumNavigationView new];
        
        _navgationView.backAction = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                if (self.navigationController) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else if (self.presentedViewController){
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    
    return _navgationView;
}

- (LXAlbumTitlesView *)albumTitleView
{
    if (!_albumTitleView) {
        
        _albumTitleView = [LXAlbumTitlesView new];
        _albumTitleView.delegate = self;
    }
    
    return _albumTitleView;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
        _controlView.fastViewAnimated = YES;
        _controlView.effectViewShow = NO;
        _controlView.autoHiddenTimeInterval = 10.0;
        _controlView.customDisablePanMovingDirection = YES;
        @weakify(self)
        [[_controlView rac_signalForSelector:@selector(gestureSingleTapped:)] subscribeNext:^(id x) {
            @strongify(self)
            if (!self.player.isFullScreen) {
                BOOL hidden = !self.navgationView.isHidden;
                [self setNavigationViewAndAlbumsViewHidden:hidden];
            }
        }];
    }
    return _controlView;
}

@end





























@interface LXHouseAlbumNavigationView ()

@property(nonatomic, strong) UIButton *leftBtn;

@property(nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, assign) CGRect originalFrame;


@end




@implementation LXHouseAlbumNavigationView


- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI
{
    CGFloat height = 44.0;
    if (@available(iOS 11.0, *)) {
        height += [UIApplication sharedApplication].delegate.window.safeAreaInsets.top;
    } else {
        height += 20.0;
    }
    _originalFrame = CGRectMake(0, 0, kScreenWidth, height);
    self.frame = _originalFrame;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualView.frame = self.bounds;
    
    [self addSubview:visualView];
    
    [self addSubview:self.leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(58, 44));
    }];
    
    [self addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(58);
        make.right.mas_equalTo(-58);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(0);
    }];
    
    
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setBackAction:(RACCommand *)backAction
{
    _leftBtn.rac_command = backAction;
}


- (void)setNavigationView:(BOOL)hidden animated:(BOOL)animated
{
    if (animated) {
        CGFloat w = _originalFrame.size.width;
        CGFloat h = _originalFrame.size.height;
        CGRect frame = hidden ? CGRectMake(0, -h, w, h) : _originalFrame;
        if (!hidden) self.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            self.hidden = hidden;
        }];
    } else {
        self.frame = _originalFrame;
        self.hidden = hidden;
    }
}


#pragma mark - lazyload
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"register_icon_back"] forState:UIControlStateNormal];
    }
    
    return _leftBtn;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}


@end














@interface LXAlbumTitlesView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) UICollectionView *collectionView;



@end


static CGFloat albumTitleHeight = 24.0;

@implementation LXAlbumTitlesView



- (instancetype)init
{
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI
{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    
    [self autoLayout];
    
}



- (void)autoLayout
{
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(20);
    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    self.userInteractionEnabled = NO;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lx_albumTitleCell" forIndexPath:indexPath];
    UILabel *label = [self titleLabelFromeCell:cell];
    label.text = self.titlesArray[indexPath.item];
    UIColor *color = indexPath.item == _selectIndex ? [UIColor randomColor] : [UIColor clearColor];
    label.layer.backgroundColor = color.CGColor;
    
    return cell;
}


- (UILabel *)titleLabelFromeCell:(UICollectionViewCell *)cell
{
    UILabel *label = [cell.contentView viewWithTag:1112];
    
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor whiteColor];
        label.layer.cornerRadius = 4.0;
//        label.layer.masksToBounds = YES;
        label.tag = 1112;
        
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.height.mas_equalTo(albumTitleHeight);
        }];
    }
    return label;
}



#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self refreshSelectTitleAtIndex:indexPath.item];
    
    
    
    NSString *title = self.titlesArray[indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(albumTitleView:didSelectTitle:atIndex:)]) {
        [self.delegate albumTitleView:self didSelectTitle:title atIndex:indexPath.item];
    }
}

- (void)refreshSelectTitleAtIndex:(NSInteger)index
{
    if (index == _selectIndex) return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:_selectIndex inSection:0];
    
    
    _selectIndex = index;
    
    [self.collectionView reloadItemsAtIndexPaths:@[lastIndexPath, indexPath]];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath
                           atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                   animated:YES];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.titlesArray[indexPath.item];
    
    return CGSizeMake([self widthOfTitle:title], collectionView.bounds.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


- (CGFloat)widthOfTitle:(NSString *)title
{
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
    
    return titleSize.width + 12;
}


- (void)setAlbumTitleView:(BOOL)hidden animated:(BOOL)animated
{
    if (animated) {
        CGFloat h = self.bounds.size.height;
        if (!hidden) self.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = hidden ? CGAffineTransformMakeTranslation(0, h) : CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.hidden = hidden;
        }];
    } else {
        self.hidden = hidden;
    }
}



- (void)setTitlesArray:(NSArray<NSString *> *)titlesArray
{
    _titlesArray = titlesArray;
    
    [self.collectionView reloadData];
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    [self refreshSelectTitleAtIndex:selectIndex];
}



#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 6.0;
        layout.minimumInteritemSpacing = 6.0;
        layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"lx_albumTitleCell"];
    }
    
    return _collectionView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}


@end


