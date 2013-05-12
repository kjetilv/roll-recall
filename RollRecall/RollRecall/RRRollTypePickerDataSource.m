//
// Created by Kjetil Valstadsve on 2013-05-12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RRRollTypePickerDataSource.h"
#import "RRRollType.h"

@interface RRRollTypePickerDataSource()<UIPickerViewDelegate>
@property (strong, nonatomic) NSArray *rollTypes;
@end

@implementation RRRollTypePickerDataSource

-(RRRollTypePickerDataSource *)init {
    self = [super init];
    if (self) {
        _rollTypes = @[
                [[RRRollType alloc] initWith:@"Kodak" name:@"Tri-X" iso:400 format:_135],
                [[RRRollType alloc] initWith:@"Foma" name:@"Fomapan Profi Action Line" iso:400 format:_135],
                [[RRRollType alloc] initWith:@"Ilford" name:@"HP5-Plus" iso:400 format:_135]
        ];
    }
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.rollTypes.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    RRRollType *film = [self.rollTypes objectAtIndex: row];
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
