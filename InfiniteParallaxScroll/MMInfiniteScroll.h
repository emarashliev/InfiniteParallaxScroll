//
//  MMInfiniteScroll.h
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMInfiniteScrollDelegate <NSObject, UIScrollViewDelegate>

@required
- (UIView *)insertView;


@end

@interface MMInfiniteScroll : UIScrollView <UIScrollViewDelegate>

//@property (assign, nonatomic) id<MMInfiniteScrollDelegate> delegate;
@property (strong, nonatomic) NSArray *images;
@property (assign, nonatomic) CGSize imagesSize;
@property (assign, nonatomic) BOOL isFrontScroll;
@property (assign, nonatomic) CGFloat scaleFactor;

- (void)setup;
- (void)recenterIfNecessary;

@end