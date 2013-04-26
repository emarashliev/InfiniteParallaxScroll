//
//  MMInfiniteScroll.h
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMInfiniteScroll, MMParallaxView;
@protocol MMInfiniteScrollDataSource <NSObject>

@required
- (MMParallaxView *)infiniteScrollWillInsertParallaxView:(MMInfiniteScroll *)infiniteScroll;

@end


@interface MMInfiniteScroll : UIScrollView <UIScrollViewDelegate>

@property (assign, nonatomic) id<MMInfiniteScrollDataSource> dataSource;
@property (assign, nonatomic) BOOL isFrontScroll;

- (UIView *)dequeueRecycledView;

@end
