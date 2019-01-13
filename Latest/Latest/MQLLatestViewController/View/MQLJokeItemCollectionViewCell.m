//
//  MQLJokeItemCollectionViewCell.m
//  KindergartenJoke
//
//  Created by ma qianli on 2019/1/13.
//  Copyright © 2019 ma qianli. All rights reserved.
//

#import "MQLJokeItemCollectionViewCell.h"

@interface MQLJokeItemCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfContentLab;

@end

@implementation MQLJokeItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setViewModel:(MQLJokeItemViewModel *)viewModel{
    [self resetContent];
    _viewModel = viewModel;
    [self setContent];
}

-(void)resetContent{
    self.titleLab.text = @"";
    self.contentLab.text = @"";
}

-(void)setContent{
    self.titleLab.text = self.viewModel.dataModel.title;
    self.contentLab.text = self.viewModel.dataModel.content;
    self.heightOfContentLab.constant = [self.viewModel sizeForItem].height - 20;
}

@end
