//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollTypePickerDelegate.h"
#import "RRRollType.h"
#import "RRRollManufacturer.h"

@interface RRRollTypePickerDelegate () <UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *manufacturers;
@end

@implementation RRRollTypePickerDelegate

-(RRRollTypePickerDelegate *)initWith:(NSArray *)manufacturers {
    self = [super init];
    if (self) {
        _manufacturers = manufacturers;
    }
    return self;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    RRRollManufacturer *manu = [self.manufacturers objectAtIndex:row];
    switch (component) {
        case 0: {
            return manu.name;
        }
        case 1: {
            return manu.rollTypes;
        }
        case 2: {
            return [NSString stringWithFormat:@"%d", manu.iso];
        }
        default:
            return nil;
    }
}

@end
