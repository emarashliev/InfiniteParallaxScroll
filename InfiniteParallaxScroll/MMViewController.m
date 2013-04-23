//
//  MMViewController.m
//  InfiniteScroll
//
//  Created by Emil Marashliev on 4/17/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "MMViewController.h"

#import "MMInfiniteScroll.h"


@interface MMViewController () 

//@property (weak, nonatomic) IBOutlet MMInfiniteScroll *scrollView;
@property (nonatomic) NSInteger counter;



@end

@implementation MMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.scrollView.delegate = self;
    self.counter = 1;
	// Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
