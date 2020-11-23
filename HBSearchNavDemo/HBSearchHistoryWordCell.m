//
//  HBSearchHistoryWordCell.m
//  HBSearchNavDemo
//
//  Created by 胡明波 on 2020/11/23.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "HBSearchHistoryWordCell.h"
@implementation HBSearchHistoryWordCell
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
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(24);
    }];
    
    self.layer.cornerRadius = 24/2;
    self.clipsToBounds = YES;
    [self setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
}
#pragma mark ==========getter==========
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];//初始化控件
            //常用属性
            label.text = @"内容显示";//内容显示
            label.textColor = [UIColor blackColor];//设置字体颜色
            label.font = [UIFont systemFontOfSize:12];//设置字体大小
            label.textAlignment = NSTextAlignmentLeft;//设置对齐方式
            label.numberOfLines = 1; //行数
            label ;
        }) ;
    }
    return _titleLabel ;
}

+ (CGSize)getSizeWithText:(NSString*)text {
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    if (size.width + 2*8 >= [UIScreen mainScreen].bounds.size.width - 2 *kFirstitemleftSpace) {
        size.width = [UIScreen mainScreen].bounds.size.width - 2 *kFirstitemleftSpace - 2*8.f;
    }
    return CGSizeMake(ceilf(size.width+2*8), 24);
}
@end
