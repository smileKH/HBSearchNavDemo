//
//  UIView+BKView.m
//  facerecognition
//
//  Created by y on 16/6/8.
//  Copyright © 2016年 BK. All rights reserved.
//

#import "UIView+BKView.h"
NSString *CELLID(Class cls){
    return  [NSString stringWithFormat:@"%@",NSStringFromClass(cls)];
}
@implementation UIView (BKView)
- (void)setWidth:(CGFloat)Width{
    CGRect frame = self.frame;
    frame.size.width = Width;
    self.frame = frame;
}
- (CGFloat)Width{
    return CGRectGetWidth(self.frame);
}

- (void)setHeight:(CGFloat)Height{
    CGRect frame = self.frame;
    frame.size.height = Height;
    self.frame = frame;
}
- (CGFloat)Height{
    return CGRectGetHeight(self.frame);
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x{
    return CGRectGetMinX(self.frame);
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y{
    return CGRectGetMinY(self.frame);

}
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY{
    return  CGRectGetMaxY(self.frame);
}

-(CGFloat)centerx{
    return self.center.x;
}
-(void)setCenterx:(CGFloat)centerx{
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}

-(CGFloat)centery{
    return self.center.y;
}
-(void)setCentery:(CGFloat)centery{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    
    return CGSizeMake([self Width], [self Height]);
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
} 
- (CGPoint)origin{
    return CGPointMake([self x], self.y);
}


- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0  )
    {
        if(view.bounds.size.height < 2)
        {
            view.backgroundColor = [UIColor clearColor];
        }
        
        [view.subviews enumerateObjectsUsingBlock:^( UIView *  obj, NSUInteger idx, BOOL *  stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
    
}

/**
 设置渐变背景
 
 @param colors 渐变颜色数组
 @param startPoint 开始点
 @param endPoint 结束点
 */
-(void)changeAlphaWithColors:(NSArray <UIColor *>*)colors start:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    
    CAGradientLayer *_gradLayer = [CAGradientLayer layer];
    NSMutableArray *CGColors = [NSMutableArray array];
    for (UIColor * color in colors) {
        [CGColors addObject:(id)color.CGColor];
    }
    
    [_gradLayer setColors:CGColors];
    //渐变起止点，point表示向量
    [_gradLayer setStartPoint:startPoint];
    [_gradLayer setEndPoint:endPoint];
    
    [_gradLayer setFrame:self.bounds];
    
    [self.layer insertSublayer:_gradLayer atIndex:0];
    
}

/**
 绘制圆角
 
 @param radius 半径
 @param color 颜色
 @param width 圆角路径宽度
 */
-(void)roundAngleWithRadius:(CGFloat)radius
                      color:(UIColor *)color
                  lineWidth:(CGFloat)width
{
    
    self.layer.masksToBounds       = YES;
    self.layer.cornerRadius        = radius;
    self.layer.borderColor         = color?color.CGColor:[UIColor clearColor].CGColor;
    self.layer.borderWidth         = width;
}


/**
 给view画圆角 （前提  view背景为透明）view已经有frame
 
 @param color 边框颜色
 @param fillColor 填充颜色
 @param corner 圆角位置
 @param cornerRadii 圆角size
 @param edge 间距
 */
//-(void)roundWithColor:(UIColor *)color
//            fillColor:(UIColor *)fillColor
//           rectCorner:(UIRectCorner)corner
//          cornerRadii:(CGFloat)cornerRadii
//                 edge:(UIEdgeInsets)edge{
//
//    //圆角范围的frame
//    CGRect frame = CGRectMake(self.bounds.origin.x + edge.left, self.bounds.origin.y + edge.top, self.width - edge.left-edge.right, self.height-edge.top-edge.bottom);
//    //圆角路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadii, cornerRadii)];
//
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    if (color) {
//        maskLayer.borderColor = color.CGColor;
//        maskLayer.strokeColor = color.CGColor;;
//    }else{
//        maskLayer.borderColor = [UIColor clearColor].CGColor;
//        maskLayer.strokeColor = [UIColor clearColor].CGColor;
//    }
//    //圆角内容填充颜色
//    maskLayer.fillColor = fillColor.CGColor;
//    
//    maskLayer.frame = self.bounds;
//    maskLayer.path = path.CGPath;
//    [self.layer insertSublayer:maskLayer atIndex:0];
//    //    [self.layer setMask:maskLayer];
//
//}

/**
 圆角
 */
- (void)cornerByRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
}

/**
 添加虚线边框
 
 @param color 虚线颜色
 @param radius 圆角半径
 @param space 虚线间隔
 @param bounds 虚线路径bounds/如果没有默认view的bounds
 */
-(void)dottedBorderWith:(UIColor *)color Radius:(CGFloat)radius Space:(NSArray<NSNumber *> *)space bounds:(CGRect)bounds{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //虚线的颜色
    border.strokeColor = color.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    CGPathRef path;
    
    if (radius) {
        
        if (bounds.size.width != 0) {
            path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius].CGPath;
        }else{
            path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
        }
        
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        
    }else {
        if (bounds.size.width != 0) {
            path = [UIBezierPath bezierPathWithRect:bounds].CGPath;
        }else{
            path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius].CGPath;
        }
        
    }
    //设置路径
    border.path = path;
    border.bounds = bounds.size.width == 0?self.bounds:bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    //设置线条的样式
    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = space;
    [self.layer addSublayer:border];
}


/**
 设置阴影 适用于view无圆角的时候 / 不剪切内部的时候
 
 @param color 颜色
 @param offset 偏移量 默认(0,-3)
 @param opacity 透明度
 @param radius 半径
 */
-(void)shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius
{
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color?color.CGColor:[UIColor blackColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    
}


/**
 设置阴影 适用于view无圆角的时候 / 不剪切内部的时候
 
 @param color 颜色
 @param offset 偏移量 默认(0,-3)
 @param opacity 透明度
 @param radius 半径
 @param path 路径
 */
-(void)shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius
                  path: (CGPathRef)path
{
    self.clipsToBounds = NO;
    self.layer.shadowColor = color?color.CGColor:[UIColor blackColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = path;
}

//
/**
 设置阴影 适用于view有圆角的时候//适用于tableview等类型view且已经有frame的时候
 
 @param color 颜色
 @param offset 偏移量 默认(0,-3)
 @param opacity 透明度
 @param radius 半径
 @param superview 父view
 */
-(void)shadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius superView:(UIView *)superview{
    UIView *shadowView = [[UIView alloc]initWithFrame:self.frame];
    
    [superview addSubview:shadowView];
    
    [shadowView shadowWithColor:color offset:offset opacity:opacity radius:radius];
    
    self.origin = CGPointMake(0, 0);
    [shadowView addSubview:self];
}

-(void)showQAnimate
{
    //需要实现的帧动画,这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:nil];
}

-(void)showFadeAnimate
{
    self.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1;
    } completion:nil];
}

+(instancetype)YG_QuickCreateLable:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor{
    UILabel *lable = [[UILabel alloc] init];
    lable.textColor = textColor;
    lable.font = font;
    lable.text = text;
    [lable sizeToFit];
    return lable;
}
+(instancetype)YG_QuickCreateButton:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font image:(UIImage *)image selectImg:(UIImage *)selectImg{
    UIButton *Button = [[UIButton alloc] init];
    if (textColor) {
        [Button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (image) {
        [Button setImage:image forState:UIControlStateNormal];
    }
    if (selectImg) {
        [Button setImage:selectImg forState:UIControlStateSelected];
    }
    if (text) {
        [Button setTitle:text forState:UIControlStateNormal];
    }
    if (font) {
        Button.titleLabel.font = font;
    }
    [Button sizeToFit];
    return Button;
}
+(instancetype)YG_QuickCreateImageView:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
     imageView.contentMode = UIViewContentModeScaleAspectFill;
     imageView.clipsToBounds = YES;
    if (image) {
        imageView.image = image;
    }
    [imageView sizeToFit];
    return imageView;
}
+(instancetype)YG_QuickCreatetextFiled:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder{
    UITextField *textfield = [[UITextField alloc] init];
    textfield.text = text;
    textfield.textColor = textColor;
    textfield.font = font;
    textfield.placeholder = placeholder;
    return textfield;
}
+(instancetype)YG_QuickCreatetextView:(NSString *)text textColor:(UIColor *)textColor{
    UITextView *textView = [[UITextView alloc] init];
    textView.text = text;
    textView.textColor = textColor;
    return textView;
}
+(instancetype)YG_QuickCreateTableView:(UITableViewStyle)style delegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource registerCell:(NSArray <Class>*)registerCell{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior =UIScrollViewContentInsetAdjustmentNever;
    }
    tableView.estimatedRowHeight = 44;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor =  [UIColor whiteColor];
    tableView.tableFooterView = [UIView new];
    if (registerCell.count) {
        for (Class class in registerCell) {
            [tableView registerClass:class forCellReuseIdentifier:CELLID(class)];
        }
    }
    
    return tableView;
    
}
@end
