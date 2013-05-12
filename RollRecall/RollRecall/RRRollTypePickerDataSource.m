//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollTypePickerDataSource.h"

@interface RRRollTypePickerDataSource()
@property (strong, nonatomic) NSArray *manufacturers;
@end

@implementation RRRollTypePickerDataSource
- (RRRollTypePickerDataSource *)initWith:(NSArray *)manufacturers {
    self = [super init];
    if (self) {
        _manufacturers = manufacturers;
    }
    return self;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.manufacturers.count;
}
@end
