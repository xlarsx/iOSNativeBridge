//
//  INativeBridge.h
//

#import <Foundation/Foundation.h>

@protocol INativeBridge <NSObject>

- (void) validateRequesString: (NSString *) requestString;
- (void)returnResult:(int)callbackId webView: (UIWebView *)webView args:(id)arg, ...;
- (id<INativeBridge>) obtainNativeBridge;
-(void) executeJsMethod: (NSString *) method inWebview: (UIWebView *) webView;

@end
