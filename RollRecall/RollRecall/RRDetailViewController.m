//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import <CoreLocation/CoreLocation.h>
#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"
#import "RRRollType.h"
#import "RRRollManufacturer.h"
#import "PickerViewPopup.h"

@interface RRDetailViewController()
        <UIPickerViewDelegate,
         UIPickerViewDataSource,
         PickerViewPopupDelegate,
         UITableViewDelegate,
         UITableViewDataSource,
         CLLocationManagerDelegate>
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) NSArray *manufacturers;
@property (strong, nonatomic) NSArray *isoValues;
@property (strong, nonatomic) UITableView *filmSelectTable;
@property (nonatomic) NSUInteger manufacturer;
@property (nonatomic) NSUInteger rollType;
@property (nonatomic) NSUInteger format;
@property (nonatomic) NSUInteger iso;
@property (nonatomic) NSUInteger currentPickings;
@property (strong, nonatomic) PickerViewPopup *valuePicker;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *lastLocation;
@end

@implementation RRDetailViewController

- (void)buttonClicked {
    self.valuePicker.hidden = YES;
}

- (RRRollManufacturer *)getSelectedManufacturer {
    return [self.manufacturers objectAtIndex:(NSUInteger) self.manufacturer];
}

- (RRRollType *)getSelectedRollType {
    RRRollManufacturer *manufacturer = self.getSelectedManufacturer;
    return [manufacturer.rollTypes objectAtIndex:self.rollType];
}

- (RRRollSize)getSelectedRollSize {
    RRRollType *type = self.getSelectedRollType;
    return (RRRollSize)[type.formats objectAtIndex: self.format];
}

- (NSUInteger)getSelectedISO {
    return (NSUInteger) [self.isoValues objectAtIndex:self.iso];
}

- (void)loadView {
    UIView *rootView = [[UIView alloc] init];

    self.navigationBar = [[UINavigationBar alloc] init];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Roll"];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(saveAndExit)];
    navigationItem.rightBarButtonItem = addButtonItem;
    [self.navigationBar pushNavigationItem:navigationItem animated:NO];
    [rootView addSubview:self.navigationBar];

    PickerViewPopup *picker = [[PickerViewPopup alloc] init];
    picker.hidden = YES;
    picker.buttonClickedDelegate = self;
    picker.picker.delegate = self;
    picker.picker.dataSource = self;
    self.valuePicker = picker;

    CLLocationManager *location = [[CLLocationManager alloc] init];
    location.delegate = self;
    location.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    location.distanceFilter = 3000;
    [location startUpdatingLocation];
    self.locationManager = location;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 250, 1000) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.hidden = NO;
    self.filmSelectTable = tableView;

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed: @"1368149063_Roll.png"];
    self.rollImageView = imageView;

    self.manufacturer = 0;
    self.manufacturers = @[
            [[RRRollManufacturer alloc] initWith: @"Kodak" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Tri-X" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:100 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:3200 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Foma" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Fomapan" iso:100 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:200 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"FujiFilm" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Neopan" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Ilford" rollTypes: @[
                    [[RRRollType alloc] initWith: @"HP5 Plus" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"FP4 Plus" iso:125 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]],
                    [[RRRollType alloc] initWith: @"PanF Plus" iso:50 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _135], [NSNumber numberWithInt: _120]]]]
            ]
    ];
    self.isoValues = @[
            [NSNumber numberWithInt: 6 ],
            [NSNumber numberWithInt: 8 ],
            [NSNumber numberWithInt: 10 ],
            [NSNumber numberWithInt: 12 ],
            [NSNumber numberWithInt: 16 ],
            [NSNumber numberWithInt: 20 ],
            [NSNumber numberWithInt: 25 ],
            [NSNumber numberWithInt: 32 ],
            [NSNumber numberWithInt: 40 ],
            [NSNumber numberWithInt: 50 ],
            [NSNumber numberWithInt: 64 ],
            [NSNumber numberWithInt: 80 ],
            [NSNumber numberWithInt: 100 ],
            [NSNumber numberWithInt: 125 ],
            [NSNumber numberWithInt: 160 ],
            [NSNumber numberWithInt: 200 ],
            [NSNumber numberWithInt: 250 ],
            [NSNumber numberWithInt: 320 ],
            [NSNumber numberWithInt: 400 ],
            [NSNumber numberWithInt: 500 ],
            [NSNumber numberWithInt: 640 ],
            [NSNumber numberWithInt: 800 ],
            [NSNumber numberWithInt: 1000 ],
            [NSNumber numberWithInt: 1250 ],
            [NSNumber numberWithInt: 1600 ],
            [NSNumber numberWithInt: 2000 ],
            [NSNumber numberWithInt: 2500 ],
            [NSNumber numberWithInt: 3200 ],
            [NSNumber numberWithInt: 4000 ],
            [NSNumber numberWithInt: 5000 ],
            [NSNumber numberWithInt: 6400 ],
    ];

    self.manufacturer = 0;
    self.rollType = 0;
    self.format = 0;
    self.iso = 12;

    [rootView addSubview:self.rollImageView];
    [rootView addSubview:self.filmSelectTable];
    [rootView addSubview:self.valuePicker];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *navigation = self.navigationBar;
    UIView *image = self.rollImageView;
    UIView *mPicker = self.valuePicker;
    UITableView *filmTable = self.filmSelectTable;

    NSDictionary *views = NSDictionaryOfVariableBindings(navigation, image, mPicker, filmTable);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[navigation]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[filmTable]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[mPicker]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]-[image(==100)]-[filmTable]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[mPicker]-|" views:views]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.currentPickings == 0) {
        self.manufacturer = (NSUInteger) row;
    }
    if (self.currentPickings == 1) {
        self.rollType = (NSUInteger) row;
    }
    if (self.currentPickings == 2) {
        self.format = (NSUInteger) row;
    }
    if (self.currentPickings == 3) {
        self.iso = (NSUInteger) row;
    }

    [self.filmSelectTable reloadData];
    self.valuePicker.hidden = YES;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.currentPickings == 0) {
        return [self.manufacturers count];
    }
    if (self.currentPickings == 1) {
        RRRollManufacturer *manu = [self.manufacturers objectAtIndex: self.manufacturer];
        return [manu.rollTypes count];
    }
    if (self.currentPickings == 2) {
        RRRollManufacturer *manu = [self.manufacturers objectAtIndex: self.manufacturer];
        RRRollType *rType = [manu.rollTypes objectAtIndex: self.rollType];
        return [rType.formats count];
    }
    if (self.currentPickings == 3) {
        return [self.isoValues count];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.currentPickings == 0) {
        RRRollManufacturer *manu = [self.manufacturers objectAtIndex:(NSUInteger) row];
        return manu.name;
    }
    if (self.currentPickings == 1) {
        RRRollManufacturer *manu = [self.manufacturers objectAtIndex:(NSUInteger) self.manufacturer];
        RRRollType *roll = [manu.rollTypes objectAtIndex:(NSUInteger) row];
        return [NSString stringWithFormat:@"%@ ISO%d", roll.name, roll.iso];
    }
    if (self.currentPickings == 2) {
        RRRollManufacturer *manu = [self.manufacturers objectAtIndex:(NSUInteger) self.manufacturer];
        RRRollType *roll = [manu.rollTypes objectAtIndex:(NSUInteger) self.rollType];
        return [NSString stringWithFormat:@"%@", [roll.formats objectAtIndex:(NSUInteger) row]];
    }
    if (self.currentPickings == 3) {
        return [NSString stringWithFormat:@"%@", [self.isoValues objectAtIndex:(NSUInteger) row]];
    }
    return nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.lastLocation = [locations lastObject];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Film type";
        default: return @"Load parameters";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 3;
        default: return 3;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger selectedRow;
    switch (indexPath.section) {
        case 0 :
            self.currentPickings = (NSUInteger) indexPath.row;
            selectedRow = self.currentPickings == 0 ? self.manufacturer
                    : self.currentPickings == 1 ? self.rollType
                            : self.currentPickings == 2 ? self.format
                                    : 0;
            break;
        case 1:
            if (indexPath.row == 0) {
                self.currentPickings = (NSUInteger) (3 + indexPath.row);
                selectedRow = self.currentPickings == 3 ? self.iso
                        : 0;
            }
            break;
        default:
            break;
    }
    self.valuePicker.hidden = NO;
    [self.valuePicker.picker reloadAllComponents];
    if (selectedRow > 0) {
        [self.valuePicker.picker selectRow:selectedRow inComponent:0 animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    UILabel *heading = [[UILabel alloc] init];
    heading.backgroundColor = [UIColor clearColor];
    UILabel *value= [[UILabel alloc] init];
    value.backgroundColor = [UIColor clearColor];

    UIView *cellView = [[UIView alloc] init];

    switch (indexPath.section) {
        case 0 :
            switch (indexPath.row) {
                case 0:
                    heading.text = @"Manufacturer";
                    value.text = self.getSelectedManufacturer.name;
                    break;
                case 1:
                    heading.text = @"Film";
                    value.text = [NSString stringWithFormat:@"%@ ISO%d",
                                                            self.getSelectedRollType.name,
                                                            self.getSelectedRollType.iso];
                    break;
                case 2:
                    heading.text = @"Format";
                    value.text = [NSString stringWithFormat:@"%@", self.getSelectedRollSize];
                    break;
                default:
                    break;
            }
            break;
        case 1 :
            switch (indexPath.row) {
                case 0:
                    heading.text = @"ISO";
                    value.text = [NSString stringWithFormat:@"%@", self.getSelectedISO];
                    break;
                case 1:
                    heading.text = @"Date";
                    value.text = [NSString stringWithFormat:@"%@", [NSDate date]];
                    [NSDate date];
                    break;
                case 2:
                    heading.text = @"Location";
                    value.text = self.lastLocation == nil ? @"X" : self.lastLocation.description;
                default:
                    break;
            }
            break;
        default:
            break;
    }

    [cellView addSubview: heading];
    [cellView addSubview: value];

    NSDictionary *views = NSDictionaryOfVariableBindings(heading, value, cellView);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[heading]" views:views]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[value]-0-|" views:views]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[heading]-0-|" views:views]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[value]-0-|" views:views]];

    [cell.contentView addSubview:cellView];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-9-[cellView]-9-|" views:views]];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[cellView]-9-|" views:views]];

    return cell;
}

- (void)saveAndExit {
    [self.delegate detailViewControllerDidFinish:self];
}
@end
