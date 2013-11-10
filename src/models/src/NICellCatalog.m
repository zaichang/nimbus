//
// Copyright 2011-2014 NimbusKit
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "NICellCatalog.h"
#import "NICellFactory+Private.h"

#import "NimbusCore.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "Nimbus requires ARC support."
#endif

@implementation NIDrawRectBlockCellObject



- (id)initWithBlock:(NICellDrawRectBlock)block object:(id)object {
  if ((self = [super initWithCellClass:[NIDrawRectBlockCell class]])) {
    _block = block;
    _object = object;
  }
  return self;
}

+ (id)objectWithBlock:(NICellDrawRectBlock)block object:(id)object {
  return [[self alloc] initWithBlock:block object:object];
}

@end


@implementation NITitleCellObject

- (id)initWithTitle:(NSString *)title image:(UIImage *)image cellClass:(Class)cellClass userInfo:(id)userInfo {
  if ((self = [self initWithTitle:title image:image])) {
    self.cellClass = cellClass;
    self.userInfo = userInfo;
  }
  return self;
}

- (id)initWithCellClass:(Class)cellClass userInfo:(id)userInfo {
  return [self initWithTitle:nil image:nil cellClass:cellClass userInfo:userInfo];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
  if ((self = [super initWithCellClass:[NITextCell class] userInfo:nil])) {
    _title = [title copy];
    _image = image;
  }
  return self;
}

- (id)initWithTitle:(NSString *)title {
  return [self initWithTitle:title image:nil];
}

- (id)init {
  return [self initWithTitle:nil image:nil];
}

+ (id)objectWithTitle:(NSString *)title image:(UIImage *)image {
  return [[self alloc] initWithTitle:title image:image];
}

+ (id)objectWithTitle:(NSString *)title {
  return [[self alloc] initWithTitle:title image:nil];
}

@end


@implementation NISubtitleCellObject

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image cellClass:(Class)cellClass userInfo:(id)userInfo {
  if ((self = [self initWithTitle:title subtitle:subtitle image:image])) {
    self.cellClass = cellClass;
    self.userInfo = userInfo;
  }
  return self;
}

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image {
  if ((self = [super initWithTitle:title image:image])) {
    _subtitle = [subtitle copy];
    _cellStyle = UITableViewCellStyleSubtitle;
  }
  return self;
}

- (id)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
  return [self initWithTitle:title subtitle:subtitle image:nil];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
  return [self initWithTitle:title subtitle:nil image:image];
}

- (id)init {
  return [self initWithTitle:nil subtitle:nil image:nil];
}

+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle image:(UIImage *)image {
  return [[self alloc] initWithTitle:title subtitle:subtitle image:image];
}

+ (id)objectWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
  return [[self alloc] initWithTitle:title subtitle:subtitle image:nil];
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NICaptionCellObject

-(Class) cellClass
{
	return [NICaptionCell class];
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NILongTextCellObject

@synthesize text = _text;
@synthesize titleFont = _titleFont;
@synthesize textFont = _textFont;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image {
	if ((self = [super initWithTitle:title image:image])) {
		_text = [text copy];

		_titleFont = [UIFont boldSystemFontOfSize:13.0];
		_textFont = [UIFont systemFontOfSize:14.0];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString *)title text:(NSString *)text {
	return [self initWithTitle:title text:text image:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
	return [self initWithTitle:title text:nil image:image];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)objectWithTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image {
	return [[self alloc] initWithTitle:title text:text image:image];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)objectWithTitle:(NSString *)title text:(NSString *)text {
	return [[self alloc] initWithTitle:title text:text image:nil];
}


-(Class) cellClass
{
	return [NILongTextCell class];
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NITextCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];

  self.imageView.image = nil;
  self.textLabel.text = nil;
  self.detailTextLabel.text = nil;
}

- (BOOL)shouldUpdateCellWithObject:(id)object {
  if ([object isKindOfClass:[NITitleCellObject class]]) {
    NITitleCellObject* titleObject = object;
    self.textLabel.text = titleObject.title;
    self.imageView.image = titleObject.image;
  }
  if ([object isKindOfClass:[NISubtitleCellObject class]]) {
    NISubtitleCellObject* subtitleObject = object;
    self.detailTextLabel.text = subtitleObject.subtitle;
  }
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)heightForObject:(NILongTextCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
	return tableView.rowHeight;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NICaptionCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.selectionStyle = UITableViewCellSelectionStyleDefault;

		self.textLabel.textAlignment = UITextAlignmentRight;
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.textLabel.numberOfLines = 1;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		self.textLabel.font = [UIFont boldSystemFontOfSize:13.0];
		self.textLabel.textColor = [UIColor grayColor];
		
		self.detailTextLabel.adjustsFontSizeToFitWidth = YES;
		self.detailTextLabel.minimumFontSize = 8;
		self.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		self.detailTextLabel.numberOfLines = 0;
		self.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	
	self.imageView.image = nil;
	self.textLabel.text = nil;
	self.detailTextLabel.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldUpdateCellWithObject:(id)object {
	if ([object isKindOfClass:[NICaptionCellObject class]]) {
		NICaptionCellObject* captionObject = object;
		self.textLabel.text = captionObject.title;
		self.detailTextLabel.text = captionObject.subtitle;
		self.imageView.image = captionObject.image;
	}
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) layoutSubviews
{
	[super layoutSubviews];
	
	static CGFloat titleWidth = 90.0;
	static CGFloat titlePadding = 12.0;
	CGRect contentViewBounds = self.contentView.bounds;
	
	CGRect titleLabelFrame = contentViewBounds;
	titleLabelFrame.size.width = titleWidth;
	self.textLabel.frame = titleLabelFrame;
	
	CGRect subtitleLabelFrame = contentViewBounds;
	subtitleLabelFrame.origin.x = titleWidth + titlePadding;
	subtitleLabelFrame.size.width = contentViewBounds.size.width - subtitleLabelFrame.origin.x;
	self.detailTextLabel.frame = subtitleLabelFrame;
}

@end



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NILongTextCell

@synthesize textView = _textView;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.textLabel.textAlignment = UITextAlignmentRight;
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
		self.textLabel.numberOfLines = 1;
		self.textLabel.adjustsFontSizeToFitWidth = YES;
		self.textLabel.textColor = [UIColor grayColor];
		
		self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
		self.textView.backgroundColor = [UIColor clearColor];
		self.textView.contentInset = UIEdgeInsetsZero;
		self.textView.editable = NO;
		self.textView.scrollEnabled = NO;
		[self.contentView addSubview:self.textView];
	}
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
	[super prepareForReuse];
	
	self.imageView.image = nil;
	self.textLabel.text = nil;
	self.textView.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldUpdateCellWithObject:(id)object {
	if ([object isKindOfClass:[NILongTextCellObject class]]) {
		NILongTextCellObject* longTextObject = object;
		self.textLabel.text = longTextObject.title;
		self.textLabel.font = longTextObject.titleFont;
		self.textView.text = longTextObject.text;
		self.textView.font = longTextObject.textFont;
		self.imageView.image = longTextObject.image;
	}
	return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
-(void) layoutSubviews
{
	[super layoutSubviews];
	
	static CGFloat xPadding = 12.0;
	CGRect contentViewBounds = self.contentView.bounds;
	CGFloat contentWidth = contentViewBounds.size.width - 2 * xPadding;
	
	CGFloat y = 12.0;
	if (self.textLabel.text.length > 0) {
		CGRect titleLabelFrame = CGRectMake(xPadding + 4.0, y, 0, 0);
		titleLabelFrame.size = [self.textLabel sizeThatFits:CGSizeMake(contentWidth, CGFLOAT_MAX)];
		self.textLabel.frame = titleLabelFrame;
		
		y += CGRectGetHeight(titleLabelFrame);
	}
	
	CGFloat subtitleLabelFrameHeight = contentViewBounds.size.height - y;
	CGRect subtitleLabelFrame = CGRectMake(xPadding, y, contentWidth, subtitleLabelFrameHeight);
	self.textView.frame = subtitleLabelFrame;
}


+ (CGFloat)heightForObject:(NILongTextCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
	CGFloat height = 12.0;
	static CGFloat xPadding = 12.0;
	CGFloat contentWidth = tableView.frame.size.width - 2 * xPadding;
	
	if (object.title.length > 0)
	{
		UIFont *font = object.titleFont;
		height += [object.title sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
		height += 6.0;
	}
	
	if (object.text.length > 0)
	{
		UIFont *font = object.textFont;
		height += [object.text sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
		height += 12.0;
	}

	height += 12.0;

	return height;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@interface NIDrawRectBlockView : UIView
@property (nonatomic, copy) NICellDrawRectBlock block;
@property (nonatomic, strong) id object;
@property (nonatomic, assign) UITableViewCell* cell;
@end


@implementation NIDrawRectBlockView



- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    self.backgroundColor = [UIColor clearColor];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  if (nil != self.block) {
    self.block(rect, self.object, self.cell);
  }
}

@end


@implementation NIDrawRectBlockCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    _blockView = [[NIDrawRectBlockView alloc] initWithFrame:self.contentView.bounds];
    _blockView.autoresizingMask = UIViewAutoresizingFlexibleDimensions;
    _blockView.contentMode = UIViewContentModeRedraw;
    [self.contentView addSubview:_blockView];

    [self.textLabel removeFromSuperview];
    [self.imageView removeFromSuperview];
    [self.detailTextLabel removeFromSuperview];
  }
  return self;
}

- (BOOL)shouldUpdateCellWithObject:(NIDrawRectBlockCellObject *)object {
  NIDrawRectBlockView* blockView = (NIDrawRectBlockView *)self.blockView;
  blockView.block = object.block;
  blockView.object = object.object;
  blockView.cell = self;
  [blockView setNeedsDisplay];
  return YES;
}

+ (CGFloat)heightForObject:(NIDrawRectBlockCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
  return object.block(tableView.bounds, object.object, nil);
}

@end
