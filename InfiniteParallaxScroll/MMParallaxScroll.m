//
//  MMParallaxScroll.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMParallaxScroll.h"

#import "MMInfiniteScroll.h"

typedef NSInteger MMInfiniteScrollDirection;
enum MMInfiniteScrollDirection {
    MMInfiniteScrollDirectionLeft,
    MMInfiniteScrollDirectionRight
};

@interface MMParallaxScroll () <UIScrollViewDelegate>

@property (assign, nonatomic) CGFloat lastPosition;
@property (assign, nonatomic) MMInfiniteScrollDirection scrollDirection;
@property (strong, nonatomic) MMInfiniteScroll *frontScrollView;
@property (strong, nonatomic) MMInfiniteScroll *backScrollView;

@end


@implementation MMParallaxScroll

- (id)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init
{

    self.frontScrollView = [[MMInfiniteScroll alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.backScrollView = [[MMInfiniteScroll alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    self.backScrollView.images = @[@"aluminum", @"gold", @"rainbow", @"applelogo"];
    self.frontScrollView.images = @[@"steve1.jpg", @"steve2.jpg", @"steve3.jpeg", @"steve4.jpg"];
    [self addSubview:self.backScrollView];
    [self addSubview:self.frontScrollView];
    self.frontScrollView.delegate = self;
    self.frontScrollView.isFrontScroll = YES;
    
    self.frontScrollView.contentSize = CGSizeMake(6000, self.frame.size.height);
    self.backScrollView.contentSize = CGSizeMake(5000, self.frame.size.height);
    
    self.backScrollView.scaleFactor = self.backScrollView.contentSize.width / self.frontScrollView.contentSize.width;
    [self.backScrollView setup];
    [self.frontScrollView setup];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    NSLog(@"%f", scrollView.contentOffset.x);
    if (self.lastPosition > scrollView.contentOffset.x) {
        self.scrollDirection = MMInfiniteScrollDirectionRight;
        //        NSLog(@"Right");
    }else if (self.lastPosition < scrollView.contentOffset.x){
        self.scrollDirection = MMInfiniteScrollDirectionLeft;
        //        NSLog(@"Left");
    }
    
    
    CGFloat speedFactor = self.backScrollView.contentSize.width / self.frontScrollView.contentSize.width ;
    
    self.lastPosition = self.frontScrollView.contentOffset.x;
    
  
    
    [self.backScrollView setContentOffset:CGPointMake(speedFactor * scrollView.contentOffset.x, self.backScrollView.contentOffset.y)];

}


@end