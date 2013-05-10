//
//  MMParallaxView.h
//  InfiniteParallaxScroll
//
//  Created by Emil Marashliev on 4/26/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMParallaxScroll.h"

@interface MMParallaxView : UIView

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIImageView *imageView;
@property (assign, nonatomic) MMInfiniteScrollDirection scrollDirection;


@end
