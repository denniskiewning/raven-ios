
#import "XUserStatusDetailScreen.h"

@interface XUserStatusDetailScreen ()

@end

@interface XUserStatusDetailScreen () 
@end

@implementation XUserStatusDetailScreen {
	
	UITextField*  x_headerTextField;
	NSString*     x_date;
	UILabel*      x_dateTextLabel;
	UITextField*  x_descriptionTextField;
	UILabel*      x_descriptionTextLabel;
	NSString*     x_description;
	NSString*     x_location;
	UILabel*      x_locationTextLabel;
	NSDictionary* x_tweet;
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (id)initWithTweet:(NSDictionary*)tweet {
	if ((self = [super init])) {
		x_tweet = tweet;
      
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"back.png"]];
	
	[self setup];
}


-(void) loadDeatails {
	x_description  = [x_tweet objectForKey:@"text"];
	
	NSString* date = [x_tweet objectForKey:@"created_at"];
	x_date         = [NSString stringWithFormat:@"Datum: %@", date];
	
	NSDictionary* user = [x_tweet objectForKey:@"user"];
	NSString* location = [user objectForKey:@"location"];
	x_location         = [NSString stringWithFormat:@"Ort: %@", location];
}


-(void) setup {
	[self loadDeatails];
	[self setupDescriptionField];
	[self setupHeaderField];
}


-(void) setupDescriptionField {
	UILabel* descriptionText               = [UILabel new];
	descriptionText.backgroundColor        = [UIColor clearColor];
	descriptionText.font                   = [UIFont boldSystemFontOfSize:13.5];
	descriptionText.lineBreakMode          = 5;
	descriptionText.numberOfLines          = 0;
	descriptionText.text                   = x_description;
	descriptionText.textAlignment          = NSTextAlignmentLeft;
	descriptionText.textColor              = [UIColor blackColor];
	descriptionText.userInteractionEnabled = NO;
	
	UITextField* descriptionTextField             = [UITextField new];
	descriptionTextField.autocapitalizationType   = UITextAutocapitalizationTypeNone;
	descriptionTextField.backgroundColor          = [UIColor whiteColor];
	descriptionTextField.borderStyle              = UITextBorderStyleRoundedRect;
	descriptionTextField.clearButtonMode          = UITextFieldViewModeWhileEditing;
	descriptionTextField.userInteractionEnabled   = NO;
	
	[self.view addSubview:descriptionTextField];
	[self.view addSubview:descriptionText];
	
	x_descriptionTextLabel = descriptionText;
	x_descriptionTextField = descriptionTextField;
}


-(void) setupHeaderField {
	UILabel* dateTextLabel               = [UILabel new];
	dateTextLabel.backgroundColor        = [UIColor clearColor];
	dateTextLabel.font                   = [UIFont boldSystemFontOfSize:13.5];
	dateTextLabel.lineBreakMode          = 5;
	dateTextLabel.numberOfLines          = 0;
	dateTextLabel.text                   = x_date;
	dateTextLabel.textAlignment          = NSTextAlignmentLeft;
	dateTextLabel.textColor              = [UIColor blackColor];
	dateTextLabel.userInteractionEnabled = NO;
	
	UILabel* locationTextLabel               = [UILabel new];
	locationTextLabel.backgroundColor        = [UIColor clearColor];
	locationTextLabel.font                   = [UIFont boldSystemFontOfSize:13.5];
	locationTextLabel.lineBreakMode          = 5;
	locationTextLabel.numberOfLines          = 0;
	locationTextLabel.text                   = x_location;
	locationTextLabel.textAlignment          = NSTextAlignmentLeft;
	locationTextLabel.textColor              = [UIColor blackColor];
	locationTextLabel.userInteractionEnabled = NO;
	
	UITextField* headerTextField           = [UITextField new];
	headerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	headerTextField.backgroundColor        = [UIColor whiteColor];
	headerTextField.borderStyle            = UITextBorderStyleRoundedRect;
	headerTextField.clearButtonMode        = UITextFieldViewModeWhileEditing;
	headerTextField.userInteractionEnabled = NO;
	
	[self.view addSubview:headerTextField];
	[self.view addSubview:dateTextLabel];
	[self.view addSubview:locationTextLabel];
	
	x_dateTextLabel     = dateTextLabel;
	x_headerTextField   = headerTextField;
	x_locationTextLabel = locationTextLabel;
}


-(void) viewDidLayoutSubviews {
	x_dateTextLabel.frame        = CGRectMake(30, 25, self.view.frame.size.width - 55, 40);
	x_descriptionTextLabel.frame = CGRectMake(30, 120, self.view.frame.size.width - 55, 280);
	x_descriptionTextField.frame = CGRectMake(20, 120, self.view.frame.size.width - 40, 280);
	x_headerTextField.frame      = CGRectMake(20, 20, self.view.frame.size.width - 40, 80);
	x_locationTextLabel.frame    = CGRectMake(30, 35, self.view.frame.size.width - 35, 80);
}


@end
