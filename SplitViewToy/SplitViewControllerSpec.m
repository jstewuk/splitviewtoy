#import "Kiwi.h"
#import "JSSplitViewController.h"


SPEC_BEGIN(SplitViewControllerSpec)

describe(@"The splitViewController", ^{
    JSSplitViewController *sut = [[JSSplitViewController alloc] init];
    context(@"when created", ^{
        it(@"is not nil.", ^{
            [sut shouldNotBeNil];
        });
    });
    context(@" after didFinishLaunchingWithOptions", ^{
    });
});
SPEC_END
