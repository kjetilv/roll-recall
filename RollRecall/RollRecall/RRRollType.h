//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RRRoll;

typedef enum RRRollSize : NSUInteger {
    _110 = 0,
    _120 = 1,
    _126 = 2,
    _127 = 3,
    _135 = 4,
    _220 = 5
} RRRollSize;

@interface RRRollType : NSObject {
    NSString *manufacturer;
    enum RRRollSize format;
    NSInteger iso;
    NSString *name;
}

- (RRRollType *)initWith:(NSString *)manufacturer name:(NSString *)name iso:(NSInteger)iso format:(RRRollSize)format1;
-(RRRoll *)newRoll:(NSInteger)iso;
@end
