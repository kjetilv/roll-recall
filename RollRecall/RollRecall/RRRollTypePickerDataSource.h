//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface RRRollTypePickerDataSource : UIViewController<UIPickerViewDataSource>
@property (readonly, strong, nonatomic) NSArray *manufacturers;
-(RRRollTypePickerDataSource *)initWith:(NSArray *)manufacturers;
@end
