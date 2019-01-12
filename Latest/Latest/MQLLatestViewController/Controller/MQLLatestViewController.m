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
    layout.minimumLineSpacing = 10.0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    self.collectionView.collectionViewLayout = layout;
    
    self.identifier = @"UICollectionViewCell";
    //UINib *nib = [UINib nibWithNibName:self.identifier bundle:nil];
    //[self.collectionView registerNib:nib forCellWithReuseIdentifier:self.identifier];
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:self.identifier];
    
    //添加刷新头
    [self addMJRefreshNormalHeader];
}

- (void)addMJRefreshNormalHeader
{
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //发送请求
        [weakSelf getLatest];
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


//发送请求
-(void)getLatest{
    __weak typeof(self) weakSelf = self;
    [self.viewModel getLatestSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        //先清除
        
        
        //再新增
        ///<div class="hc-tit cf">
        ///<div class="hcc-text">
        TFHpple *doc = [[TFHpple alloc]initWithHTMLData:responseObject];
        NSArray *elements = [doc searchWithXPathQuery:@"//div"];

        for (int i = 0; i < elements.count; i++) {
            TFHppleElement *e = elements[i];
            
            NSString *title = @"";
            if ([e.attributes[@"class"] isEqualToString:@"hc-tit cf"]) {
                TFHppleElement *titleE = [e firstChildWithTagName:@"a"];
                NSLog(@"title: %@", titleE.text);
                title = titleE.text;
            }
            
            NSString *content = @"";
            if ([e.attributes[@"class"] isEqualToString:@"hcc-text"]) {
                for (TFHppleElement *nodeE in e.children) {
                    if (nodeE.content != nil) {
                        content = [content stringByAppendingString:nodeE.content];
                    }
                }
                NSLog(@"content%@", content);
            }
        }
        
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
    }];
}

//MARK:UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(collectionView.bounds.size.width - 10 * 2, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    ///////////////////
    ///////////////////////
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = @"http://haha.sogou.com/tag/li/%E5%B9%BC%E5%84%BF%E5%9B%AD/new/1/";
    
//    NSURL *url1 = [NSURL URLWithString:url];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1 cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
//
//    self.task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@", responseObject);
//
//    }];
//
//    [self.task resume];
    

}


@end
