//
//  SHScreenShotTopView.m
//  SHScreenShot
//
//  Created by sunhao on 2018/9/12.
//  Copyright © 2018年 Bill. All rights reserved.
//

#import "SHScreenShotTopView.h"
#import "Masonry.h"

@interface SHScreenShotTopView ()
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *easyButton;
@property (nonatomic, strong) UIButton *feedbackButton;
@property (nonatomic, strong) UIButton *onlineButton;

@end
@implementation SHScreenShotTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
        [self setupLayouts];
    }
    return self;
}

- (void)setupSubViews {

    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];

    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.backgroundColor = [UIColor greenColor];
    [self addSubview:iconView];
    self.iconView = iconView;

    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.text = @"xxxxx";
    successLabel.font = [UIFont systemFontOfSize:14];
    successLabel.textColor = [UIColor redColor];
    [self addSubview:successLabel];
    self.successLabel = successLabel;

    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"xxxxxx";
    infoLabel.font = [UIFont systemFontOfSize:14];
    infoLabel.textColor = [UIColor whiteColor];
    [self addSubview:infoLabel];
    self.infoLabel = infoLabel;

    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor whiteColor];
    [lineView setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
    [self addSubview:lineView];
    self.lineView = lineView;

    self.easyButton = [self crectFeedButtonForTag:0];
    [self addSubview:self.easyButton];

    self.feedbackButton = [self crectFeedButtonForTag:1];
    [self addSubview:self.feedbackButton];

    self.onlineButton = [self crectFeedButtonForTag:2];
    [self addSubview:self.onlineButton];
}

- (UIButton *)crectFeedButtonForTag:(NSInteger)tag {

    UIButton *feedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [feedButton setTitle:self.titles[tag] forState:UIControlStateNormal];
    feedButton.tag = tag;
    [feedButton addTarget:self action:@selector(screenButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [feedButton setBackgroundColor:[UIColor greenColor]];
    [feedButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    feedButton.layer.cornerRadius = 4.0f;
    feedButton.layer.masksToBounds = YES;
    return feedButton;
}

- (void)setupLayouts {

    CGFloat padding     = 10.0f;
    CGFloat leftPadding = 15.0f;
    CGFloat itemHeight  = 35.0f;

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).mas_offset([[UIApplication sharedApplication] statusBarFrame].size.height);
        make.left.mas_equalTo(leftPadding);
        make.height.width.mas_equalTo(41.0f);
    }];

    [self.successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(padding);
        make.right.mas_equalTo(self.mas_right).mas_offset(-padding);
        make.height.mas_equalTo(20.0f);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successLabel.mas_bottom);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(padding);
        make.right.mas_equalTo(self.mas_right).mas_offset(-padding);
        make.height.mas_equalTo(20.0f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).mas_offset(leftPadding);
        make.left.mas_equalTo(padding);
        make.right.mas_equalTo(-padding);
        make.height.mas_equalTo(.5);
    }];

    [@[self.easyButton, self.feedbackButton, self.onlineButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:padding leadSpacing:padding tailSpacing:padding];

    [@[self.easyButton, self.feedbackButton, self.onlineButton] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(padding);
        make.height.mas_equalTo(itemHeight);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-padding);
    }];

}


- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"xx问题",@"xx",@"xxx"];
    }
    return _titles;
}

- (void)setImage:(UIImage *)image {
    self.iconView.image = image;
}

- (void)screenButtonClick:(UIButton *)sender {

    if (self.SHScreenShotTopViewClick) {
        self.SHScreenShotTopViewClick(sender.tag);
    }
}

@end
