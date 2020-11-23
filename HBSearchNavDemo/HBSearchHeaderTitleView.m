//
//  HBSearchHeaderTitleView.m
//  HBSearchNavDemo
//
//  Created by 胡明波 on 2020/11/23.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "HBSearchHeaderTitleView.h"

@implementation HBSearchHeaderTitleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //子视图
        [self addSubViewUI];
    }
    return self;
}
#pragma mark ==========添加子视图==========
-(void)addSubViewUI{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(16);
    }];
}
#pragma mark ==========getter==========
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"历史搜索";//内容显示
            label.textColor = [UIColor blackColor];//设置字体颜色
            label.font = [UIFont systemFontOfSize:14];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;//设置对齐方式
            label.numberOfLines = 1; //行数
            
            label ;
        }) ;
    }
    return _titleLabel ;
}
@end
