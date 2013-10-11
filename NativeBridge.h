//
//  NativeBridge.h
//

#import <Foundation/Foundation.h>
#import "INativeBridge.h"
#import "INativeBridgeDelegate.h"
#import "INativeBridge.h"
#import "SBJson.h"

@interface NativeBridge : NSObject<INativeBridge>{
    SBJsonParser * parser;
    SBJsonWriter * writer;
}
@property(retain, nonatomic) id<INativeBridgeDelegate> nativeBridgeDelegate;


@end
