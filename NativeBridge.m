//
//  NativeBridge.m
//

#import "NativeBridge.h"

@implementation NativeBridge

@synthesize nativeBridgeDelegate;

- (void)dealloc
{
    [self setNativeBridgeDelegate: nil];
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)validateRequesString:(NSString *)requestString{
    if([self  nativeBridgeDelegate] != nil){
        if ([requestString hasPrefix:@"js-frame:"])
            [self separateComponentsOfRequestString: requestString];

    }
}

- (void)returnResult:(int)callbackId webView: (UIWebView *)webView args:(id)arg, ...{

    if(webView != nil)
    {
        va_list argsList;
        NSMutableArray *resultArray = [[NSMutableArray alloc] init];
        
        if(arg != nil) {
            [resultArray addObject:arg];
            va_start(argsList, arg);
            while((arg = va_arg(argsList, id)) != nil)
                [resultArray addObject:arg];
            va_end(argsList);
        }
        
        NSString *resultArrayString = [writer stringWithObject:resultArray];
        [resultArray release];
        NSString * callBackString = [NSString stringWithFormat:@"NativeBridge.resultForCallback(%d,%@);",callbackId,resultArrayString];
        [webView performSelectorOnMainThread: @selector(stringByEvaluatingJavaScriptFromString:) withObject:callBackString waitUntilDone:false];
    }
}

-(id<INativeBridge>) obtainNativeBridge{
    return self;
}

-(void) separateComponentsOfRequestString: (NSString *)requestString{
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    NSString *function = (NSString*)[components objectAtIndex:1];
    int callbackId = [((NSString*)[components objectAtIndex:2]) intValue];
    NSString *argsAsString = [(NSString*)[components objectAtIndex:3]
                              stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *args = (NSArray*)[parser objectWithString:argsAsString error:nil];
    
    [[self nativeBridgeDelegate]  handleCall:function args:args callback:callbackId];
}

-(void)executeJsMethod:(NSString *)method inWebview:(UIWebView *)webView{
     [webView performSelectorOnMainThread: @selector(stringByEvaluatingJavaScriptFromString:) withObject:method waitUntilDone:false];
}
@end
