//
//  PooViewController.m
//  heart
//
//  Created by crazypoo on 14-2-14.
//  Copyright (c) 2014年 crazypoo. All rights reserved.
//

#import "PooViewController.h"
@class CAEmitterLayer;

@interface PooViewController ()
@property (nonatomic, weak) IBOutlet UIButton *likeButton;
@property (strong)			CAEmitterLayer	*heartsEmitter;

@end

@implementation PooViewController
@synthesize likeButton;
@synthesize heartsEmitter;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
	self.heartsEmitter = [CAEmitterLayer layer];
	self.heartsEmitter.emitterPosition = CGPointMake(likeButton.frame.origin.x + likeButton.frame.size.width/2.0,
													 likeButton.frame.origin.y + likeButton.frame.size.height/2.0);
	self.heartsEmitter.emitterSize = likeButton.bounds.size;	
	self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
	self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
	self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
	
	CAEmitterCell *heart = [CAEmitterCell emitterCell];
	heart.name = @"heart";
	heart.emissionLongitude = M_PI/2.0;
	heart.emissionRange = 0.55 * M_PI;
	heart.birthRate		= 0.0;
	heart.lifetime		= 10.0;
	heart.velocity		= -120;
	heart.velocityRange = 60;
	heart.yAcceleration = 20;
	heart.contents		= (id) [[UIImage imageNamed:@"PooHeart"] CGImage];
	heart.color			= [[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.5] CGColor];
	heart.redRange		= 0.3;
	heart.blueRange		= 0.3;
	heart.alphaSpeed	= -0.5 / heart.lifetime;
	heart.scale			= 0.15;
	heart.scaleSpeed	= 0.5;
	heart.spinRange		= 2.0 * M_PI;
	
	self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
	[self.view.layer addSublayer:heartsEmitter];
}

- (void)viewWillUnload
{
	[super viewWillUnload];
	[self.heartsEmitter removeFromSuperlayer];
	self.heartsEmitter = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)likeButtonPressed:(id)sender
{
	CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
	heartsBurst.fromValue		= [NSNumber numberWithFloat:150.0];
	heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
	heartsBurst.duration		= 5.0;
	heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	
	[self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
}

@end
