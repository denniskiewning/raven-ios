
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[XUserStatusScreen alloc] init];
	
	UINavigationController* controller = [[UINavigationController alloc]initWithRootViewController:self.viewController];
	
	self.window.rootViewController = controller;
    
	[self.window makeKeyAndVisible];
    
	return YES;
}


@end
