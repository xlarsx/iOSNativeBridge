//
//  INativeBridgeDelegate.h
//

#import <Foundation/Foundation.h>

@protocol INativeBridgeDelegate <NSObject>

-(void)handleCall:(NSString*)functionName args:(NSArray*)args callback: (int) callbackId;

@end
