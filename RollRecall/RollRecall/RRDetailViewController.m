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

    _navigationBar = [[UINavigationBar alloc] init];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Roll"];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(saveAndExit)];
    navigationItem.rightBarButtonItem = addButtonItem;
    [_navigationBar pushNavigationItem:navigationItem animated:NO];
    [rootView addSubview:_navigationBar];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed: @"1368149063_Roll.png"];
    _rollImageView = imageView;

    UILabel *selectedView = [[UILabel alloc] init];
    selectedView.text = @"No type selected";
    _rollTypeSelected = selectedView;

    NSArray *rollTypes = @[
            [[RRRollType alloc] initWith:@"Kodak" name:@"Tri-X" iso:400 format:_135],
            [[RRRollType alloc] initWith:@"Foma" name:@"Fomapan Profi Action Line" iso:400 format:_135],
            [[RRRollType alloc] initWith:@"Ilford" name:@"HP5-Plus" iso:400 format:_135]
    ];

    UIPickerView *rollSelector = [[UIPickerView alloc] init];

    _rollTypePickerDelegate = [[RRRollTypePickerDelegate alloc] initWith: rollTypes];
    rollSelector.delegate = _rollTypePickerDelegate;

    _rollTypePickerDataSource = [[RRRollTypePickerDataSource alloc] initWith: rollTypes];
    rollSelector.dataSource = _rollTypePickerDataSource;

    _rollTypeSelector = rollSelector;

    [rootView addSubview:_rollImageView];
    [rootView addSubview:_rollTypeSelected];
    [rootView addSubview:_rollTypeSelector];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *navigation = _navigationBar;
    UIView *image = _rollImageView;
    UIView *selected = _rollTypeSelected;
    UIView *selector = _rollTypeSelector;

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
