//
//  MMParallaxScroll.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMParallaxScroll.h"
#import "MMInfiniteScroll.h"
#import "MMParallaxView.h"

#define SCHEDUL_TIME_INTERVAL 2.0f/60.0f
#define LABEL_SPEED_FACTOR 0.3
#define AUTO_SCROLL_SPEED 1


@interface MMParallaxScroll ()

@property (assign, nonatomic) CGFloat lastPosition;
@property (strong, nonatomic) MMInfiniteScroll *frontScrollView;
@property (strong, nonatomic) MMInfiniteScroll *backScrollView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) MMInfiniteScrollDirection scrollDirection;

@end


@implementation MMParallaxScroll


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
    self.speedFactor = 0.5;
    self.frontScrollView = [[MMInfiniteScroll alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.backScrollView = [[MMInfiniteScroll alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [self addSubview:self.backScrollView];
    [self addSubview:self.frontScrollView];
    self.frontScrollView.dataSource = self;
    self.backScrollView.dataSource = self;
    self.frontScrollView.delegate = self;
    self.frontScrollView.isFrontScroll = YES;
    
    self.frontScrollView.contentSize = CGSizeMake(5000, self.frame.size.height);
    self.backScrollView.contentSize = CGSizeMake(5000, self.frame.size.height);
    
    self.scrollDirection = MMInfiniteScrollDirectionLeft;
    [self scrollByTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:SCHEDUL_TIME_INTERVAL
                                                  target:self
                                                selector:@selector(scrollByTimer)
                                                userInfo:nil
                                                 repeats:YES];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)scrollByTimer
{
    [self.frontScrollView setContentOffset:CGPointMake((self.frontScrollView.contentOffset.x + (AUTO_SCROLL_SPEED  * self.scrollDirection)),
                                                       self.frontScrollView.contentOffset.y)
                                  animated:NO];
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat difference = self.frontScrollView.contentOffset.x - self.lastPosition;
    CGFloat lastPosition = self.lastPosition;
    self.lastPosition = self.frontScrollView.contentOffset.x;
    
    if (abs(difference) >= scrollView.contentSize.width / 4) {
        return;
    }
    
    if (lastPosition > scrollView.contentOffset.x) {
        self.scrollDirection = MMInfiniteScrollDirectionRight;
    }else if (lastPosition < scrollView.contentOffset.x){
        self.scrollDirection = MMInfiniteScrollDirectionLeft;
    }
    
    NSArray *subviews = [[[scrollView subviews] objectAtIndex:0] subviews];
    for (MMParallaxView *paralaxView in subviews) {
        paralaxView.scrollDirection = self.scrollDirection;
        UILabel *label = paralaxView.textLabel;
        label.frame = CGRectMake(label.frame.origin.x - (difference * LABEL_SPEED_FACTOR),
                                 label.frame.origin.y,
                                 label.frame.size.width,
                                 label.frame.size.height);
    }
    
    
    [self.backScrollView setContentOffset:CGPointMake((self.backScrollView.contentOffset.x + (self.speedFactor * difference)),
                                                      self.backScrollView.contentOffset.y)];
    
}

#pragma mark - Proxy Methods
- (MMParallaxView *)infiniteScrollWillInsertParallaxView:(MMInfiniteScroll *)infiniteScroll
{
    return [self.dataSource infiniteScrollWillInsertParallaxView:infiniteScroll];
}


@end
