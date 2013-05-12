#import <Foundation/Foundation.h>

@class RRDetailViewController;

@protocol RRDetailViewControllerDelegate
- (void)detailViewControllerDidFinish:(RRDetailViewController *)controller;
@end

@interface RRDetailViewController : UIViewController
@property(nonatomic, weak) id<RRDetailViewControllerDelegate> delegate;
@end
