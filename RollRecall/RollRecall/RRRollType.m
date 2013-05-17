//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "RRRollType.h"
#import "RRRoll.h"

@interface RRRollType()
@property (nonatomic) NSUInteger iso;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) RRFilmType filmType;
@property (strong, nonatomic) NSArray *formats;
@end

@implementation RRRollType

-(RRRollType *)initWith:(NSString *)name
                    iso:(NSUInteger)iso
               filmType:(RRFilmType)filmType
                formats:(NSArray *)formats {
    self = [super init];
    if (self) {
        _name = name;
        _iso = iso;
        _filmType = filmType;
        _formats = formats;
    }
    return self;
}

-(RRRoll *)newRoll:(NSUInteger)value {
    return [[RRRoll alloc] initWithIso:value];
}
@end
