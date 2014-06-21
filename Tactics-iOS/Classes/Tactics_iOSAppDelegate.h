/**
 *  Tactics_iOSAppDelegate.h
 *  Tactics-iOS
 *
 *  Created by Amos, Grant ext (E IT S MCC) on 6/20/14.
 *  Copyright SomethingCool 2014. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "CC3DeviceCameraOverlayUIViewController.h"

@interface Tactics_iOSAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow* _window;
	CC3DeviceCameraOverlayUIViewController* _viewController;
}
@end
