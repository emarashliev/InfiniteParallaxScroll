//
//  MMParallaxScroll.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMParallaxScroll.h"

#import "MMInfiniteScroll.h"

@interface MMParallaxScroll () 

@property (assign, nonatomic) CGFloat lastPosition;
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
    
    [self addSubview:self.backScrollView];
    [self addSubview:self.frontScrollView];
    self.frontScrollView.dataSource = self;
    self.backScrollView.dataSource = self;
    self.frontScrollView.delegate = self;
    self.frontScrollView.isFrontScroll = YES;
    
    self.frontScrollView.contentSize = CGSizeMake(5000, self.frame.size.height);
    self.backScrollView.contentSize = CGSizeMake(5000, self.frame.size.height);
    

//    [self.backScrollView setup];
//    [self.frontScrollView setup];
    
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
    CGFloat difference = self.frontScrollView.contentOffset.x - self.lastPosition;        
    self.lastPosition = self.frontScrollView.contentOffset.x;

    if (abs(difference) >= scrollView.contentSize.width / 4) {
        return;
    }
      
    [self.backScrollView setContentOffset:CGPointMake((0.4 * difference) + self.backScrollView.contentOffset.x, self.backScrollView.contentOffset.y)];

}

#pragma mark - Proxy Methods
- (MMParallaxView *)infiniteScrollWillInsertParallaxView:(MMInfiniteScroll *)infiniteScroll
{
    return [self.dataSource infiniteScrollWillInsertParallaxView:infiniteScroll];
}


@end
