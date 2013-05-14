//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"
#import "RRRollType.h"
#import "RRRollTypePickerDelegate.h"
#import "RRRollTypePickerDataSource.h"
#import "RRRollManufacturer.h"

@interface RRDetailViewController()
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UILabel *rollTypeSelected;
@property (strong, nonatomic) UIPickerView *rollTypeSelector;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) RRRollTypePickerDelegate *rollTypePickerDelegate;
@property (strong, nonatomic) RRRollTypePickerDataSource *rollTypePickerDataSource;
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

    NSArray *manufacturers = @[
            [[RRRollManufacturer alloc] initWith: @"Kodak" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Tri-X" iso:320 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:100 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:400 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"T-Max" iso:3200 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Foma" rollTypes: @[
                    [[RRRollType alloc] initWith: @"Fomapan" iso:100 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:200 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"Fomapan" iso:400 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ],
            [[RRRollManufacturer alloc] initWith: @"Ilford" rollTypes: @[
                    [[RRRollType alloc] initWith: @"HP5 Plus" iso:400 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"FP4 Plus" iso:125 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]],
                    [[RRRollType alloc] initWith: @"PanF Plus" iso:50 formats:
                            @[[NSNumber numberWithInt: _120], [NSNumber numberWithInt: _135]]]]
            ]
    ];

    UIPickerView *rollSelector = [[UIPickerView alloc] init];

    _rollTypePickerDelegate = [[RRRollTypePickerDelegate alloc] initWith: rollTypes];
    rollSelector.delegate = _rollTypePickerDelegate;

    _rollTypePickerDataSource = [[RRRollTypePickerDataSource alloc] initWith: rollTypes];
    rollSelector.dataSource = _rollTypePickerDataSource;

    self.rollTypeSelector = rollSelector;

    [rootView addSubview:self.rollImageView];
    [rootView addSubview:self.rollTypeSelected];
    [rootView addSubview:self.rollTypeSelector];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *navigation = self.navigationBar;
    UIView *image = self.rollImageView;
    UIView *selected = self.rollTypeSelected;
    UIView *selector = self.rollTypeSelector;

    NSDictionary *views = NSDictionaryOfVariableBindings(navigation, image, selected, selector);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[navigation]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image(==100)]-[selected(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[image(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[selected(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[selector(==100)]" views:views]];
}

- (void)saveAndExit {
    [self.delegate detailViewControllerDidFinish:self];
}

@end
