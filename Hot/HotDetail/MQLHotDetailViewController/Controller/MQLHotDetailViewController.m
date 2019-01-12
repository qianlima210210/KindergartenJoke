//
//  MQLHotDetailViewController.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/11.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLHotDetailViewController.h"

@interface MQLHotDetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraintOfNavContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintOfLowest;


@end

@implementation MQLHotDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _viewModel = [MQLHotDetailViewModel new];
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
    self.bottomConstraintOfLowest.constant = bottomSafeAreaHeight();
    
}


@end
