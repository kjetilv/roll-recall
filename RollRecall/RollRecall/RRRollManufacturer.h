//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface RRRollManufacturer : NSObject
@property (readonly, strong, nonatomic) NSString *name;
@property (readonly, strong, nonatomic) NSArray *rollTypes;

-(RRRollManufacturer *) initWith:(NSString *)name rollTypes:(NSArray *)rollTypes;
@end
