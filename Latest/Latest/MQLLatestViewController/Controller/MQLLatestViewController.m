//
//  MQLLatestViewController.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/11.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLLatestViewController.h"

@interface MQLLatestViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowest;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSString *identifier;

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation MQLLatestViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _viewModel = [MQLLatestViewModel new];
        _viewModel.isLatestItem = _isLatestItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self generalInit];
}

-(void)generalInit{
    self.heightConstraintOfNavContainerView.constant = navigationBarHeight() + kStatusBarHeight;
    self.bottomConstraintOfLowest.constant = tabBarHeight();
    
    //add layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10.0;
    layout.minimumLineSpacing = 15.0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    
    self.identifier = @"MQLJokeItemCollectionViewCell";
    UINib *nib = [UINib nibWithNibName:self.identifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:self.identifier];
    
    //添加刷新头
    [self addMJRefreshNormalHeader];
    
    //添加刷新脚
    [self addMJRefreshAutoNormalFooter];
}

- (void)addMJRefreshNormalHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getLatestWithFirstPage:YES];
    }];
    
    // 设置文字
    [header setTitle:MJRefreshStateIdleString forState:MJRefreshStateIdle];
    [header setTitle:MJRefreshStatePullingString forState:MJRefreshStatePulling];
    [header setTitle:MJRefreshStateRefreshingString forState:MJRefreshStateRefreshing];
    
    //隐藏时间标签
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 马上进入刷新状态
    self.collectionView.mj_header = header;
    [self.collectionView.mj_header beginRefreshing];
}

-(void)addMJRefreshAutoNormalFooter{
    __weak typeof(self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getLatestWithFirstPage:NO];
    }];
    mj_footer.triggerAutomaticallyRefreshPercent = 0.1;
    self.collectionView.mj_footer = mj_footer;
}

//发送请求
-(void)getLatestWithFirstPage:(BOOL)isFirstPage{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getLatestWithFirstPage:isFirstPage success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //获取中文内容
        ///<div class="hc-tit cf">
        ///<div class="hcc-text">
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *elements = [doc searchWithXPathQuery:@"//div"];

        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *contents = [NSMutableArray array];
        
        for (int i = 0; i < elements.count; i++) {
            TFHppleElement *e = elements[i];
            
            if ([e.attributes[@"class"] isEqualToString:@"hc-tit cf"]) {
                TFHppleElement *titleE = [e firstChildWithTagName:@"a"];
                [titles addObject: [titleE.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            }
            
        }
        
        for (int j = 0; j < elements.count; j++) {
            TFHppleElement *e = elements[j];
            
            NSString *content = @"";
            if ([e.attributes[@"class"] isEqualToString:@"hcc-text"]) {
                for (TFHppleElement *nodeE in e.children) {
                    if (nodeE.content != nil) {
                        content = [content stringByAppendingString:nodeE.content];
                    }else{
                        content = [content stringByAppendingString:@"br"];
                    }
                }
                [contents addObject: [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            }
        }
        
        NSString *pingJieString = @"";
        NSString *fenGeString = @"MQLmql";
        for (int k = 0; k < titles.count; k++) {
            NSString *title = titles[k];
            NSString *content = contents[k];
            
            if (k == titles.count -1) {
                pingJieString = [pingJieString stringByAppendingFormat:@"%@%@%@", title, fenGeString, content];
            }else{
                pingJieString = [pingJieString stringByAppendingFormat:@"%@%@%@%@", title, fenGeString, content, fenGeString];
            }
        }
        
        BOOL isInChina = [weakSelf isInChina];
        if (isInChina) {
            [weakSelf handleWithTitles:titles contents:contents isFirstPage:isFirstPage];
            return;
        }
        
        [weakSelf.viewModel traslateChineseContent:pingJieString success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            //解析出英文内容
            NSString *enPingJieString = @"";
            NSArray *translateResult = [responseObject objectForKey:@"translateResult"];
            for (NSDictionary *dic in translateResult.firstObject) {
                enPingJieString = [enPingJieString stringByAppendingString:dic[@"tgt"]];
            }

            NSMutableArray *titles = [NSMutableArray array];
            NSMutableArray *contents = [NSMutableArray array];
            for (int l = 0; l < [enPingJieString componentsSeparatedByString:fenGeString].count; l++) {
                if (l % 2 == 0) {
                    [titles addObject:[enPingJieString componentsSeparatedByString:fenGeString][l]];
                }else{
                    [contents addObject:[enPingJieString componentsSeparatedByString:fenGeString][l]];
                }
            }
            
            [weakSelf handleWithTitles:titles contents:contents isFirstPage:isFirstPage];
            
            
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            if (isFirstPage) {
                [weakSelf.collectionView.mj_header endRefreshing];
            }else{
                [weakSelf.collectionView.mj_footer endRefreshing];
            }
        }];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (isFirstPage) {
            [weakSelf.collectionView.mj_header endRefreshing];
        }else{
            [weakSelf.collectionView.mj_footer endRefreshing];
        }
    }];
}

- (BOOL)isInChina {
    
    BOOL result = NO;
    //NSString* localeStr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    
    if([[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Chongqing"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Harbin"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Hong_Kong"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Macau"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Shanghai"].location == 0 ||
       [[[NSTimeZone localTimeZone] name] rangeOfString:@"Asia/Taipei"].location == 0)
    {
        result = YES;
    }
    return result;
}

-(void)handleWithTitles:(NSArray*)titles contents:(NSArray*)contents isFirstPage:(BOOL)isFirstPage{
    
    if (isFirstPage) {
        //触发第一页的是mj_header
        [self.collectionView.mj_header endRefreshing];
        
        self.viewModel.pageNumber = 1;
        
        //先清除
        [self.viewModel.dataModel.jokeItemDataModels removeAllObjects];
        [self.viewModel.jokeItemViewModels removeAllObjects];
        
        //再新增
        for (int i = 0; i < titles.count; i++) {
            MQLJokeItemDataModel *itemDataModel = [MQLJokeItemDataModel new];
            itemDataModel.title = titles[i];
            itemDataModel.content = contents[i];
            
            [self.viewModel.dataModel.jokeItemDataModels addObject:itemDataModel];
            
            MQLJokeItemViewModel *itemViewModel = [MQLJokeItemViewModel new];
            itemViewModel.dataModel = itemDataModel;
            [self.viewModel.jokeItemViewModels addObject:itemViewModel];
        }
        
    }else{
        //触发非第一页的是mj_rooter
        [self.collectionView.mj_footer endRefreshing];
        
        self.viewModel.pageNumber += 1;
        
        //再新增
        for (int i = 0; i < titles.count; i++) {
            MQLJokeItemDataModel *itemDataModel = [MQLJokeItemDataModel new];
            itemDataModel.title = titles[i];
            itemDataModel.content = contents[i];
            
            [self.viewModel.dataModel.jokeItemDataModels addObject:itemDataModel];
            
            MQLJokeItemViewModel *itemViewModel = [MQLJokeItemViewModel new];
            itemViewModel.dataModel = itemDataModel;
            [self.viewModel.jokeItemViewModels addObject:itemViewModel];
        }
    }
    
    [self.collectionView reloadData];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewModel.jokeItemViewModels.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MQLJokeItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    cell.viewModel = [self.viewModel.jokeItemViewModels objectAtIndex:indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MQLJokeItemViewModel *itemViewModel = [self.viewModel.jokeItemViewModels objectAtIndex:indexPath.item];
    return [itemViewModel sizeForItem];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当CollectionView的内容高度大于等于CollectionView自身高度时，才显示脚部刷新
    if (self.collectionView.contentSize.height >= self.collectionView.bounds.size.height) {
        
        if (self.viewModel.pageNumber >= self.viewModel.allPageNumber) {
            self.collectionView.mj_footer.hidden = YES;
        }else{
            self.collectionView.mj_footer.hidden = NO;
        }
        
    }else{
        self.collectionView.mj_footer.hidden = YES;
    }
}

@end
