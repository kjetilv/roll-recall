#import "RRMainViewController.h"
#import "NSLayoutConstraint+Util.h"

@interface RRMainViewController()
// private properties
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationBar *navigationBar;
@end

@implementation RRMainViewController

- (void)loadView {
    UIView *rootView = [[UIView alloc] init];
    rootView.backgroundColor = [UIColor blackColor];

    self.tableView = [[UITableView alloc] init];
    [rootView addSubview:self.tableView];

    self.navigationBar = [[UINavigationBar alloc] init];
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Rolls"];
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain
                                                                     target:self action:@selector(addRoll)];
    navigationItem.rightBarButtonItem = addButtonItem;
    [self.navigationBar pushNavigationItem:navigationItem animated:NO];
    [rootView addSubview:self.navigationBar];

    [self setupLayout:rootView];

    self.view = rootView;
}

- (void)setupLayout:(UIView *)rootView {
    UIView *table = self.tableView;
    UIView *navigation = self.navigationBar;

    NSDictionary *views = NSDictionaryOfVariableBindings(table, navigation);

    for (UIView *view in views.allValues) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }

    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[table]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[navigation]-|" views:views]];
    [rootView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[navigation]-[table]-|" views:views]];
}

- (void)addRoll {

}

@end