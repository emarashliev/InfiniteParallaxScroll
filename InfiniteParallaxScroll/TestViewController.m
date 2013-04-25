//
//  TestViewController.m
//  InfiniteParallaxScroll
//
//  Created by Emil Marashliev on 4/25/13.
//  Copyright (c) 2013 Emil Marashliev. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableArray *documentTitles;
@property (nonatomic, retain) UILabel *pageOneDoc;
@property (nonatomic, retain) UILabel *pageTwoDoc;
@property (nonatomic, retain) UILabel *pageThreeDoc;
@property (nonatomic) int prevIndex;
@property (nonatomic) int currIndex;
@property (nonatomic) int nextIndex;

- (void)loadPageWithId:(int)index onPage:(int)page;

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
	// Do any additional setup after loading the view.
    self.documentTitles = [[NSMutableArray alloc] init];
	NSLog(@"%f", self.view.frame.size.width);
	// create our array of documents
	for (int i = 0; i < 10; i++) {
		[self.documentTitles addObject:[NSString stringWithFormat:@"Document %i",i+1]];
	}
	
	// create placeholders for each of our documents
	self.pageOneDoc = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 568, 44)];
	self.pageTwoDoc = [[UILabel alloc] initWithFrame:CGRectMake(568, 0, 568, 44)];
	self.pageThreeDoc = [[UILabel alloc] initWithFrame:CGRectMake(568 * 2, 0, 568, 44)];
	
    
	// load all three pages into our scroll view
	[self loadPageWithId:9 onPage:0];
	[self loadPageWithId:0 onPage:1];
	[self loadPageWithId:1 onPage:2];
	
	[self.scrollView addSubview:self.pageOneDoc];
	[self.scrollView addSubview:self.pageTwoDoc];
	[self.scrollView addSubview:self.pageThreeDoc];
	
	// adjust content size for three pages of data and reposition to center page
	self.scrollView.contentSize = CGSizeMake(568 * 3, 300);
	[self.scrollView scrollRectToVisible:CGRectMake(568, 0, 568, 300) animated:NO];
}




- (void)loadPageWithId:(int)index onPage:(int)page {
	// load data for page
	switch (page) {
		case 0:
			self.pageOneDoc.text = [self.documentTitles objectAtIndex:index];
			break;
		case 1:
			self.pageTwoDoc.text = [self.documentTitles objectAtIndex:index];
			break;
		case 2:
			self.pageThreeDoc.text = [self.documentTitles objectAtIndex:index];
			break;
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	// All data for the documents are stored in an array (documentTitles).
	// We keep track of the index that we are scrolling to so that we
	// know what data to load for each page.
	if(self.scrollView.contentOffset.x > 568) {
		// We are moving forward. Load the current doc data on the first page.
		[self loadPageWithId:self.currIndex onPage:0];
		// Add one to the currentIndex or reset to 0 if we have reached the end.
		self.currIndex = (self.currIndex >= [self.documentTitles count]-1) ? 0 : self.currIndex + 1;
		[self loadPageWithId:self.currIndex onPage:1];
		// Load content on the last page. This is either from the next item in the array
		// or the first if we have reached the end.
		self.nextIndex = (self.currIndex >= [self.documentTitles count]-1) ? 0 : self.currIndex + 1;
		[self loadPageWithId:self.nextIndex onPage:2];
	}
    
	if(self.scrollView.contentOffset.x < self.scrollView.frame.size.width) {
		// We are moving backward. Load the current doc data on the last page.
		[self loadPageWithId:self.currIndex onPage:2];
		// Subtract one from the currentIndex or go to the end if we have reached the beginning.
		self.currIndex = (self.currIndex == 0) ? [self.documentTitles count]-1 : self.currIndex - 1;
		[self loadPageWithId:self.currIndex onPage:1];
		// Load content on the first page. This is either from the prev item in the array
		// or the last if we have reached the beginning.
		self.prevIndex = (self.currIndex == 0) ? [self.documentTitles count]-1 : self.currIndex - 1;
		[self loadPageWithId:self.prevIndex onPage:0];
	}
	
	// Reset offset back to middle page
	[self.scrollView scrollRectToVisible:CGRectMake(568 , 0, 568, 300) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
