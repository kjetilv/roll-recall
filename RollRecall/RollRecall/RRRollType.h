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
    _220 = 5,

    size = 6
} RRRollSize;

@interface RRRollType : NSObject
@property (readonly, nonatomic) NSUInteger iso;
@property (readonly, nonatomic) NSArray* formats;
@property (readonly, strong, nonatomic) NSString *name;

- (RRRollType *)initWith:(NSString *)name iso:(NSUInteger)iso formats:(NSArray *)formats;
-(RRRoll *)newRoll:(NSUInteger)iso;
@end
