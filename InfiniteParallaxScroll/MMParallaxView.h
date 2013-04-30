//
//  MMParallaxView.h
//  InfiniteParallaxScroll
//
//  Created by Emil Marashliev on 4/26/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PARALLAX_VIEW_LABEL_TAG 11110

@interface MMParallaxView : UIView

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) UIImageView *imageView;

@end
