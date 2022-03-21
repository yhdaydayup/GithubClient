//
//  GCBlobViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/27.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCBlobViewController.h"
#import <Masonry/Masonry.h>
#import "GCGithubApi.h"
#import "GCTools.h"
//#import "GithubClient-Bridging-Header.h"
#import "Highlightr-Swift.h"
//@import Highlightr;
//1c,
//abnf,
//accesslog,
//actionscript,
//ada,
//apache,
//applescript,
//cpp,
//arduino,
//armasm,
//xml,
//asciidoc,
//aspectj,
//autohotkey,
//autoit,
//avrasm,
//awk,
//axapta,
//bash,
//basic,
//bnf,
//brainfuck,
//cal,
//capnproto,
//ceylon,
//clean,
//clojure,
//"clojure-repl",
//cmake,
//coffeescript,
//coq,
//cos,
//crmsh,
//crystal,
//cs,
//csp,
//css,
//d,
//markdown,
//dart,
//delphi,
//diff,
//django,
//dns,
//dockerfile,
//dos,
//dsconfig,
//dts,
//dust,
//ebnf,
//elixir,
//elm,
//ruby,
//erb,
//"erlang-repl",
//erlang,
//excel,
//fix,
//flix,
//fortran,
//fsharp,
//gams,
//gauss,
//gcode,
//gherkin,
//glsl,
//go,
//golo,
//gradle,
//groovy,
//haml,
//handlebars,
//haskell,
//haxe,
//hsp,
//htmlbars,
//http,
//hy,
//inform7,
//ini,
//irpf90,
//java,
//javascript,
//"jboss-cli",
//json,
//julia,
//"julia-repl",
//kotlin,
//lasso,
//ldif,
//leaf,
//less,
//lisp,
//livecodeserver,
//livescript,
//llvm,
//lsl,
//lua,
//makefile,
//mathematica,
//matlab,
//maxima,
//mel,
//mercury,
//mipsasm,
//mizar,
//perl,
//mojolicious,
//monkey,
//moonscript,
//n1ql,
//nginx,
//nimrod,
//nix,
//nsis,
//objectivec,
//ocaml,
//openscad,
//oxygene,
//parser3,
//pf,
//php,
//pony,
//powershell,
//processing,
//profile,
//prolog,
//protobuf,
//puppet,
//purebasic,
//python,
//q,
//qml,
//r,
//rib,
//roboconf,
//routeros,
//rsl,
//ruleslanguage,
//rust,
//scala,
//scheme,
//scilab,
//scss,
//shell,
//smali,
//smalltalk,
//sml,
//sqf,
//sql,
//stan,
//stata,
//step21,
//stylus,
//subunit,
//swift,
//taggerscript,
//yaml,
//tap,
//tcl,
//tex,
//thrift,
//tp,
//twig,
//typescript,
//vala,
//vbnet,
//vbscript,
//"vbscript-html",
//verilog,
//vhdl,
//vim,
//x86asm,
//xl,
//xquery,
//zephir

//NSString *languageType(NSString *fileName){
//    if([fileName hasSuffix:@".c"]) {
//        return @"cpp";
//    }
//}

@interface GCBlobViewController ()
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;
@end

@implementation GCBlobViewController
- (instancetype)initWithFullName:(NSString *)fullName WithSha:(NSString *)sha {
    if(self = [super init]) {
        _scrollView = [[UIScrollView alloc] init];
        _contentView = [[UIView alloc] init];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        setRequiredOnVerticalAndHorizontalForUIView(_textLabel);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        __weak typeof(self) weakSelf = self;
        [[GCGithubApi shareGCGithubApi] getWithUrl:getBlogUrl(fullName, sha) WithAcceptType:JSonContent WithSuccessBlock:^(id responseObj){
                    NSData *data = [[NSData alloc] initWithBase64EncodedString:[responseObj objectForKey:@"content"] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    NSString *decode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            Highlightr *lighter = [[Highlightr alloc] init];
//            [lighter setThemeTo:@"xcode"];
//            NSLog(@"%@", [lighter supportedLanguages]);
//            weakSelf.textLabel.attributedText = [lighter highlight:decode as:@"objectivec" fastRender:YES];
            weakSelf.textLabel.text = decode;
        } WithFailureBlock:^{}];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView.mas_width);
    }];
    
    [self.contentView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_contentView.mas_left);
        make.right.mas_equalTo(_contentView.mas_right);
        make.top.mas_equalTo(_contentView.mas_top);
        make.bottom.mas_equalTo(_contentView.mas_bottom);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//vs,
//"atelier-seaside-dark",
//"brown-paper",
//"atelier-plateau-light",
//"school-book",
//xcode,
//"atelier-sulphurpool-dark",
//"tomorrow-night-blue",
//vs2015,
//"atelier-heath-dark",
//"paraiso-light",
//rainbow,
//"qtcreator_light",
//"kimbie.dark",
//"atelier-heath-light",
//far,
//"atelier-dune-dark",
//"kimbie.light",
//railscasts,
//"solarized-dark",
//"atelier-estuary-light",
//xt256,
//"mono-blue",
//ocean,
//"github-gist",
//"atelier-seaside-light",
//"tomorrow-night-eighties",
//"atom-one-dark",
//"qtcreator_dark",
//"atelier-savanna-dark",
//"color-brewer",
//pojoaque,
//routeros,
//"atelier-forest-dark",
//"tomorrow-night",
//obsidian,
//"atelier-lakeside-dark",
//"gruvbox-light",
//idea,
//tomorrow,
//"atelier-forest-light",
//"arduino-light",
//"gruvbox-dark",
//dracula,
//magula,
//arta,
//purebasic,
//hopscotch,
//github,
//dark,
//"atom-one-light",
//monokai,
//docco,
//default,
//ascetic,
//"atelier-cave-light",
//"atelier-sulphurpool-light",
//"atelier-plateau-dark",
//darkula,
//"atelier-cave-dark",
//"ir-black",
//"solarized-light",
//"tomorrow-night-bright",
//"atelier-savanna-light",
//foundation,
//"codepen-embed",
//"atelier-estuary-dark",
//googlecode,
//"atelier-dune-light",
//"paraiso-dark",
//zenburn,
//androidstudio,
//grayscale,
//sunburst,
//agate,
//hybrid,
//darcula,
//"atelier-lakeside-light",
//"monokai-sublime"



