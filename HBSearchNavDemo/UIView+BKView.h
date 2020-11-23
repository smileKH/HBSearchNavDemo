//
//  UIView+BKView.h
//  facerecognition
//
//  Created by y on 16/6/8.
//  Copyright © 2016年 BK. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *CELLID(Class cls);
@interface UIView (BKView)
@property (nonatomic, assign)CGFloat Width;
@property (nonatomic, assign)CGFloat Height;
@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;

@property (nonatomic, assign)CGFloat maxX;
@property (nonatomic, assign)CGFloat maxY;

@property (nonatomic, assign)CGFloat centerx;
@property (nonatomic, assign)CGFloat centery;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


- (void)clearSeparatorWithView:(UIView * )view;

/**
 设置渐变背景
 
 @param colors 渐变颜色数组
 @param startPoint 开始点
 @param endPoint 结束点
 */
-(void)changeAlphaWithColors:(NSArray <UIColor *>*)colors start:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/**
 绘制圆角
 
 @param radius 半径
 @param color 颜色
 @param width 圆角路径宽度
 */
-(void)roundAngleWithRadius:(CGFloat)radius
                      color:(UIColor *)color
                  lineWidth:(CGFloat)width;


/**
 给view画圆角 （前提  view背景为透明）view已经有frame
 
 @param color 边框颜色
 @param fillColor 填充颜色
 @param corner 圆角位置
 @param cornerRadii 圆角size
 @param edge 间距
 */
-(void)roundWithColor:(UIColor *)color
            fillColor:(UIColor *)fillColor
           rectCorner:(UIRectCorner)corner
          cornerRadii:(CGFloat)cornerRadii
                 edge:(UIEdgeInsets)edge;

/**
 圆角
 */
- (void)cornerByRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;
/**
 添加虚线边框
 
 @param color 虚线颜色
 @param radius 圆角半径
 @param space 虚线间隔
 @param bounds 虚线路径bounds/如果没有默认view的bounds
 */
-(void)dottedBorderWith:(UIColor *)color Radius:(CGFloat)radius Space:(NSArray<NSNumber *> *)space bounds:(CGRect)bounds;


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
                radius: (CGFloat)radius;


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
                  path: (CGPathRef)path;
//
/**
 设置阴影 适用于view有圆角的时候//适用于tableview等类型view且已经有frame的时候
 
 @param color 颜色
 @param offset 偏移量 默认(0,-3)
 @param opacity 透明度
 @param radius 半径
 @param superview 父view
 */
-(void)shadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius superView:(UIView *)superview;
-(void)showQAnimate;

-(void)showFadeAnimate;

+(instancetype)YG_QuickCreateLable:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
+(instancetype)YG_QuickCreateButton:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font image:(UIImage *)image selectImg:(UIImage *)selectImg;
+(instancetype)YG_QuickCreateImageView:(UIImage *)image;
+(instancetype)YG_QuickCreatetextFiled:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font placeholder:(NSString *)placeholder;
+(instancetype)YG_QuickCreatetextView:(NSString *)text textColor:(UIColor *)textColor;
+(instancetype)YG_QuickCreateTableView:(UITableViewStyle)style delegate:(id <UITableViewDelegate>)delegate dataSource:(id <UITableViewDataSource>)dataSource registerCell:(NSArray <Class>*)registerCell;

@end
