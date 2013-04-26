//
//  MMParallaxView.m
//  InfiniteParallaxScroll
//
//  Created by Emil Marashliev on 4/26/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMParallaxView.h"
#import <QuartzCore/CATiledLayer.h>

@implementation MMParallaxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (Class)layerClass
{
    return [CATiledLayer class];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef contect = UIGraphicsGetCurrentContext();
    CGFloat scale = CGContextGetCTM(contect).a;
    
    CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
    CGSize tileSize = tiledLayer.tileSize;
    tileSize.width /= scale;
    tileSize.height /= scale;
    
    NSInteger firstCol = floorf(CGRectGetMidX(rect) / tileSize.width);
    NSInteger lastCol = floorf((CGRectGetMaxX(rect) - 1) / tileSize.width);
    NSInteger firstRow = floorf(CGRectGetMinY(rect) / tileSize.height);
    NSInteger lastRow = floorf((CGRectGetMaxY(rect) - 1) / tileSize.height);
    
    for (NSInteger row = firstRow; row <= lastRow; row++) {
        for (NSInteger col = firstCol; col <= lastCol; col++) {
            UIImage *tile = [self tileForScale:scale row:row col:col];
            CGRect tileRect = CGRectMake(tileSize.width * col, tileSize.height * row, tileSize.width, tileSize.height);
            
            // if the tile would stick outside of our bounds, we need to truncate it so as
            // to avoid stretching out the partial tiles at the right and bottom edges
            tileRect = CGRectIntersection(self.bounds, tileRect);
            
            [tile drawInRect:tileRect];
        }
    }
}


- (UIImage *)tileForScale:(CGFloat)scale row:(int)row col:(int)col
{
    // we use "imageWithContentsOfFile:" instead of "imageNamed:" here because we don't
    // want UIImage to cache our tiles
    //
  
    NSString *tileName = [NSString stringWithFormat:@"%@_%d_%d_%d", self.imageName, (int)(scale * 1000), col, row];
    NSString *path = [[NSBundle mainBundle] pathForResource:tileName ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
