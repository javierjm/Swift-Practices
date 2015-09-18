
@implementation KGDebuggingAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];

  UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
  if ( localNotification )
  {
       UIAlertView *debugAlert = [[UIAlertView alloc] initWithTitle:@"Debug" message:localNotification.alertBody delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [debugAlert show];
  }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notif {
    DNSLog(@"Notification logged is %@",notif);
}

@end
