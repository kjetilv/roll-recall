//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RRRollType;

@interface RRRoll : NSObject
@property (readonly, strong, nonatomic) RRRollType *type;
@property (readonly,strong, nonatomic) NSMutableArray *loads;
@property (readonly,nonatomic) NSUInteger iso;

-(RRRoll *)initWithIso:(NSUInteger)iso;
-(RRRoll *)load;
@end
