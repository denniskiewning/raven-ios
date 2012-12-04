
#import "XUserStatusScreen.h"
#import "XUserStatusFeedScreen.h"

@interface XUserStatusScreen ()

@end


@interface XUserStatusScreen () < UITextFieldDelegate>
@end

@implementation XUserStatusScreen {
	
	UIButton*    x_goButton;
	UITextField* x_textfield;
	NSString*    x_user;
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(id) init {
    if ((self = [super init])) {
		self.title = @"Start";
	}
	
    return self;
}


-(void) handleGoButtonTap {
	XUserStatusFeedScreen* statusScreen = [[XUserStatusFeedScreen alloc] initWithUser:x_user];
	
	[self.navigationController pushViewController:statusScreen animated:YES];
}


- (void)viewDidLoad {
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"back.png"]];
	
    [super viewDidLoad];
	[self setup];
}


-(void) setup {
	[self setupTextfield];
	[self setupSearchButton];
}


-(void) setupSearchButton {
	UIButton* goButton               = [UIButton buttonWithType:UIButtonTypeCustom];
	goButton.titleLabel.font         = [UIFont fontWithName:@"Helvetica-Bold" size:14];
	goButton.titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);
	goButton.enabled                 = FALSE;
	
	[goButton addTarget:self action:@selector(handleGoButtonTap) forControlEvents:UIControlEventTouchUpInside];
	[goButton setBackgroundImage:[UIImage imageNamed:@"Login-Button"] forState:UIControlStateNormal];
	[goButton setBackgroundImage:[UIImage imageNamed:@"Login-Button-Highlighted"] forState:UIControlStateHighlighted];
	[goButton setTitle:@"Go" forState:UIControlStateNormal];
	[goButton setTitleColor:[UIColor colorWithRed:0.4 green:0.4  blue:0.4  alpha:1.0f]forState: UIControlStateNormal];
	[goButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	[self.view addSubview:goButton];
	x_goButton = goButton;
}


-(void) setupTextfield {
	UITextField* textfield = [UITextField new];
	
	textfield.autocapitalizationType   = UITextAutocapitalizationTypeNone;
	textfield.backgroundColor          = [UIColor whiteColor];
	textfield.borderStyle              = UITextBorderStyleRoundedRect;
	textfield.clearButtonMode          = UITextFieldViewModeWhileEditing;
	textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	textfield.delegate                 = self;
	textfield.font                     = [UIFont systemFontOfSize:20.0f];
	textfield.placeholder              = @"User";
	textfield.returnKeyType            = UIReturnKeyDone;
	textfield.textColor                = [UIColor blackColor];
	textfield.textAlignment            = NSTextAlignmentLeft;
	
	[self.view addSubview:textfield];
	x_textfield = textfield;

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	
	if ([x_textfield.text length] > 0) {
		x_goButton.enabled = TRUE;
		x_user = x_textfield.text;
	}
	else {
		x_goButton.enabled = FALSE;
		x_user = nil;
	}
   
    return YES;
}


-(void) viewDidLayoutSubviews {
	x_textfield.frame = CGRectMake(20, self.view.frame.size.height/2 - 55, self.view.frame.size.width - 40, 40);
	x_goButton.frame  = CGRectMake(20, self.view.frame.size.height/2 - 5, self.view.frame.size.width - 40, 40);
}

@end
