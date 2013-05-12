//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RRRoll.h"
#import "RRRollType.h"
#import "RRRollLoad.h"

@interface RRRoll()
@property (strong, nonatomic) RRRollType *type;
@property (strong, nonatomic) NSMutableArray *loads;
@property (nonatomic) NSUInteger iso;
@end

@implementation RRRoll

- (RRRoll *)initWithIso:(NSUInteger)iso {
    self = [super init];
    _iso = iso;
    _loads = [NSMutableArray arrayWithCapacity:0];
    return self;
}

- (RRRoll *)load {
    RRRollLoad *load = [[RRRollLoad alloc] init];
    [_loads addObject:load];
    return self;
}
@end
