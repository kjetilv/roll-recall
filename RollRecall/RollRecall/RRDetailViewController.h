#import <Foundation/Foundation.h>

@class RRDetailViewController;
@class RRRollManufacturer;

@protocol RRDetailViewControllerDelegate
- (void)detailViewControllerDidFinish:(RRDetailViewController *)controller;
@end

@interface RRDetailViewController : UIViewController
    @property(nonatomic, strong) id<RRDetailViewControllerDelegate> delegate;

@end
