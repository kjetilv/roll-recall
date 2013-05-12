//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@class RRRollType;

@interface RRRoll : NSObject
{
    RRRollType *type;
    NSMutableArray *loads;
    NSInteger iso;
}
-(RRRoll *)initWithIso:(NSInteger)value;
-(RRRoll *)load;
@end
