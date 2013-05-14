//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface RRRollTypePickerDelegate : UIViewController<UIPickerViewDelegate>
@property (readonly, strong, nonatomic) NSArray *rollTypes;
- (RRRollTypePickerDelegate *)initWith:(NSArray *)rollTypes;
@end
