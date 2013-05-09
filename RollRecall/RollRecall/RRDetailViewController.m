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

    self.rollImageView = [[UIImageView alloc] init];
    self.rollImageView.image = [[UIImage alloc] initWithContentsOfFile:@"1368149063_Roll.png"];

    [rootView addSubview:self.rollImageView];
    [rootView addSubview:self.rollTypeView];

    [self setupLayout:rootView];
}

- (void)setupLayout:(UIView *)rootView {

//    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" views:views]];
//    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" views:views]];

}
@end
