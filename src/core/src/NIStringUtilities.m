//
//  NIStringUtilities.m
//  Maplets
//
//  Created by zehao chang on 11/26/16.
//  Copyright © 2016 Zaia Design. All rights reserved.
//

#import "NIStringUtilities.h"

@implementation NIStringUtilities

+(CGRect) textBoundingRect:(NSString*)text constrainedToSize:(CGSize)size font:(UIFont*)font
{
	CGRect textRect = [text boundingRectWithSize:size
										 options:NSStringDrawingUsesLineFragmentOrigin
									  attributes:@{NSFontAttributeName: font}
										 context:nil];
	return textRect;
}

+(CGRect) textBoundingRect:(NSString*)text constrainedToSize:(CGSize)size font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
	CGRect textRect = [text boundingRectWithSize:size
										 options:NSStringDrawingUsesLineFragmentOrigin
									  attributes:@{NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle.copy}
										 context:nil];
	return textRect;
}

@end


@implementation NSString (NIStringUtilities)

-(CGRect) boundingRectWithFont:(UIFont*)font
{
	return [NIStringUtilities textBoundingRect:self constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) font:font];
}

-(CGRect) boundingRectWithFont:(UIFont*)font constrainedToSize:(CGSize)size
{
	return [NIStringUtilities textBoundingRect:self constrainedToSize:size font:font];
}

-(CGRect) boundingRectWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
	return [NIStringUtilities textBoundingRect:self constrainedToSize:size font:font lineBreakMode:lineBreakMode];
}

@end
