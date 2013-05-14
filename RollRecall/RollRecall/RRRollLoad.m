//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollLoad.h"

@interface RRRollLoad ()
@property (strong, nonatomic) NSDate *loadTime;
@property (strong, nonatomic) NSDate *unloadTime;
@property (nonatomic) NSUInteger exposures;
@end

@implementation RRRollLoad

-(RRRollLoad *)init {
    self = [super init];
    if (self) {
        _loadTime = [NSDate date];
    }
    return self;
}

-(RRRollLoad *)unloaded {
    self.unloadTime = [NSDate date];
    return self;
}
@end
