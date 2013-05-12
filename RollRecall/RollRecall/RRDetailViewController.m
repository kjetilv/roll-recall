//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"
#import "RRRollType.h"
#import "RRRollTypePickerDataSource.h"

@interface RRDetailViewController()
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UIPickerView *rollTypeSelector;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@property (strong, nonatomic) RRRollTypePickerDataSource *dataSource;
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

    UIPickerView *rollSelector = [[UIPickerView alloc] init];
    _dataSource = [[RRRollTypePickerDataSource alloc] init];
    rollSelector.dataSource = _dataSource;
    _rollTypeSelector = rollSelector;

    [rootView addSubview:_rollImageView];
    [rootView addSubview:_rollTypeSelector];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *navigation = self.navigationBar;
    UIView *image = self.rollImageView;
    UIView *type = self.rollTypeSelector;

    NSDictionary *views = NSDictionaryOfVariableBindings(navigation, image, type);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[navigation]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image(==100)]-[type(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[image(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[navigation]-[type(==100)]" views:views]];
}

- (void)saveAndExit {
    [self.delegate detailViewControllerDidFinish:self];
}

@end
