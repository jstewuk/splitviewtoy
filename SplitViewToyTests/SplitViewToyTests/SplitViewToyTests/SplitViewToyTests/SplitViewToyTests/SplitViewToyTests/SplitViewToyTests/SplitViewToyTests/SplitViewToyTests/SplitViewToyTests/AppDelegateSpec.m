#import "Kiwi.h"
#import "JSAppDelegate.h"


SPEC_BEGIN(AppDelegateSpec)

describe(@"The appDelegate", ^{
    JSAppDelegate *sut = [[JSAppDelegate alloc] init];
    context(@"when created", ^{
        it(@"is not nil.", ^{
            [sut shouldNotBeNil];
        });
    });
    context(@" after didFinishLaunchingWithOptions", ^{
        UIApplication *app = [UIApplication sharedApplication];
        [sut application:app didFinishLaunchingWithOptions:nil];
        it(@"has a rootViewController", ^{
            [sut.window.rootViewController shouldNotBeNil];
        });
    });
});
SPEC_END
