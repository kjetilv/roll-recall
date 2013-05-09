#import "RRMainViewController.h"
#import "NSLayoutConstraint+Util.h"

@interface RRMainViewController()
// private properties
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation RRMainViewController

- (void)loadView {
    UIView *rootView = [[UIView alloc] init];

    self.tableView = [[UITableView alloc] init];
    [rootView addSubview:self.tableView];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *tableView = self.tableView;

    NSDictionary *views = NSDictionaryOfVariableBindings(tableView);

    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" views:views]];
}

@end