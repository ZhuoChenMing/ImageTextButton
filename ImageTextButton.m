//
//  ImageTextButton.m
//  酌晨茗
//
//  Created by 酌晨茗 on 16/3/4.
//  Copyright © 2016年 酌晨茗. All rights reserved.
//

#import "ImageTextButton.h"

@interface ImageTextButton ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *lable;

@property (nonatomic, assign) UIEdgeInsets edge;

@end

@implementation ImageTextButton

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title {
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:imageName];
        [self addSubview:_imageView];
        
        _lable = [[UILabel alloc] init];
        _lable.text = title;
        _lable.textColor = [UIColor lightGrayColor];
        _lable.font = [UIFont systemFontOfSize:14];
        _lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lable];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)setImageAlignment:(ButtonImageAlignment)imageAlignment imageEdge:(UIEdgeInsets)edge {

    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat lableWidth = [self widthWithString:_lable.text height:CGRectGetHeight(_lable.frame) font:_lable.font];
 
    if (imageAlignment == ButtonImageAlignmentLeft) {
        CGFloat imageWidth = height - edge.top - edge.bottom;
        if (lableWidth + edge.left + edge.right + imageWidth >= width - 2 * edge.left) {
            _imageView.frame = CGRectMake(edge.left, edge.top, imageWidth, imageWidth);
            _lable.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + edge.right, 0, width - imageWidth - edge.left * 2 - edge.right, height);
        } else {
            CGFloat left = (width - lableWidth - edge.right) / 2.0;
            _imageView.frame = CGRectMake(left, edge.top, imageWidth, imageWidth);
            _lable.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + edge.right, 0, width - imageWidth - edge.left * 2 - edge.right, height);
        }
    } else if (imageAlignment == ButtonImageAlignmentRight) {
        _lable.textAlignment = NSTextAlignmentCenter;
        CGFloat imageWidth = height - edge.top - edge.bottom;
        if (lableWidth + edge.left + edge.right + imageWidth >= width - 2 * edge.right) {
            _lable.frame = CGRectMake(edge.right, 0, width - imageWidth - edge.right * 2 - edge.left, height);
            _imageView.frame = CGRectMake(CGRectGetMaxX(_lable.frame) + edge.left, edge.top, imageWidth, imageWidth);
        } else {
            CGFloat left = (width - lableWidth - edge.left) / 2.0;
            _lable.frame = CGRectMake(left, 0, width - imageWidth - edge.right * 2 - edge.left, height);
            _imageView.frame = CGRectMake(CGRectGetMaxX(_lable.frame) + edge.left, edge.top, imageWidth, imageWidth);
        }
    } else if (imageAlignment == ButtonImageAlignmentUp) {
        CGFloat imageWidth = width - edge.left - edge.right;
        if (imageWidth + edge.top + edge.bottom + 30 <= height) {
            _imageView.frame = CGRectMake(edge.left, edge.top, imageWidth, imageWidth);
            _lable.frame = CGRectMake(edge.left, imageWidth + edge.bottom, width - edge.left - edge.right, height - imageWidth - edge.top - edge.bottom);
        } else {
            NSLog(@"坐标错误");
        }
    } else {
        CGFloat imageWidth = width - edge.left - edge.right;
        if (imageWidth + edge.top + edge.bottom + 30 <= height) {
            _lable.frame = CGRectMake(edge.left, 0, width - edge.left - edge.right, 30);
            _imageView.frame = CGRectMake(edge.left, edge.top + CGRectGetMaxX(_lable.frame), imageWidth, imageWidth);
        } else {
            NSLog(@"坐标错误");
        }
    }
}

#pragma － 文字宽度
- (CGFloat)widthWithString:(NSString *)string
                    height:(CGFloat)height
                      font:(UIFont *)font {
    CGFloat width = [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size.width;
    return width;
}

- (void)viewTap {
    [_delegate buttonTouchWithView:self imageView:_imageView lable:_lable];
}

@end
