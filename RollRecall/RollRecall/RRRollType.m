//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RRRollType.h"
#import "RRRoll.h"

@implementation RRRollType {
}
- (RRRoll *)newRoll:(NSInteger)value {
    return [[RRRoll alloc] initWithIso:value];
}
@end
