//
//  AttributesController.m
//  YDProject_Example
//
//  Created by gongsheng on 2019/1/18.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//


/** Attributes的相关文本属性
 *  NSKernAttributeName 文字间距 NSNumber类型
 */

#import "AttributesController.h"

@interface AttributesController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation AttributesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    [self testText];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}


- (void)testText
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@""];
    
    {
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字间距"];
        [text appendAttributedString:subText];
        [text addAttribute:NSKernAttributeName value:@10 range:subText.rangeOfAll];
    }
    
    {
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(STXingkai)"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:18] range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(字体颜色)"];
        [subText addAttribute:NSForegroundColorAttributeName value:[UIColor randomColor] range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(字体背景色)"];
        [subText addAttribute:NSBackgroundColorAttributeName value:[UIColor randomColor] range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        //->设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(连体属性)"];
        [subText addAttribute:NSLigatureAttributeName value:@1 range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        //NSUnderlineStyleSingle , NSUnderlineStyleThick, NSUnderlineStyleDouble
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(设置删除线及删除线的颜色)"];
        [subText addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, subText.length)];
        [subText addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        /**
         * 下面的属性，需要和NSUnderlineStyle配合着使用，如NSUnderlineStyleSingle | NSUnderlinePatternDot
         *  NSUnderlinePatternSolid, NSUnderlinePatternDot, NSUnderlinePatternDash,
         *  NSUnderlinePatternDashDot, NSUnderlinePatternDashDotDot, NSUnderlineByWord
         */
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"字体设置(设置下划线及下划线的颜色)"];
        [subText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle | NSUnderlinePatternDot) range:NSMakeRange(0, subText.length)];
        [subText addAttribute:NSUnderlineColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, subText.length)];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        //当 NSStrokeWidthAttributeName 为负数字体为描边
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"描边"];
        [subText addAttribute:NSStrokeWidthAttributeName value:@(-3) range:NSMakeRange(0, subText.length)];
        [subText addAttribute:NSStrokeColorAttributeName value:[UIColor randomColor] range:subText.rangeOfAll];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:30] range:subText.rangeOfAll];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        //当 NSStrokeWidthAttributeName 为整数字体为空心
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"空心"];
        [subText addAttribute:NSStrokeWidthAttributeName value:@(3) range:NSMakeRange(0, subText.length)];
        [subText addAttribute:NSStrokeColorAttributeName value:[UIColor randomColor] range:subText.rangeOfAll];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:30] range:subText.rangeOfAll];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        NSShadow *shadow = [[NSShadow alloc]init];
        shadow.shadowBlurRadius = 5;//设置模糊度
        shadow.shadowColor = [UIColor blueColor];//设置阴影颜色
        shadow.shadowOffset = CGSizeMake(1, 3);//设置阴影的偏移量
    
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"阴影"];
        [subText addAttribute:NSShadowAttributeName value:shadow range:subText.rangeOfAll];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:30] range:subText.rangeOfAll];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        //文字效果 值有NSTextEffectLetterpressStyle，印刷类型
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字效果"];
        [subText addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:subText.rangeOfAll];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:30] range:subText.rangeOfAll];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    {
        //>设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
        UIFont * font1 = [UIFont systemFontOfSize:40];
        UIFont * font2 = [UIFont systemFontOfSize:20];
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"基准线偏移值" attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor orangeColor]}];
        NSAttributedString * att1 = [[NSAttributedString alloc] initWithString:@"20." attributes:@{NSFontAttributeName :font1,NSForegroundColorAttributeName:[UIColor orangeColor]}];
        NSAttributedString * att2 = [[NSAttributedString alloc] initWithString:@"00" attributes:@{NSFontAttributeName:font2,NSForegroundColorAttributeName:[UIColor orangeColor]}];
        NSAttributedString * att3 = [[NSAttributedString alloc] initWithString:@"%" attributes:@{NSFontAttributeName:font2,NSForegroundColorAttributeName:[UIColor orangeColor],NSBaselineOffsetAttributeName:@15}];
    

        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
        [text appendAttributedString:att1];
        [text appendAttributedString:att2];
        [text appendAttributedString:att3];
    }
    
    {
        //->设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字倾斜效果,"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];

        UIFont *font = [UIFont systemFontOfSize:16];
        NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"正值右倾," attributes:@{NSFontAttributeName :font,NSObliquenessAttributeName:@1}];
        NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"负值左倾。" attributes:@{NSFontAttributeName :font,NSObliquenessAttributeName:@(-1)}];
    
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
        [text appendAttributedString:att1];
        [text appendAttributedString:att2];
    }
    
    {
        //->设置文本横向拉伸属性 （也称作扁平化），取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字拉伸属性,"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];
    
        UIFont *font = [UIFont systemFontOfSize:16];
        NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"负值横向压缩文本," attributes:@{NSFontAttributeName :font,NSExpansionAttributeName:@-1}];
        NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"正值拉伸。" attributes:@{NSFontAttributeName :font,NSExpansionAttributeName:@(1)}];
    
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
        [text appendAttributedString:att1];
        [text appendAttributedString:att2];
    }
    {
        //->设置文字书写方向，从左向右书写或者从右向左书写
        /**
         *  //NSWritingDirectionAttributeName 设置文字书写方向，取值为以下组合
         // iOS9.0以前
         //@[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionEmbedding)]
         //@[@(NSWritingDirectionLeftToRight | NSTextWritingDirectionOverride)]
         //@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionEmbedding)]
         //@[@(NSWritingDirectionRightToLeft | NSTextWritingDirectionOverride)]
         // iOS9.0以后
         //@[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]
         //@[@(NSWritingDirectionLeftToRight | NSWritingDirectionOverride)]
         //@[@(NSWritingDirectionRightToLeft | NSWritingDirectionEmbedding)]
         //@[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)]
         // NSWritingDirectionOverride 和 NSWritingDirectionEmbedding 是指定Unicode双向定义的格式控制算法（具体的没太搞清楚）
         */
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字书写方向,"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];
    
        UIFont *font = [UIFont systemFontOfSize:16];
        NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"从左向右," attributes:@{NSFontAttributeName :font,NSWritingDirectionAttributeName:@[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]}];
        NSAttributedString *att2 = [[NSAttributedString alloc] initWithString:@"从右向左。" attributes:@{NSFontAttributeName :font,NSWritingDirectionAttributeName:@[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)]}];
    
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
        [text appendAttributedString:att1];
        [text appendAttributedString:att2];
    }
    
    {
        //->设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字排版方向,"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];
        [subText addAttribute:NSVerticalGlyphFormAttributeName value:@(NSTextLayoutOrientationVertical) range:subText.rangeOfAll];
    
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        //->设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字排版方向,"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];
        [subText addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"www.baidu.com"] range:subText.rangeOfAll];
    
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    {
        //->设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"文字的图文混排"];
        [subText addAttribute:NSFontAttributeName value:[UIFont fontWithName:kXingKaiFontName size:16] range:subText.rangeOfAll];
        //设置文本附件，取值为NSTextAttachment对象，常用于文字的图文混排
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
        textAttachment.image = [UIImage imageNamed:@"yao.jpg"];
        textAttachment.bounds = CGRectMake(0, 0, 30, 30);
        NSAttributedString *att1 = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSAttachmentAttributeName :textAttachment}];
    
        [text appendAttributedString:[self padding]];
        [subText appendAttributedString:att1];
        [text appendAttributedString:subText];
    }
    
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
        paragraphStyle.lineSpacing = 10;// 字体的行间距
    
        paragraphStyle.firstLineHeadIndent = 20.0f;//首行缩进
    
        paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    
        paragraphStyle.headIndent = 20;//整体缩进(首行除外)
    
        paragraphStyle.tailIndent = 20;//尾部缩进
    
        paragraphStyle.minimumLineHeight = 10;//最低行高
    
        paragraphStyle.maximumLineHeight = 20;//最大行高
    
        paragraphStyle.paragraphSpacing = 15;//段与段之间的间距
    
        paragraphStyle.paragraphSpacingBefore = 22.0f;//段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
    
        paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;//从左到右的书写方向（一共➡️⬇️⬅️三种）
    
        paragraphStyle.lineHeightMultiple = 15;/* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
    
        paragraphStyle.hyphenationFactor = 1;//连字属性 在iOS，唯一支持的值分别为0和1

    
        //NSParagraphStyleAttributeName对应的值为NSMutableParagraphStyle类
        NSMutableAttributedString *subText = [[NSMutableAttributedString alloc] initWithString:@"段落段落段落段落段落"];

        [subText addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:subText.rangeOfAll];
        [subText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:subText.rangeOfAll];
        [text appendAttributedString:[self padding]];
        [text appendAttributedString:subText];
    }
    
    
    
    
    self.textView.attributedText = text;
}

- (NSAttributedString *)padding
{
    return [[NSAttributedString alloc] initWithString:@"\n\n"];
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"click: %@", URL.absoluteString);
    
    return YES;
}

- (UITextView *)textView
{
    if (!_textView) {
        
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = rgb(238, 238, 238);
        _textView.contentInset = UIEdgeInsetsMake(10, 15, 10, 15);
        _textView.delegate = self;
    }
    return _textView;
}




@end
