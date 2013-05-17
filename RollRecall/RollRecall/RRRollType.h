//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RRRoll;

typedef enum RRRollSize : NSUInteger {
    _110 = 110,
    _120 = 120,
    _126 = 126,
    _127 = 127,
    _135 = 135,
    _220 = 220
} RRRollSize;

typedef enum RRFilmType: NSUInteger {
    c41 = 0,
    negative_color = 1,
    negative_bw = 2,
    reversal_color= 3,
    reversal_bw = 4
} RRFilmType;

@interface RRRollType : NSObject
@property (readonly, nonatomic) NSUInteger iso;
@property (readonly, nonatomic) NSArray* formats;
@property (readonly, nonatomic) RRFilmType filmType;
@property (readonly, strong, nonatomic) NSString *name;

- (RRRollType *)initWith:(NSString *)name
                     iso:(NSUInteger)iso
                filmType:(RRFilmType)filmType
                 formats:(NSArray *)formats;
- (RRRoll *)newRoll:(NSUInteger)iso;
@end
