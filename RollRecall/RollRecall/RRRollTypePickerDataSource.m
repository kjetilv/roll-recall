//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollTypePickerDataSource.h"

@interface RRRollTypePickerDataSource()
@property (strong, nonatomic) NSArray *rollTypes;
@end

@implementation RRRollTypePickerDataSource
- (RRRollTypePickerDataSource *)initWith:(NSArray *)rollTypes {
    self = [super init];
    if (self) {
        _rollTypes = rollTypes;
    }
    return self;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.rollTypes.count;
}
@end
