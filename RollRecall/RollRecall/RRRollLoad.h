//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface RRRollLoad : NSObject
@property (readonly, strong, nonatomic) NSDate *loadTime;
@property (readonly, strong, nonatomic) NSDate *unloadTime;
@property (readonly, nonatomic) NSUInteger exposures;
@end
