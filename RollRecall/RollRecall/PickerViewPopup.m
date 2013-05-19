//
// Created by Kjetil Valstadsve on 2013-05-17.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PickerViewPopup.h"
#import "NSLayoutConstraint+Util.h"

@interface PickerViewPopup ()
@property (strong,nonatomic) UIButton *done;
@property (strong,nonatomic) UIPickerView *picker;
@end

@implementation PickerViewPopup

- (PickerViewPopup *)init {
    self = [super init];
    if (self) {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"Done" forState:UIControlStateNormal];
        _done = button;

        UIPickerView *picker = [[UIPickerView alloc] init];
        _picker = picker;

        [self addSubview: _picker];
        [self addSubview: _done];
    }
    return self;
}

- (void)layoutSubviews {

    UIView *done = self.done;
    UIView *picker = self.picker;

    NSDictionary *views = NSDictionaryOfVariableBindings(done, picker);
    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[picker]-|" views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[done]-|" views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[picker]-[done]-|" views:views]];

    [super layoutSubviews];
}

- (void) click {
    [self.buttonClickedDelegate buttonClicked];
}

- (UIPickerView *)newSelector {
    UIPickerView *sel = [[UIPickerView alloc] init];
    sel.showsSelectionIndicator = YES;
    return sel;
}

@end
