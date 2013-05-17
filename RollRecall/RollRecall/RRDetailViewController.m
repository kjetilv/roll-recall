//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"
#import "RRRollType.h"
#import "RRRollManufacturer.h"

@interface RRDetailViewController() <UIPickerViewDelegate, UIPickerViewDataSource>
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UILabel *rollTypeSelected;
@property (strong, nonatomic) UIPickerView *manufacturerSelector;
@property (strong, nonatomic) UIPickerView *rollTypeSelector;
@property (strong, nonatomic) UIPickerView *formatSelector;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) NSArray *manufacturers;
@property (nonatomic) NSUInteger manufacturer;
@property (nonatomic) NSUInteger rollType;
@property (nonatomic) NSUInteger format;
@end

@implementation RRDetailViewController

- (void)loadView {
    UIView *rootView = [[UIView alloc] init];

    self.navigationBar = [[UINavigationBar alloc] init];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Roll"];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(saveAndExit)];
    navigationItem.rightBarButtonItem = addButtonItem;
    [self.navigationBar pushNavigationItem:navigationItem animated:NO];
    [rootView addSubview:self.navigationBar];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed: @"1368149063_Roll.png"];
    self.rollImageView = imageView;

    UILabel *selectedView = [[UILabel alloc] init];
    selectedView.text = @"No type selected";
    self.rollTypeSelected = selectedView;

    self.manufacturer = 0;
    self.manufacturers = @[
            [[RRRollManufacturer alloc] initWith: @"Kodak" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Tri-X" iso:320 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:100 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:3200 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Foma" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Fomapan" iso:100 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:200 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"FujiFilm" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Neopan" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Ilford" rollTypes: @[
                    [[RRRollType alloc] initWith: @"HP5 Plus" iso:400 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"FP4 Plus" iso:125 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"PanF Plus" iso:50 filmType:negative_bw formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ]
    ];

    UIPickerView *manufacturerSelector = [[UIPickerView alloc] init];
    manufacturerSelector.delegate = self;
    manufacturerSelector.dataSource = self;

    UIPickerView *rollSelector = [[UIPickerView alloc] init];
    rollSelector.delegate = self;
    rollSelector.dataSource = self;

    UIPickerView *formatSelector = [[UIPickerView alloc] init];
    formatSelector.delegate = self;
    formatSelector.dataSource = self;

    self.manufacturerSelector = manufacturerSelector;
    self.rollTypeSelector = rollSelector;
    self.formatSelector = formatSelector;

    self.manufacturer = 0;
    self.rollType = 0;
    self.format = 0;

    [rootView addSubview:self.rollImageView];
    [rootView addSubview:self.rollTypeSelected];
    [rootView addSubview:self.manufacturerSelector];
    [rootView addSubview:self.rollTypeSelector];
    [rootView addSubview:self.formatSelector];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *navigation = self.navigationBar;
    UIView *image = self.rollImageView;
    UIView *selected = self.rollTypeSelected;
    UIView *mselector = self.manufacturerSelector;
    UIView *rselector = self.rollTypeSelector;
    UIView *fselector = self.formatSelector;

    NSDictionary *views = NSDictionaryOfVariableBindings(navigation, image, selected, mselector, rselector, fselector);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[navigation]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image(==100)]-[selected(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[image(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[selected(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[mselector(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[rselector(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[fselector(==100)]" views:views]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _manufacturerSelector) {
        _manufacturer = (NSUInteger) row;
    }
    if (pickerView == _rollTypeSelector) {
        _rollType = (NSUInteger) row;
    }
    if (pickerView == _formatSelector) {
        _format = (NSUInteger) row;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _manufacturerSelector) {
        return [_manufacturers count];
    }
    if (pickerView == _rollTypeSelector) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex: _manufacturer];
        return [manu.rollTypes count];
    }
    if (pickerView == _formatSelector) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex: _manufacturer];
        RRRollType *rType = [manu.rollTypes objectAtIndex: _rollType];
        return [rType.formats count];
    }
    return -1;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
  }

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    RRRollManufacturer *manufacturer = [self.manufacturers objectAtIndex: (NSUInteger)row];
    if (pickerView == _manufacturerSelector) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) row];
        return manu.name;
    }
    if (pickerView == _rollTypeSelector) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) _manufacturer];
        RRRollType *rollType = [manu.rollTypes objectAtIndex:(NSUInteger) row];
        return rollType.name;
    }
    if (pickerView == _formatSelector) {
        RRRollManufacturer *manu = [_manufacturers objectAtIndex:(NSUInteger) _manufacturer];
        RRRollType *rollType = [manu.rollTypes objectAtIndex:(NSUInteger) _rollType];
        NSArray *formats = rollType.formats;
        return [formats objectAtIndex:(NSUInteger) row];
    }
    return nil;
}

- (void)saveAndExit {
    [self.delegate detailViewControllerDidFinish:self];
}
@end
