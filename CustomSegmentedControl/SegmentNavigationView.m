//
//  SegmentNavigationView.m
//  CustomSegmentedControl
//
//  Created by Kirill Ushkov on 31/03/16.
//  Copyright © 2016 Kirill Ushkov. All rights reserved.
//

#import "SegmentNavigationView.h"


@interface UIColor (SegmentColor)

+ (UIColor*)defaultColor;
+ (UIColor*)selectedColor;

@end

@implementation UIColor (SegmentColor)

+ (UIColor*)defaultColor {
    return [UIColor colorWithRed:114/255.0f green:118/255.0f blue:120.0f/255.0f alpha:1.0f];
}

+ (UIColor *)selectedColor {
    return [UIColor colorWithRed:52/255.0f green:159/255.0f blue:255/255.0f alpha:1.0f];
}

@end

@interface SegmentNavigationView ()

@property (nonatomic, strong) NSArray *segments;
@property (nonatomic, strong) UIImageView *selectionIndicator;

@end

@implementation SegmentNavigationView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil][0]];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectionIndicator"]];
    
    [self.segmentControl setDividerImage: [UIImage imageNamed:@"arrow"]
                       forLeftSegmentState: UIControlStateNormal
                         rightSegmentState: UIControlStateNormal
                                barMetrics: UIBarMetricsDefault];
    
    [self.segmentControl setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor defaultColor]}
                                       forState: UIControlStateNormal];
    
    [self.segmentControl setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor selectedColor]}
                                       forState: UIControlStateSelected];

    
    self.segments = [self.segmentControl subviews];
    self.selectionIndicatorInsets = UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    frame.size.width = self.superview.frame.size.width;
    self.frame = frame;
    
    [self.segmentControl layoutIfNeeded];
    
    [self.segmentControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (IBAction)changeSegment:(UISegmentedControl *)sender {
    [self setSelection:sender];
    
    if ([self.delegate respondsToSelector: @selector(didChangeSegmentInNavigationView:segmentControl:)]) {
        [self.delegate didChangeSegmentInNavigationView:self segmentControl:sender];
    }
}

- (void)setSelection:(UISegmentedControl*)sender {
    // Remove the arrow from its current view
    [self.selectionIndicator removeFromSuperview];
    
    // The segment items are added in reverse order of their index so we need to flip the selected index
    NSInteger viewIndex = sender.numberOfSegments - 1 - sender.selectedSegmentIndex;
    
    // Get a reference to the segment and position the arrow outside of its frame
    UIView *segmentView = [self.segments objectAtIndex:viewIndex];
    [segmentView addSubview:self.selectionIndicator];
    CGRect frame = self.selectionIndicator.frame;
    
    frame.size.width = CGRectGetWidth(segmentView.frame) - self.selectionIndicatorInsets.left - self.selectionIndicatorInsets.right;
    
    self.selectionIndicator.frame = frame;
    
    self.selectionIndicator.center = CGPointMake(segmentView.frame.size.width / 2,
                                                 CGRectGetHeight(sender.frame) + CGRectGetHeight(self.selectionIndicator.frame) / 2);
}

@end
