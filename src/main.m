#import <Cocoa/Cocoa.h>
#import <signal.h>

#import "JitouchAppDelegate.h"

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSApplication *app = [NSApplication sharedApplication];
        [app setActivationPolicy:NSApplicationActivationPolicyAccessory];

        JitouchAppDelegate *delegate = [[JitouchAppDelegate alloc] init];
        [app setDelegate:delegate];

        dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGHUP, 0, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0));
        dispatch_source_set_event_handler(source, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate reload];
            });
        });
        dispatch_resume(source);
        signal(SIGHUP, SIG_IGN);

        [app run];
    }
    return 0;
}
