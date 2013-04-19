//
//  MMInfiniteScroll.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/18/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMInfiniteScroll.h"




@interface MMInfiniteScroll ()

@property (strong, nonatomic) NSMutableArray *visibleViews;
@property (strong, nonatomic) UIView *containerView;
@property (assign, nonatomic) NSInteger counter;

@end


@implementation MMInfiniteScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self _init];
    }
    return self;
}

- (void)_init
{
    self.counter = 0;
    self.contentSize = CGSizeMake(5000, self.frame.size.height);
    self.visibleViews = [[NSMutableArray alloc] init];
    
    self.containerView = [[UIView alloc] init];
    self.containerView.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    self.containerView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerView];
    
    [self.containerView setUserInteractionEnabled:NO];
    
    // hide horizontal scroll indicator so our recentering trick is not revealed
    [self setShowsHorizontalScrollIndicator:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




#pragma mark - Layout

// recenter content periodically to achieve impression of infinite scrolling
- (void)recenterIfNecessary
{
    CGPoint currentOffset = [self contentOffset];
    CGFloat contentWidth = [self contentSize].width;
    CGFloat centerOffsetX = (contentWidth - [self bounds].size.width) / 2.0;
    CGFloat distanceFromCenter = fabs(currentOffset.x - centerOffsetX);
    
    if (distanceFromCenter > (contentWidth / 4.0)) {
        self.contentOffset = CGPointMake(centerOffsetX, currentOffset.y);
        
        // move content by the same amount so it appears to stay still
        for (UIView *view in self.visibleViews) {
            CGPoint center = [self.containerView convertPoint:view.center toView:self];
            center.x += (centerOffsetX - currentOffset.x);
            view.center = [self convertPoint:center toView:self.containerView];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self recenterIfNecessary];
    
    // tile content in visible bounds
    CGRect visibleBounds = [self convertRect:[self bounds] toView:self.containerView];
    CGFloat minimumVisibleX = CGRectGetMinX(visibleBounds);
    CGFloat maximumVisibleX = CGRectGetMaxX(visibleBounds);
    
    [self tileViewsFromMinX:minimumVisibleX toMaxX:maximumVisibleX];
}


#pragma mark - Tiling

- (UIView *)insertView
{
    NSString *imageName = [self.images objectAtIndex:(self.counter % self.images.count)];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = image;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.center = view.center;
   
    [view addSubview:imageView];
    
    self.counter++;
    return view;
}

- (CGFloat)placeNewViewOnRight:(CGFloat)rightEdge
{
    UIView *view = [self insertView];
    [self.containerView addSubview:view];
    [self.visibleViews addObject:view];
    
    CGRect frame = [view frame];
    frame.origin.x = rightEdge;
    frame.origin.y = [self.containerView bounds].size.height - frame.size.height;
    [view setFrame:frame];
    
    return CGRectGetMaxX(frame);
}

- (CGFloat)placeNewViewOnLeft:(CGFloat)leftEdge
{
    UIView *view = [self insertView];
    [self.containerView addSubview:view];
    [self.visibleViews insertObject:view atIndex:0];
    
    CGRect frame = [view frame];
    frame.origin.x = leftEdge - frame.size.width;
    frame.origin.y = [self.containerView bounds].size.height - frame.size.height;
    [view setFrame:frame];
    
    return CGRectGetMinX(frame);
}

- (void)tileViewsFromMinX:(CGFloat)minimumVisibleX toMaxX:(CGFloat)maximumVisibleX
{
        if ([self.visibleViews count] == 0) {
        [self placeNewViewOnRight:minimumVisibleX];
    }
    
    // add views on right side
    UIView *lastView = [self.visibleViews lastObject];
    CGFloat rightEdge = CGRectGetMaxX([lastView frame]);
    while (rightEdge < maximumVisibleX) {
        rightEdge = [self placeNewViewOnRight:rightEdge];
    }
    
    // add views on left side
    UIView *firstView = [self.visibleViews objectAtIndex:0];
    CGFloat leftEdge = CGRectGetMinX([firstView frame]);
    while (leftEdge > minimumVisibleX) {
        leftEdge = [self placeNewViewOnLeft:leftEdge];
    }
    
    // remove views from the right edge
    lastView = [self.visibleViews lastObject];
    while ([lastView frame].origin.x > maximumVisibleX) {
        [lastView removeFromSuperview];
        [self.visibleViews removeLastObject];
        lastView = [self.visibleViews lastObject];
    }
    
    // remove views from the left edge
    firstView = [self.visibleViews objectAtIndex:0];
    while (CGRectGetMaxX([firstView frame]) < minimumVisibleX) {
        [firstView removeFromSuperview];
        [self.visibleViews removeObjectAtIndex:0];
        firstView = [self.visibleViews objectAtIndex:0];
    }
}

@end
