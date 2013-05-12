//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollManufacturer.h"

@interface RRRollManufacturer()
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *rollTypes;
@end

@implementation RRRollManufacturer

- (RRRollManufacturer *)initWith:(NSString *)name rollTypes:(NSArray *)rollTypes {
    self = [super init];
    if (self) {
        _name = name;
        _rollTypes = rollTypes;
    }
    return self;
}
@end
