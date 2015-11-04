/* PeopleImageView */
#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

@interface PeopleImageView : NSView
{
    NSImage *_image;
	int _viewType;
}

- (NSImage *)image;
- (void)setImage: (NSImage *)value;
- (int)viewType;
- (void)setViewType: (int)value;

@end
