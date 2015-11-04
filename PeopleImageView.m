#import "PeopleImageView.h"

@implementation PeopleImageView

- (id)initWithFrame:(NSRect)frameRect
{
	if ((self = [super initWithFrame:frameRect]) != nil) {
		// Add initialization code here
	}
	return self;
}

- (void)drawRect: (NSRect)rect {
    
    NSImage *image = [self image];
    if (image) {
		[image drawInRect:[self bounds]
		fromRect: NSMakeRect(0, 0, [image size].width, [image size].height)
		operation: NSCompositeSourceOver
		fraction: (CGFloat)1.0];            
	}
}

- (void)dealloc {
    [self setImage: nil];
    [super dealloc];
}

// accessors
- (NSImage *)image{
    return [[_image retain] autorelease];
}

- (void)setImage: (NSImage *)value {
    if ( _image != value ) {
        [_image release];
        _image = [value retain];
    }
}

- (int)viewType{
	return _viewType;
}

- (void)setViewType: (int)value{
	_viewType = value;
}


@end


@implementation PeopleImageView (DraggingSupport)

- (NSDragOperation) draggingEntered: (id <NSDraggingInfo>) sender {
	BOOL isValid = [NSImage canInitWithPasteboard:
		[sender draggingPasteboard]];

	return isValid ? NSDragOperationCopy : NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>) sender {

	return [NSImage canInitWithPasteboard:
		[sender draggingPasteboard]];
}

- (BOOL)performDragOperation: (id <NSDraggingInfo>) sender {
	NSPasteboard *pb = [sender draggingPasteboard];
	NSImage *image = [[NSImage alloc] initWithPasteboard: pb];

	[self setImage: image];
	[image release];

 	[[NSNotificationCenter defaultCenter]
		postNotificationName:@"PhotoAdded" object:self];
	
	[self setNeedsDisplay: YES];
		
	if (image == nil) {
		return NO;
	}
	return YES;
}

@end
