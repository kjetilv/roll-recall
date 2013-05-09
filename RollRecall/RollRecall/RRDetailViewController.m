//
// Created by Kjetil Valstadsve on 2013-05-09.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "NSLayoutConstraint+Util.h"
#import "RRDetailViewController.h"

@interface RRDetailViewController()
// private properties
@property (strong, nonatomic) UIImageView *rollImageView;
@property (strong, nonatomic) UITextView *rollTypeView;
@end

@implementation RRDetailViewController

- (void)loadView {
    UIView *rootView = [[UIView alloc] init];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed: @"1368149063_Roll.png"];
    self.rollImageView = imageView;
    self.rollTypeView = [[UITextView alloc] init];
    self.rollTypeView.text = @"Tri-X 400";

    [rootView addSubview:self.rollImageView];
    [rootView addSubview:self.rollTypeView];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *image = self.rollImageView;
    UIView *type = self.rollTypeView;

    NSDictionary *views = NSDictionaryOfVariableBindings(image, type);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[image(==100)]-[type]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[image(==100)]" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[type]" views:views]];

}
@end
