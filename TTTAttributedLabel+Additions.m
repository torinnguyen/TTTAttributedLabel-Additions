//
//  TTTAttributedLabel+Additions.m
//  Systematica
//
//  Created by Torin Nguyen on 25/6/15.
//  Copyright (c) 2015 Systematica. All rights reserved.
//

#import "TTTAttributedLabel+Additions.h"

@implementation TTTAttributedLabel (Additions)


- (void)setLinkColor:(UIColor *)color
{
    if (color == nil)
        return;
    
    NSMutableDictionary * dict = [self.linkAttributes mutableCopy];
    if (dict == nil)
        dict = [NSMutableDictionary dictionary];
    
    [dict setObject:color forKey:(id)kCTForegroundColorAttributeName];
    self.linkAttributes = dict;
}
- (void)setLinkUnderline:(BOOL)hasUnderline
{
    NSMutableDictionary * dict = [self.linkAttributes mutableCopy];
    if (dict == nil)
        dict = [NSMutableDictionary dictionary];
    
    [dict setObject:hasUnderline ? @(kCTUnderlineStyleSingle) : @(kCTUnderlineStyleNone)
             forKey:(id)kCTUnderlineStyleAttributeName];
    self.linkAttributes = dict;
}
- (void)setLinkHoverColor:(UIColor *)color
{
    if (color == nil)
        return;
    
    NSMutableDictionary * dict = [self.activeLinkAttributes mutableCopy];
    if (dict == nil)
        dict = [NSMutableDictionary dictionary];
    
    [dict setObject:color forKey:(id)kCTForegroundColorAttributeName];
    self.activeLinkAttributes = dict;
}
- (void)setLinkHoverUnderline:(BOOL)hasUnderline
{
    NSMutableDictionary * dict = [self.activeLinkAttributes mutableCopy];
    if (dict == nil)
        dict = [NSMutableDictionary dictionary];
    
    [dict setObject:hasUnderline ? @(kCTUnderlineStyleSingle) : @(kCTUnderlineStyleNone)
             forKey:(id)kCTUnderlineStyleAttributeName];
    self.activeLinkAttributes = dict;
}

- (NSMutableAttributedString *)refreshedNSMutableAttributedString
{
    if (self.attributedText != nil)
        return [self.attributedText mutableCopy];
    
    NSString * selfText = self.text;
    if ([selfText length] <= 0)
        selfText = @"";
    
    [self setText:selfText afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    return [self.attributedText mutableCopy];
}

- (void)appendText:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment
{
    if ([string length] <= 0)
        return;
    
    NSMutableAttributedString * tempAttrString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    NSRange range = NSMakeRange(0, [string length]);
    
    [tempAttrString beginEditing];
    if (font) {
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
        if (fontRef) {
            [tempAttrString addAttribute:(NSString *)kCTFontAttributeName
                                   value:(__bridge id)fontRef
                                   range:range];
            CFRelease(fontRef);
        }
    }
    if (color == nil)
        color = self.textColor;
    [tempAttrString addAttribute:(NSString *)kCTForegroundColorAttributeName
                           value:(__bridge id)color.CGColor
                           range:range];
    
    //Alignment
    NSMutableParagraphStyle* attributeStyle = [[NSMutableParagraphStyle alloc] init];
    attributeStyle.alignment = alignment;
    [tempAttrString addAttribute:NSParagraphStyleAttributeName
                           value:attributeStyle
                           range:range];
    
    [tempAttrString endEditing];
    
    //Sanity check
    NSMutableAttributedString *mutableAttributedString = [self refreshedNSMutableAttributedString];
    if (mutableAttributedString == nil)
        return;
    
    [mutableAttributedString appendAttributedString:tempAttrString];
    self.attributedText = mutableAttributedString;
    
    [self setNeedsDisplay];
}

- (void)appendLinkToUrl:(NSString *)urlString withText:(NSString *)string alignment:(NSTextAlignment)alignment
{
    if ([string length] <= 0 || [urlString length] <= 0)
        return;
    
    NSMutableAttributedString * tempAttrString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    NSRange range = NSMakeRange(0, [string length]);
    
    [tempAttrString addAttribute:NSLinkAttributeName
                           value:[NSURL URLWithString:urlString]
                           range:range];
    
    //Alignment
    NSMutableParagraphStyle* attributeStyle = [[NSMutableParagraphStyle alloc] init];
    attributeStyle.alignment = alignment;
    [tempAttrString addAttribute:NSParagraphStyleAttributeName
                           value:attributeStyle
                           range:range];
    
    //Sanity check
    NSMutableAttributedString *mutableAttributedString = [self refreshedNSMutableAttributedString];
    if (mutableAttributedString == nil)
        return;
    
    [mutableAttributedString appendAttributedString:tempAttrString];
    self.attributedText = mutableAttributedString;
    
    [self setNeedsDisplay];
}

- (void)addLinkToUrl:(NSString *)urlString withText:(NSString *)string
{
    if ([string length] <= 0 || [urlString length] <= 0)
        return;
    
    NSRange range = [self.text rangeOfString:string];
    if (range.location == NSNotFound)
        return;
    
    //Sanity check
    NSMutableAttributedString *mutableAttributedString = [self refreshedNSMutableAttributedString];
    if (mutableAttributedString == nil)
        return;
    
    [self addLinkToURL:[NSURL URLWithString:urlString] withRange:range];
}

- (void)modifyText:(NSString *)string withFont:(UIFont *)font color:(UIColor *)color
{
    if ([string length] <= 0)
        return;
    
    NSRange range = [self.text rangeOfString:string];
    if (range.location == NSNotFound)
        return;
    
    //Sanity check
    NSMutableAttributedString *mutableAttributedString = [self refreshedNSMutableAttributedString];
    if (mutableAttributedString == nil)
        return;
    
    [mutableAttributedString beginEditing];
    if (font) {
        CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
        if (fontRef) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName
                                            value:(__bridge id)fontRef
                                            range:range];
            CFRelease(fontRef);
        }
    }
    if (color == nil)
        color = self.textColor;
    [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName
                                    value:(__bridge id)color.CGColor
                                    range:range];
    [mutableAttributedString endEditing];
    
    self.attributedText = mutableAttributedString;
    
    [self setNeedsDisplay];
}

@end
