//
//  NIStringUtilities.h
//  Maplets
//
//  Created by zehao chang on 11/26/16.
//  Copyright © 2016 Zaia Design. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIStringUtilities : NSObject

+(CGRect) textBoundingRect:(NSString*)text constrainedToSize:(CGSize)size font:(UIFont*)font;
+(CGRect) textBoundingRect:(NSString*)text constrainedToSize:(CGSize)size font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@interface NSString (NIStringUtilities)

-(CGRect) boundingRectWithFont:(UIFont*)font;
-(CGRect) boundingRectWithFont:(UIFont*)font constrainedToSize:(CGSize)size;
-(CGRect) boundingRectWithFont:(UIFont*)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end
