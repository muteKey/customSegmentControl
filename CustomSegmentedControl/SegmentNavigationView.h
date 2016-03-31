//
//  SegmentNavigationView.h
//  CustomSegmentedControl
//
//  Created by Kirill Ushkov on 31/03/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SegmentNavigationView;

@protocol SegmentNavigationViewProtocol <NSObject>

- (void)didChangeSegmentInNavigationView:(SegmentNavigationView*)view segmentControl:(UISegmentedControl*)segmentControl;

@end

@interface SegmentNavigationView : UIView

@property (nonatomic) UIEdgeInsets selectionIndicatorInsets;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic,weak) IBOutlet id<SegmentNavigationViewProtocol> delegate;

@end
