
#import "XUserStatusFeedScreen.h"
#import "XUserStatusDetailScreen.h"

@interface XUserStatusFeedScreen ()

@end

@interface XUserStatusFeedScreen () <NSURLConnectionDelegate, UIAlertViewDelegate>
@end

@implementation XUserStatusFeedScreen {

	UIActivityIndicatorView* x_indicator;
	NSString*				 x_user;
	NSString*				 x_url;
	NSArray*			     x_tweets;
	
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
   
	if([title isEqualToString:@"OK"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void) setupActivityIndicator {
	UIActivityIndicatorView* indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	
	[self.view addSubview:indicator];
	[indicator startAnimating];
	
	x_indicator = indicator;
}


-(id) initWithUser:(NSString*)user {
	if ((self = [super initWithStyle:UITableViewStylePlain])) {
		self.title = user;
		x_user     = user;
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setup];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


-(void) setup {
	self.tableView.rowHeight = 50.0f;
	
	[self setupUrl];
	[self setupActivityIndicator];
	[self setupTweetsArray];
}


-(void) reloadData {
	[self.tableView reloadData];
	[x_indicator stopAnimating];
}


-(void) setupTweetsArray {
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	NSBlockOperation *fetchStreamOperation = [[NSBlockOperation alloc] init];
	
	[fetchStreamOperation addExecutionBlock:^{
		NSURL* publicTimeline = [NSURL URLWithString:x_url];
		NSError* error        = nil;
		NSData* tweetData     = [NSData dataWithContentsOfURL:publicTimeline options:NSDataReadingMapped error:&error];
		
		if (tweetData != nil) {
			NSArray* tweets = [NSJSONSerialization JSONObjectWithData:tweetData options:kNilOptions error:&error];
			x_tweets = tweets;
			
			[self performSelectorOnMainThread:@selector(reloadData) withObject:tweets waitUntilDone:NO];
		}
		else {
			[self performSelectorOnMainThread:@selector(showAlert) withObject:nil waitUntilDone:NO];
		}
	}];
	
	[queue addOperation:fetchStreamOperation];
}


-(void) showAlert {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"User %@ nicht gefunden", x_user]
													message:@""
												   delegate:self
										  cancelButtonTitle:nil
										  otherButtonTitles:@"OK", nil];
	[alert show];
}


-(void) setupUrl {
	x_url = [NSString stringWithFormat:@"https://api.twitter.com/1/statuses/user_timeline/%@.json", x_user];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return x_tweets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [UITableViewCell new];
	NSDictionary *tweet   = [x_tweets objectAtIndex:indexPath.row];
	cell.textLabel.text   = [tweet objectForKey:@"text"];
	cell.textLabel.font   = [UIFont boldSystemFontOfSize:20];

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary* tweet = [x_tweets objectAtIndex:indexPath.row];
	XUserStatusDetailScreen* detailScreen = [[XUserStatusDetailScreen alloc] initWithTweet:tweet];
	
	[self.navigationController pushViewController:detailScreen animated:YES];
}


-(void) viewDidLayoutSubviews {
	x_indicator.frame = CGRectMake(self.view.frame.size.width / 2 - 10, 15, 20, 20);
}


@end
