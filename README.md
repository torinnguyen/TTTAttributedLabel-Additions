# TTTAttributedLabel-Additions
Make it easier to use [TTTAttributedLabel](https://github.com/TTTAttributedLabel/TTTAttributedLabel) library. No more NSRange, CTFontRef, NSMutableAttributedString and all those weird configuration block syntax.

## Usage
Assuming you have a *myTTTLabel* initialized elsewhere in your code or in Interface Builder.

TTTAttributedLabel *myTTTLabel = ....

``` objective-c
//Pre-configure link color & underline styles
[myTTTLabel setLinkColor:[UIColor orangeColor]];        //set color for normal link
[myTTTLabel setLinkHoverColor:[UIColor orangeColor]];   //set color for press-stated link
[myTTTLabel setLinkUnderline:NO];                       //disable underline for normal link
[myTTTLabel setLinkHoverUnderline:NO];                  //disable underline for pressed-stated link

//Clear current text (optional)
self.myTTTLabel.text = nil;

//Append a blue sentence
[self.myTTTLabel appendText:@"This sentence is blue. "
                       font:[UIFont systemFontOfSize:12]
                      color:[UIColor blueColor]
                  alignment:NSTextAlignmentLeft];

//Append a red text, with different font
[self.myTTTLabel appendText:@"This part is red and big.\n"
                       font:[UIFont systemFontOfSize:20]
                      color:[UIColor redColor]
                  alignment:NSTextAlignmentLeft];

//Append a link with pre-configured color & underline style above
[self.myTTTLabel appendLinkToUrl:@"http://torinnguyen.com"
                        withText:@"This is a link."
                       alignment:NSTextAlignmentLeft];

//Linking "red and big" to a website
[self.myTTTLabel addLinkToUrl:@"http://en.red-dot.org/2026.html"
                     withText:@"red and big"];

//Change the font of existing substring within current text
[self.myTTTLabel modifyText:@"blue"
                   withFont:[UIFont systemFontOfSize:20]
                      color:[UIColor purpleColor];
```

## License
Do whatever you want with it.
