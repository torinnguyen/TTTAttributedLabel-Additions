#import "TTTAttributedLabel.h"

@interface TTTAttributedLabel (Additions)

/**
 Set color for normal-state link
 */
- (void)setLinkColor:(UIColor *)color;

/**
 Set underline style for normal-state link
 */
- (void)setLinkUnderline:(BOOL)hasUnderline;

/**
 Set color for pressed-state link
 */
- (void)setLinkHoverColor:(UIColor *)color;

/**
 Set underline style for pressed-state link
 */
- (void)setLinkHoverUnderline:(BOOL)hasUnderline;

/**
 Insert new string at the end with given font and (optional) color
 */
- (void)appendText:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

/**
 Append a new string at the end of current text and link it to a given URL
 Remember to set link attributes first
 */
- (void)appendLinkToUrl:(NSString *)urlString withText:(NSString *)string alignment:(NSTextAlignment)alignment;;

/**
 Link an existing substring within current text to a given URL
 Remember to set link attributes first
 */
- (void)addLinkToUrl:(NSString *)urlString withText:(NSString *)string;

/**
 Assign new font and (optional) color to an existing substring within current text
 */
- (void)modifyText:(NSString *)string withFont:(UIFont *)font color:(UIColor *)color;

@end
