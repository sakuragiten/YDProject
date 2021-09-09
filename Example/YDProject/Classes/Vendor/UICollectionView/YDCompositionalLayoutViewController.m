//
//  YDCompositionalLayoutViewController.m
//  YDProject_Example
//
//  Created by BaoHeiTan on 2021/3/31.
//  Copyright © 2021 387970107@qq.com. All rights reserved.
//

#import "YDCompositionalLayoutViewController.h"
#import "SXCompositionalLayout.h"

@protocol TMMMineInfoPhotoListCollectionCellDelegate <NSObject>

- (void)userGestureActionWithGesture:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface TMMMineInfoPhotoListCollectionCell : UICollectionViewCell<UIGestureRecognizerDelegate>

@property (nonatomic, weak) id<TMMMineInfoPhotoListCollectionCellDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t deleteActionHandle;

@end

@implementation TMMMineInfoPhotoListCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    //给每个cell添加一个长按手势
    UILongPressGestureRecognizer * longPress =[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    longPress.delegate = self;
    [self addGestureRecognizer:longPress];
    
    UIPanGestureRecognizer *pan =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
    pan.delegate = self;
    [self addGestureRecognizer:pan];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];;
    [btn setTitle:@"❎" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
}


- (void)deleteAction
{
    !_deleteActionHandle ? : _deleteActionHandle();
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}


- (void)gestureAction:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userGestureActionWithGesture:)]) {
        [self.delegate userGestureActionWithGesture:gestureRecognizer];
    }
}

@end

@interface YDCompositionalLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, TMMMineInfoPhotoListCollectionCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;


@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, strong) UIView *snapshotView;
@property (nonatomic, weak) UICollectionViewCell *originalCell;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) NSIndexPath * nextIndexPath;

@end

@implementation YDCompositionalLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}



- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];

}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMMMineInfoPhotoListCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    cell.delegate = self;
    @weakify(self)
    cell.deleteActionHandle = ^{
        @strongify(self)
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
    };
    UILabel *label = [self labelInCell:cell];
    label.text = self.dataArray[indexPath.row];
    return cell;
}

- (UILabel *)labelInCell:(UICollectionViewCell *)cell
{
    UILabel *label = [cell.contentView viewWithTag:12333];
    if (label == nil) {
        label = [UILabel new];
        label.textColor = [UIColor colorWithHexString:@"#00c858"];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 12333;
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(0);
        }];
    }
    return label;
}

#pragma mark - TMMMineInfoPhotoListCollectionCellDelegate
- (void)userGestureActionWithGesture:(UIGestureRecognizer *)gestureRecognizer
{
    //记录上一次手势的位置
    static CGPoint startPoint;
    //触发长按手势的cell
    TMMMineInfoPhotoListCollectionCell * cell = (TMMMineInfoPhotoListCollectionCell *)gestureRecognizer.view;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        //开始长按
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            
            self.collectionView.scrollEnabled = NO;
            //给点震动感
            AudioServicesPlaySystemSound(1519);
        }
        
        //获取cell的截图
        _snapshotView  = [cell snapshotViewAfterScreenUpdates:YES];
        _snapshotView.center = cell.center;
        UIView *superView = self.view ? : _collectionView;
        _snapshotView.frame = [_collectionView convertRect:cell.frame toView:superView];
        [superView addSubview:_snapshotView];
        
        
        _indexPath = [_collectionView indexPathForCell:cell];
        _originalCell = cell;
        _originalCell.hidden = YES;
        startPoint = [gestureRecognizer locationInView:_collectionView];
        
        
        
        //移动
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        CGFloat tranX = [gestureRecognizer locationOfTouch:0 inView:_collectionView].x - startPoint.x;
        CGFloat tranY = [gestureRecognizer locationOfTouch:0 inView:_collectionView].y - startPoint.y;
        
        UIView *superView = self.view ? : _collectionView;
        CGRect frameInCollectionView = [superView convertRect:_snapshotView.frame toView:_collectionView];
        CGPoint center = CGPointMake(frameInCollectionView.origin.x + frameInCollectionView.size.width * 0.5, frameInCollectionView.origin.y + frameInCollectionView.size.height * 0.5);
        //设置截图视图位置
        _snapshotView.center = CGPointApplyAffineTransform(_snapshotView.center, CGAffineTransformMakeTranslation(tranX, tranY));
        startPoint = [gestureRecognizer locationOfTouch:0 inView:_collectionView];
        //计算截图视图和哪个cell相交
        for (UICollectionViewCell *cell in [_collectionView visibleCells]) {
            //跳过隐藏的cell
            if ([_collectionView indexPathForCell:cell] == _indexPath) {
                continue;
            }
            //计算中心距
            CGFloat space = sqrtf(pow(center.x - cell.center.x, 2) + powf(center.y - cell.center.y, 2));
            
            //如果相交一半且两个视图Y的绝对值小于高度的一半就移动
            if (space <= _snapshotView.bounds.size.width * 0.5 && (fabs(center.y - cell.center.y) <= _snapshotView.bounds.size.height * 0.5)) {
                _nextIndexPath = [_collectionView indexPathForCell:cell];
                if (_nextIndexPath.item > _indexPath.item) {
                    for (NSUInteger i = _indexPath.item; i < _nextIndexPath.item ; i ++) {
                        [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
                    }
                }else{
                    for (NSUInteger i = _indexPath.item; i > _nextIndexPath.item ; i --) {
                        [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
                    }
                }
                //移动
                [_collectionView moveItemAtIndexPath:_indexPath toIndexPath:_nextIndexPath];
                //设置移动后的起始indexPath
                _indexPath = _nextIndexPath;
                break;
            }
        }
        //停止
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        
        [_snapshotView removeFromSuperview];
        _originalCell.hidden = NO;
    }
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        SXCompositionalLayout *layout = [[SXCompositionalLayout alloc] init];
        layout.minimumLineSpacing = 3.0;
        layout.minimumInteritemSpacing = 3.0;
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[TMMMineInfoPhotoListCollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [@[@"000", @"111", @"222", @"333", @"444", @"555", @"666", @"777"] mutableCopy];
    }
    return _dataArray;
}



@end
