//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RRRollType.h"
#import "RRRoll.h"

@interface RRRollType()
@property (strong, nonatomic) NSString *manufacturer;
@property (nonatomic) enum RRRollSize format;
@property (nonatomic) NSUInteger iso;
@property (strong, nonatomic) NSString *name;
@end

@implementation RRRollType

-(RRRollType *)initWith:(NSString *)manufacturer
                   name:(NSString *)name
                    iso:(NSUInteger)iso
                 format:(RRRollSize)format {
    self = [super init];
    if (self) {
        _manufacturer = manufacturer;
        _format = format;
        _iso = iso;
        _name = name;
    }
    return self;
}

-(RRRoll *)newRoll:(NSUInteger)value {
    return [[RRRoll alloc] initWithIso:value];
}
@end
