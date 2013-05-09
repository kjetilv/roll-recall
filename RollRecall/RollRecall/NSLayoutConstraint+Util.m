#import "NSLayoutConstraint+Util.h"

@implementation NSLayoutConstraint (Util)

+ (NSArray *)constraintsWithVisualFormat:(NSString *)format views:(NSDictionary *)views {
    return [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:0 views:views];
}

@end