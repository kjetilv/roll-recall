//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRoll.h"
#import "RRRollType.h"
#import "RRRollLoad.h"


@implementation RRRoll {
}

- (RRRoll *)initWithIso:(NSInteger)value {
    self = [super init];
    iso = value;
    return self;
}

- (RRRoll *)load {
    if (loads == Nil) {
        loads = [NSMutableArray arrayWithCapacity:0];
    }
    RRRollLoad *load = [[RRRollLoad alloc] init];
    [loads addObject:load];
    return self;
}
@end
