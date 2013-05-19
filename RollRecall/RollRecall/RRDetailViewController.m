//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"
#import "RRRollType.h"
#import "RRRollManufacturer.h"
#import "PickerViewPopup.h"

@interface RRDetailViewController() <UIPickerViewDelegate, UIPickerViewDataSource, PickerViewPopupDelegate, UITableViewDelegate, UITableViewDataSource>
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) NSArray *manufacturers;
@property (strong, nonatomic) UITableView *filmSelectTable;
@property (nonatomic) NSUInteger manufacturer;
@property (nonatomic) NSUInteger rollType;
@property (nonatomic) NSUInteger format;
@property (nonatomic) NSUInteger currentPickings;
@property (strong, nonatomic) PickerViewPopup *valuePicker;
@end

@implementation RRDetailViewController

- (void)buttonClicked {
    _valuePicker.hidden = YES;
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

    self.manufacturer = 0;
    self.rollType = 0;
    self.format = 0;

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
        _manufacturer = (NSUInteger) row;
    }
    if (self.currentPickings == 1) {
        _rollType = (NSUInteger) row;
    }
    if (self.currentPickings == 2) {
        _format = (NSUInteger) row;
    }

    [self.filmSelectTable reloadData];
    self.valuePicker.hidden = YES;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.currentPickings == 0) {
        return [_manufacturers count];
    }
    if (self.currentPickings == 1) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex: _manufacturer];
        return [manu.rollTypes count];
    }
    if (self.currentPickings == 2) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex: _manufacturer];
        RRRollType *rType = [manu.rollTypes objectAtIndex: _rollType];
        return [rType.formats count];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (RRRollManufacturer *)getSelectedManufacturer {
    return [_manufacturers objectAtIndex:(NSUInteger) _manufacturer];
}

- (RRRollType *)getSelectedRollType {
    RRRollManufacturer *manufacturer = self.getSelectedManufacturer;
    return [manufacturer.rollTypes objectAtIndex:_rollType];
}

- (RRRollSize)getSelectedRollSize {
    RRRollType *type = self.getSelectedRollType;
    return (RRRollSize)[type.formats objectAtIndex: _format];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (self.currentPickings == 0) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) row];
        return manu.name;
    }
    if (self.currentPickings == 1) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) _manufacturer];
        RRRollType *roll = [manu.rollTypes objectAtIndex:(NSUInteger) row];
        return [NSString stringWithFormat:@"%@ ISO%d", roll.name, roll.iso];
    }
    if (self.currentPickings == 2) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) _manufacturer];
        RRRollType *roll = [manu.rollTypes objectAtIndex:(NSUInteger) _rollType];
        return [NSString stringWithFormat:@"%@", [roll.formats objectAtIndex:(NSUInteger) row]];
    }
    return nil;
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
        default: return 1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.valuePicker.hidden = NO;
        self.currentPickings = (NSUInteger) indexPath.row;
        [self.valuePicker.picker reloadAllComponents];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    if (indexPath.section == 0) {

        UIView *cellView = [[UIView alloc] init];

        UILabel *heading = [[UILabel alloc] init];
        heading.backgroundColor = [UIColor clearColor];
        UILabel *value= [[UILabel alloc] init];
        value.backgroundColor = [UIColor clearColor];

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
            default:
                heading.text = @"Format";
                value.text = [NSString stringWithFormat:@"%@", self.getSelectedRollSize];
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

    } else {
        cell.textLabel.text = @"ISO";
    }

    return cell;
}

- (void)saveAndExit {
    [self.delegate detailViewControllerDidFinish:self];
}
@end
