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

    MMParallaxView *parallaxView = (MMParallaxView *)[infiniteScroll dequeueRecycledView];
    if (parallaxView == nil) {
        parallaxView = [[MMParallaxView alloc] init];
    
        if (infiniteScroll.isFrontScroll) {
            parallaxView.imageView.frame = CGRectMake(0, 0, 100, 100);
            parallaxView.frame = CGRectMake(0, 0, infiniteScroll.frame.size.width, infiniteScroll.frame.size.height);
//            parallaxView.textLabel.textColor = [UIColor whiteColor];
            
        } else {
            parallaxView.frame = CGRectMake(0, 0, infiniteScroll.frame.size.width, infiniteScroll.frame.size.height);
            parallaxView.imageView.frame = CGRectMake(0, 0, infiniteScroll.frame.size.width, 100);
        }
        parallaxView.imageView.center = parallaxView.center;
    }

    if (infiniteScroll.isFrontScroll) {
        parallaxView.text = @"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.";
        
    }
    
    parallaxView.imageView.image = [UIImage imageNamed:imageName];
    return parallaxView;
}


@end
