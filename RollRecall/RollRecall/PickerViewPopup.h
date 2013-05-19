//
// Created by Kjetil Valstadsve on 2013-05-17.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@protocol PickerViewPopupDelegate
- (void) buttonClicked;
@end

@interface PickerViewPopup : UIView
@property (readonly,strong,nonatomic) UIPickerView *picker;
@property (strong, nonatomic) id<PickerViewPopupDelegate> buttonClickedDelegate;
@end
