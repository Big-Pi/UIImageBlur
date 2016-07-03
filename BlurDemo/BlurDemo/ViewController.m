//
//  ViewController.m
//  BlurDemo
//
//  Created by pi on 16/7/3.
//  Copyright © 2016年 pi. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+GaussianBlur.h"
#import "UIImage+ClipRoundCorner.h"

static int i;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (strong,nonatomic) NSArray *imagesArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesArray=@[[UIImage imageNamed:@"_doggy"],[UIImage imageNamed:@"github"],[UIImage imageNamed:@"StackOverflow"]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImage *img= self.imagesArray[i++%3];
    self.imageView.image=img;
    
    //1. work but so slow.
//    self.blurImageView.image=[img coreBlurWithNumber:6];
    
    //2. fast, little problem on Image with transparent background;
    
//    img= [self whiteBG:img]; //draw image with white backgroudcolor;
    
    self.blurImageView.image=[img vImageBlurWithNumber:0.25];
    
    //3. clip image , worse
//    img=[img vImageBlurWithNumber:0.25];
//    img=[img clipRoundCornerWithRadius:MAX(img.size.width, img.size.height)];
//    self.blurImageView.image=img;
    
    //4. modify last 2 parameter of `vImageBoxConvolve_ARGB8888` function in `UIImage+GaussianBlur.m`
}


-(UIImage *)whiteBG:(UIImage*)image{
    UIGraphicsBeginImageContextWithOptions(image.size, YES, [UIScreen mainScreen].scale);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGRect fillRect=CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextFillRect(ctx,fillRect); //draw white backgroud color
    [image drawInRect:fillRect]; //draw image on top of the white background color
    UIImage *img= UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
