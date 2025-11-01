#import <Foundation/Foundation.h>

void LookinStart(void) {
    Class cls = NSClassFromString(@"LookinServer");
    if (!cls) return;
    if (![cls respondsToSelector:@selector(sharedInstance)]) return;

    id server = ((id (*)(id, SEL))[cls methodForSelector:@selector(sharedInstance)])(cls, @selector(sharedInstance));
    if ([server respondsToSelector:@selector(start)]) {
        ((void (*)(id, SEL))[server methodForSelector:@selector(start)])(server, @selector(start));
    }
}
