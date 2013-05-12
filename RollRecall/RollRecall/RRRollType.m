//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RRRollType.h"
#import "RRRoll.h"

@implementation RRRollType {
}
- (RRRollType *)initWith:(NSString *)manufacturer1
                    name:(NSString *)name1
                     iso:(NSInteger)iso1
                  format:(RRRollSize)format1 {
    self = [super init];
    manufacturer = manufacturer1;
    format = format1;
    iso = iso1;
    name = name1;
}

- (RRRoll *)newRoll:(NSInteger)value {
    return [[RRRoll alloc] initWithIso:value];
}
@end
