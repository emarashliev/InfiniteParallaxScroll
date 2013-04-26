//
//  MMParallaxScroll.h
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMInfiniteScroll.h"

@interface MMParallaxScroll : UIView <UIScrollViewDelegate, MMInfiniteScrollDataSource>

@property (assign, nonatomic) id<MMInfiniteScrollDataSource> dataSource;
@property (assign, nonatomic) CGFloat speedFactor;

@end
