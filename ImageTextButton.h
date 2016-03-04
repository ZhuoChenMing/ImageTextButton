//
//  ImageTextButton.h
//  酌晨茗
//
//  Created by 酌晨茗 on 16/3/4.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ButtonImageAlignmentUp = 0,
    ButtonImageAlignmentLeft,
    ButtonImageAlignmentDown,
    ButtonImageAlignmentRight
} ButtonImageAlignment;

@protocol ButtonImageTextDelegate <NSObject>

- (void)buttonTouchWithView:(UIView *)view imageView:(UIView *)imageView lable:(UILabel *)lable;

@end

@interface ImageTextButton : UIView

/*
解决按钮的setImageEdgeInsets: 和 setTitleEdgeInsets: 带来的种种问题
*/

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title;

//必须设置，这样处理，性能好一点
- (void)setImageAlignment:(ButtonImageAlignment)imageAlignment imageEdge:(UIEdgeInsets)edge;

@property (nonatomic, assign) id<ButtonImageTextDelegate>delegate;

@end
