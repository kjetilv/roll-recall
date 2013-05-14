//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollTypePickerDelegate.h"
#import "RRRollType.h"

@interface RRRollTypePickerDelegate () <UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *rollTypes;
@end

@implementation RRRollTypePickerDelegate

-(RRRollTypePickerDelegate *)initWith:(NSArray *)rollTypes {
    self = [super init];
    if (self) {
        _rollTypes = rollTypes;
    }
    return self;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    RRRollType *film = [self.rollTypes objectAtIndex:row];
    switch (component) {
        case 0: {
            return film.manufacturer;
        }
        case 1: {
            return film.name;
        }
        case 2: {
            return [NSString stringWithFormat:@"%d", film.iso];
        }
        default:
            return nil;
    }
}

@end
