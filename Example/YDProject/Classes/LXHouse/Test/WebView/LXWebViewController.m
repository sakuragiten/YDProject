//
//  LXWebViewController.m
//  YDProject_Example
//
//  Created by louxunmac on 2019/5/23.
//  Copyright © 2019 387970107@qq.com. All rights reserved.
//

#import "LXWebViewController.h"
#import "LXWebViewJSBridge.h"

@interface LXWebViewController ()<UIWebViewDelegate, LXWebViewJSBridgeDelegate>

@property(nonatomic, strong) UIWebView *webView;

@property(nonatomic, strong) RACSubject *subject;


@end

@implementation LXWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
//    [self loadHTML];
    [self loadHTMLStr];
    
    _subject = [RACSubject subject];
    
    [_subject subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
}

- (void)loadHTML
{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSLog(@"%@", sourcePath);
    
    NSURL *url = [NSURL fileURLWithPath:sourcePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}



- (void)loadHTMLStr
{
    NSString *htmlStr = [self getHTMLStr];
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

//    [self.webView stringByEvaluatingJavaScriptFromString:@"\
//     function imageClickAction(){\
//     var imgs=document.getElementsByTagName('img');\
//     var length=imgs.length;\
//     for(var i=0;i<length;i++){\
//     img=imgs[i];\
//     img.onclick=function(){\
//     window.location ='image-preview:'+this.src;\
//     }\
//     }\
//     }\
//     "];
    
    
    //注册交互协议
    JSContext *context =[self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    LXWebViewJSBridge *bridge = [[LXWebViewJSBridge alloc] init];
//    __weak typeof(self) weakSelf = self;
    context[@"louxun_wbjs"] = bridge;
    bridge.delegate = self;
    bridge.delegate = self;
//    webView.scrollView.scrollEnabled = NO;
//    // Disable user selection
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
//    // Disable callout
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"\
     function imageClickAction(){\
     var imgs=document.getElementsByTagName('img');\
     var length=imgs.length;\
     var objs=new Array();\
     for(var i=0;i<length;i++){\
     img=imgs[i];\
     objs.push(img.src);\
     img.onclick=function(){\
     window.louxun_wbjs.aopenImage({\"imgs\" : objs, \"img\":this.src});\
     }\
     }\
     }\
     "];
//    webkit.messageHandlers.closePage.postMessage(1)
    //触发方法 给所有的图片添加onClick方法
    [self.webView stringByEvaluatingJavaScriptFromString:@"imageClickAction();"];
    
    //拿到最终的html代码
    //    NSString *HTMLSource = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('script')[0].innerHTML"];
    //调用html代码
//    [self.webView stringByEvaluatingJavaScriptFromString:@"sendMsg('我是objc传入的值');"];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if([request.URL.scheme isEqualToString:@"image-preview"]){
        //触发点击事件  -- >拿到是第几个标签被点击了
        NSLog(@"%@", request.description);
        
//        NSString *clickImg = request.URL.resourceSpecifier;
        //遍历数组，查询查找当前第几个图被点击了
//        NSInteger selectIndex = 0;
        //        for(int i = 0; i< self.imgsArr.count;i++){
        //            NSString *imgUrl = self.imgsArr[i];
        //            if ([imgUrl isEqualToString:clickImg]) {
        //                selectIndex = i;
        //                break;
        //            }
        //        }
        //拿到当前选中的index  -- > 使用图片浏览器让图片显示出来
//        NSLog(@"当前图片%@ 选中index:%zi",clickImg,selectIndex);
        return NO;
    }
    return YES;
}

- (void)openImage:(id)data img:(NSString *)img
{
    NSLog(@"success---%@, %@", data, img);
}

- (void)aopenImage:(id)data
{
//    NSLog(@"success---%@", data);
    
    [_subject sendNext:@"your sister"];
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        
        _webView.delegate = self;
    }
    
    return _webView;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}


- (NSString *)getHTMLStr
{
    NSString *baseStr = @"<blockquote><p>引用效果：常记溪亭日暮，沉醉不知归路。兴尽晚回舟，误入藕花深处。争渡，争渡，惊起一滩鸥鹭引用效果：暗淡轻黄体性柔，情疏迹远只香留。何须浅碧深红色，自是花中第一流。梅定妒，菊应羞，画栏开处冠中秋。骚人可煞无情思，何事当年不见收。字体效果：梧桐更兼细雨，到黄昏，点点滴滴。这次第，怎一个愁字了得？字体：花自飘零水自流，一种相思，两处闲愁，此情无计可消除，才下眉头，却上心头。永夜恹恹欢意少。&nbsp;空梦长安，认取长安道。&nbsp;为报今年春色好。&nbsp;花光月影宜相照。&nbsp;随意杯盘虽草草。&nbsp;酒美梅酸，恰称人怀抱。&nbsp;醉里插花花莫笑。&nbsp;可怜春似人将老。</p></blockquote><p style=\"text-align: center; \"><img src=\"https://images-jqp.oss-cn-shenzhen.aliyuncs.com/20190529/c36bf28fc5224e85a28e10ad96a3de5e.jpg\" style=\"max-width:100%;\" class=\"\"><br></p><p style=\"text-align: center; \"><br></p><p style=\"text-align: center; \"><font size=\"6\" color=\"#0000ff\"><b style=\"background-color: rgb(192, 192, 192);\">6.标题效果 居中</b></font></p><p><i><b><font size=\"4\" style=\"\">时间很短天涯很远。往后的一山一水一朝一夕，自己安静地走完。倘若不慎走失迷途，跌入水中也应记得有一条河流叫重生。这世上，任何地方，都可以生长；任何去处，都是归宿。那么，别来找我，我亦不去寻你。守着剩下的流年，看一段岁月静好，现世安稳。<br>人生的终点，不是在山水踏尽时，亦不是在生命结束后，而是于放下包袱的那一刻。当你真的放下，纵算一生云水漂泊，亦可淡若清风，自在安宁。倘若心中藏一弯明月，又何惧世间迷离。烟火红尘，同样可以静赏落花，闲看白云。<br>赌书泼茶，倚楼听雨，日子清简如水。禅的时光，总是寂静无声。窗外风云交替，车水马龙，内心安然平和，洁净无物。如此清淡，不是疏离尘世，而是让自己在尘世中修炼得更加质朴。人生这本蕴含真理的书，其实掩藏在平淡的物事中。返璞归真，随缘即安。</font><br></b></i></p><p><font size=\"4\"><i><b>一剪闲云一溪月，一程山水一年华。一世浮生一刹那，一树菩提一烟霞。&nbsp;人生的终点，不是在山水踏尽时，亦不是在生命结束后，而是于放下包袱的那一刻。当你真的放下，纵算一生云水漂泊，亦可淡若清风，自在安宁。</b></i></font></p><p><img src=\"https://images-jqp.oss-cn-shenzhen.aliyuncs.com/20190529/da204a0e3d1740eda21686901c487846.JPG\" style=\"max-width:100%;\"><font size=\"4\"><br></font></p><p></p><ol><li><font size=\"3\">时光若水，无言既大美。日子如莲，平凡既至雅。品茶亦是修禅，无论在喧嚣的红尘，还是处寂静山林，都可以成为修行道场。克制欲望，摒除纷扰，不是悲观，不是逃避，只是为了一种简单的活法。按住当下，哪怕是一颗狭小的心，亦可以承载万物起灭。</font></li><li><font size=\"3\">（左对齐）窗前谁种芭蕉树，阴满中庭。阴满中庭。叶叶心心，舒卷有余情。&nbsp; &nbsp;伤心枕上三更雨，点滴霖霪。点滴霖霪。愁损北人，不惯起来听。</font></li></ol><p></p><p style=\"text-align: right; \"><font face=\"楷体\" size=\"5\" color=\"#008080\" style=\"\"><i style=\"\"><strike>卖花担上，买得一枝春欲放。&nbsp;</strike></i></font></p><p style=\"text-align: right; \"><font face=\"楷体\" size=\"5\" color=\"#008080\"><i><strike>泪染轻匀，犹带彤霞晓露痕。</strike></i></font></p><p style=\"text-align: right; \"><font face=\"楷体\" size=\"5\" color=\"#008080\"><i><strike>怕郎猜道，奴面不如花面好。&nbsp;</strike></i></font></p><p style=\"text-align: right; \"><font face=\"楷体\" size=\"5\" color=\"#008080\" style=\"\"><i style=\"\"><strike>云鬓斜簪，徒要教郎比并看。</strike></i></font></p><p style=\"text-align: right; \">（右对齐）</p><p style=\"text-align: right; \"><br></p><p style=\"text-align: left;\"><a href=\"https://www.juzimi.com/ju/102189\">造化可能偏有意，故教明月玲珑地</a></p><p style=\"text-align: left;\"><img src=\"https://images-jqp.oss-cn-shenzhen.aliyuncs.com/20190529/6767e4d7e0ba497c93232d28d564c980.jpg\" style=\"max-width:100%;\"><br></p><h1>标题1：永远没有最早,永远没有最晚。<br></h1><h2>标题2：世间一切情愿，皆有定数。有情者未必有缘，有缘者未必有情。随缘即安，方可悟道。一个人只要看清楚自己，即可辨别无常世界。意乱情迷时，大可不比慌乱，静心坐禅，明天会如约而至。春花依旧那样美，秋月还是那样圆。</h2><h3>标题3：茶有浓淡，有冷暖，亦有悲欢。用一颗俗世的心品茶，难免执著于色、香、味，则少了一份清淡与质朴。茶有万千滋味，甚至融入了世情与情感。用一颗出离的心品茶，便可以从容地享受飞云过天，绿水无波的静美。</h3><h4>标题4：阳光可以将美丽过滤，却不能将其蒸发；清风可以将旧梦拂醒，却不能将其湮没。</h4><h5>标题5：浮生梦幻，皆为泡影，如露如电，似雾似烟</h5><p><img src=\"https://images-jqp.oss-cn-shenzhen.aliyuncs.com/20190529/572d331336ed45f3af18d8f3b6962356.jpg\" style=\"max-width:100%;\"><br></p><p>7.表格效果</p><table class=\"\"><tbody><tr><td></td><td>1</td><td>&nbsp;2</td><td>&nbsp;3</td><td>&nbsp;4</td><td>&nbsp;5</td><td>&nbsp;6</td><td>&nbsp;7</td><td>&nbsp;8</td><td>&nbsp;9</td><td>&nbsp;10</td><td>&nbsp;11</td></tr><tr><td>&nbsp;A</td><td>&nbsp;1A</td><td>&nbsp;2A</td><td>&nbsp;3A</td><td>4A</td><td>5A&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;B</td><td>&nbsp;1B</td><td>&nbsp;2B</td><td>&nbsp;3B</td><td>&nbsp;4B</td><td>&nbsp;5B</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;C</td><td>&nbsp;1C</td><td>&nbsp;2C</td><td>&nbsp;3C</td><td>&nbsp;4C</td><td>&nbsp;5C</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;<br></td></tr></tbody></table><br><blockquote><p>一剪闲云一溪月，一程山水一年华。一世浮生一刹那，一树菩提一烟霞。许多人，信步去看一场花事，渡船去赏一湖春水，从一座城到一个镇。一路风尘，有人将闲云装进行囊，有人将故事背负肩上，他们都在寻找那个属于心灵的原乡，可匆忙之间又忘了来路，不知归程。隐世才女白落梅，以禅意写红尘，以佛法道人生，化云水禅心，入人间烟火。与她共有一剪菩提的光阴，也听她静静地诉说这来往的缘分，俯瞰烟火人间，品静好人生，盼现世安稳.</p></blockquote>&nbsp; &nbsp;&nbsp;<table class=\"\"><tbody><tr><td>&nbsp;</td><td>&nbsp;1</td><td>&nbsp;2</td><td>&nbsp;3</td><td>&nbsp;4</td><td>&nbsp;5</td><td>&nbsp;6</td><td>&nbsp;7</td><td>&nbsp;8</td><td>&nbsp;9</td><td>&nbsp;10</td><td>&nbsp;11</td><td>&nbsp;12</td><td>&nbsp;13</td><td>&nbsp;14</td><td>&nbsp;15</td><td>&nbsp;16</td><td>&nbsp;17</td></tr><tr><td>&nbsp;A</td><td>&nbsp;2324</td><td>&nbsp;34325</td><td>&nbsp;433</td><td>&nbsp;4325</td><td>&nbsp;4235</td><td>&nbsp;353</td><td>&nbsp;3535</td><td>&nbsp;35353</td><td>&nbsp;3535</td><td>&nbsp;3253</td><td>&nbsp;3532</td><td>&nbsp;355</td><td>&nbsp;355</td><td>&nbsp;535</td><td>&nbsp;35</td><td>&nbsp;335</td><td>&nbsp;35</td></tr><tr><td>&nbsp;B</td><td>435&nbsp;</td><td>&nbsp;678</td><td>&nbsp;7868</td><td>&nbsp;22</td><td>&nbsp;656</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;C</td><td>&nbsp;4535</td><td>887</td><td>6756</td><td>243</td><td>665</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>&nbsp;D</td><td>35TR</td><td>&nbsp;76</td><td>&nbsp;68</td><td>&nbsp;233</td><td>&nbsp;466</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;E</td><td>&nbsp;354</td><td>&nbsp;68</td><td>&nbsp;77</td><td>&nbsp;43</td><td>&nbsp;6456</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;F</td><td>&nbsp;454</td><td>&nbsp;8768</td><td>&nbsp;66</td><td>&nbsp;33</td><td>&nbsp;464</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;G</td><td>&nbsp;5765</td><td>&nbsp;777</td><td>&nbsp;57</td><td>&nbsp;54</td><td>&nbsp;66</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;H</td><td>&nbsp;87</td><td>&nbsp;77</td><td>&nbsp;465</td><td>&nbsp;35</td><td>&nbsp;646</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;I</td><td>&nbsp;98</td><td>&nbsp;77</td><td>75</td><td>&nbsp;35</td><td>&nbsp;466</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;J</td><td>&nbsp;6867</td><td>&nbsp;77</td><td>&nbsp;7597</td><td>&nbsp;35</td><td>&nbsp;646</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;K</td><td>&nbsp;98</td><td>&nbsp;98</td><td>&nbsp;76</td><td>&nbsp;35</td><td>&nbsp;4646</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;L</td><td>&nbsp;998</td><td>&nbsp;89</td><td>&nbsp;76</td><td>&nbsp;35</td><td>&nbsp;4354</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;M</td><td>&nbsp;979</td><td>&nbsp;956</td><td>&nbsp;u765</td><td>&nbsp;5</td><td>&nbsp;35</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table><p>8.视频播放<br></p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\">视频居中</p><p style=\"text-align: center;\"><iframe height=\"498\" width=\"640\" src=\"http://player.youku.com/embed/XNDE5NDcxNjA5Ng==\" frameborder=\"0\" 'allowfullscreen'=\"\"></iframe></p><p style=\"text-align: left;\">视频左对齐</p><p style=\"text-align: left;\"><iframe height=\"498\" width=\"640\" src=\"http://player.youku.com/embed/XNDE5MjYwMjQ1Mg==\" frameborder=\"0\" 'allowfullscreen'=\"\"></iframe></p><p style=\"text-align: right;\">视频右对齐</p><p style=\"text-align: right;\"><iframe height=\"498\" width=\"640\" src=\"http://player.youku.com/embed/XNDE5ODg1NTI2MA==\" frameborder=\"0\" 'allowfullscreen'=\"\"></iframe></p><p style=\"text-align: center;\"><br></p><p style=\"text-align: center;\"><br></p><p><br></p>";
    return [self getHtmlWithText:baseStr];
}

- (NSString *)getHtmlWithText:(NSString *)text
{
    if (text.length == 0) text = @"暂无信息";
    
    NSString *content = [text stringByReplacingOccurrencesOfString:@"&amp;quot" withString:@"'"];
    content = [content stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    content = [content stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    content = [content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    NSString *htmls = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\" /> \n"
                       "<style type=\"text/css\"> \n"
                       "video {max-width:100%% !important;}\n"
                       "iframe {max-width:100%% !important;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",content];
    
    
    return htmls;
}


@end
