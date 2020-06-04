

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface BackgroundTaskManager : NSObject

+(instancetype)sharedBackgroundTaskManager; //singlton

-(UIBackgroundTaskIdentifier)beginNewBackgroundTask;  //start a new task method

@end
