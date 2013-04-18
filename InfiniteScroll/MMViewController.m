//
//  MMViewController.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/17/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMViewController.h"

#import "MMInfiniteScroll.h"


@interface MMViewController () <MMInfiniteScrollDelegate>

@property (weak, nonatomic) IBOutlet MMInfiniteScroll *scrollView;

@property (nonatomic) NSInteger counter;

@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    self.counter = 1;
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (UIView *)insertView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, self.view.frame.size.width)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 101, 100)];
    label.text = [NSString stringWithFormat:@"%i", self.counter];
    [view addSubview:label];
    self.counter++;
    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
