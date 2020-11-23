//
//  HBSearchHistoryWordCell.h
//  HBSearchNavDemo
//
//  Created by 胡明波 on 2020/11/23.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBSearchHistoryWordCell : UICollectionViewCell
@property (nonatomic ,strong)UILabel *titleLabel;//标题
@property (nonatomic ,strong)UIButton *delBtn;
+ (CGSize)getSizeWithText:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
