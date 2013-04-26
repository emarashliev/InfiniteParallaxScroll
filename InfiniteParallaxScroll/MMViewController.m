//
//  MMViewController.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/17/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMViewController.h"
#import "MMParallaxScroll.h"
#import "MMParallaxView.h"

#define IMAGEVIEW_TAG 10101



@interface MMViewController () <MMInfiniteScrollDataSource>

@property (assign, nonatomic) NSInteger frontScrollcounter;
@property (assign, nonatomic) NSInteger backScrollcounter;

@property (strong, nonatomic) NSArray *frontScrollImages;
@property (strong, nonatomic) NSArray *backScrollImages;
@property (weak, nonatomic) IBOutlet MMParallaxScroll *parallaxScroll;


@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.parallaxScroll.dataSource = self;
    self.frontScrollImages = 0;
    self.backScrollImages = 0;
    self.backScrollImages = @[@"aluminum", @"gold", @"rainbow", @"applelogo"];
    self.frontScrollImages = @[@"steve1.jpg", @"steve2.jpg", @"steve3.jpeg", @"steve4.jpg"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (MMParallaxView *)infiniteScrollWillInsertParallaxView:(MMInfiniteScroll *)infiniteScroll
{
    NSString *imageName = nil;
    if (infiniteScroll.isFrontScroll) {
        imageName = [self.frontScrollImages objectAtIndex:(self.frontScrollcounter % self.frontScrollImages.count)];
        self.frontScrollcounter++;
    } else {
        imageName = [self.backScrollImages objectAtIndex:(self.backScrollcounter % self.backScrollImages.count)];
        self.backScrollcounter++;
    }

    MMParallaxView *view = (MMParallaxView *)[infiniteScroll dequeueRecycledView];
    if (view == nil) {
        view = [[MMParallaxView alloc] init];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = IMAGEVIEW_TAG;
        if (infiniteScroll.isFrontScroll) {
            imageView.frame = CGRectMake(0, 0, 100, 100);
        } else {
            imageView.frame = CGRectMake(0, 0, infiniteScroll.frame.size.width, 100);
        }
        
        view.frame = CGRectMake(0, 0, infiniteScroll.frame.size.width, infiniteScroll.frame.size.height);

        imageView.center = view.center;
        [view addSubview:imageView];
        
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    view.imageName = imageName;
    [(UIImageView *)[view viewWithTag:IMAGEVIEW_TAG] setImage:image];
    return view;
}


@end
