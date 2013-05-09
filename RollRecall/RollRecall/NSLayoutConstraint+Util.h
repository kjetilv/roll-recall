#import <Foundation/Foundation.h>

@interface NSLayoutConstraint (Util)
+ (NSArray *)constraintsWithVisualFormat:(NSString *)format views:(NSDictionary *)views;
@end