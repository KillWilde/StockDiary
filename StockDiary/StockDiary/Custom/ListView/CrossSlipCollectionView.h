//
//  CrossSlipCollectionView.h
//  StockDiary
//
//  Created by SaturdayNight on 2017/11/16.
//  Copyright © 2017年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CrossSlipCollectionView : UIView

@property (nonatomic,strong) NSMutableArray *datasource;
@property (nonatomic,assign) NSInteger sIndex;          // 当前被选中的序号
@property (nonatomic,strong) UIView *sView;             // 选中的下标提示

-(instancetype)initWithFrame:(CGRect)frame;

@end
