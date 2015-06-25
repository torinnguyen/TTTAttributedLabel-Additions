//
//  TTTAttributedLabel+Additions.h
//  Systematica
//
//  Created by Torin Nguyen on 25/6/15.
//  Copyright (c) 2015 Systematica. All rights reserved.
//

#import "TTTAttributedLabel.h"

@interface TTTAttributedLabel (Additions)

- (void)setLinkColor:(UIColor *)color;
- (void)setLinkUnderline:(BOOL)hasUnderline;
- (void)setLinkHoverColor:(UIColor *)color;
- (void)setLinkHoverUnderline:(BOOL)hasUnderline;

/**
 Insert new string at the end with given font and (optional) color
 */
- (void)appendText:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

/**
 Insert new string at the end and link it to a given URL
 Remember to set link attributes first
 */
- (void)appendLinkToUrl:(NSString *)urlString withText:(NSString *)string alignment:(NSTextAlignment)alignment;;

/**
 Link a URL to an existing substring
 Remember to set link attributes first
 */
- (void)addLinkToUrl:(NSString *)urlString withText:(NSString *)string;

/**
 Assign new font and (optional) color to an existing substring
 */
- (void)modifyText:(NSString *)string withFont:(UIFont *)font color:(UIColor *)color;

@end
