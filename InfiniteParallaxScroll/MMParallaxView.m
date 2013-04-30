//
//  MMParallaxView.m
//  InfiniteParallaxScroll
//
//  Created by Emil Marashliev on 4/26/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMParallaxView.h"

@implementation MMParallaxView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)setText:(NSString *)text
{
    _text = text;
    [self setupTextLabel];
}


- (void)setupTextLabel
{
    self.textLabel.text = _text;
    CGSize expectedSize = [_text sizeWithFont:_textLabel.font
                            constrainedToSize:CGSizeMake(self.frame.size.width * 0.5, self.frame.size.height)
                                lineBreakMode:_textLabel.lineBreakMode];
    
    CGFloat x = CGRectGetWidth(self.frame) - expectedSize.width;
    _textLabel.frame = CGRectMake(x, self.center.y, expectedSize.width, expectedSize.height);
    [_textLabel sizeToFit];
}

- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.numberOfLines = 0;
        _textLabel.tag = PARALLAX_VIEW_LABEL_TAG;
    }
    return _textLabel;
}

@end
