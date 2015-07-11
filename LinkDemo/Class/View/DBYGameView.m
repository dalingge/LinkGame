//
//  DBYGameView.m
//  LinkDemo
//
//  Created by SYETC02 on 15/5/26.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DBYGameView.h"
#import "DBYLinkInfo.h"

@implementation DBYGameView

// 定义音效文件
AVAudioPlayer * audioPlayerBlitz;
AVAudioPlayer * audioPlayerClick;
AVAudioPlayer * audioPlayerSearch;
AVAudioPlayer * audioPlayerBomb;
AVAudioPlayer * audioPlayerReadyGo;

// 选中标识的图片对象
UIImage* selectedImage;

// 定义连接线的颜色
UIColor* bubbleColor;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化代表选中框的图片
        selectedImage = [UIImage imageNamed:@"selected.png"];
        // 获取两个音效文件的的URL  avaudioplayer
        NSURL* disUrl = [[NSBundle mainBundle]
                         URLForResource:@"blitz" withExtension:@"mp3"];
        NSURL* guUrl = [[NSBundle mainBundle]
                        URLForResource:@"click" withExtension:@"mp3"];
        NSURL* seaUrl = [[NSBundle mainBundle]
                        URLForResource:@"search" withExtension:@"mp3"];
        NSURL* bombUrl = [[NSBundle mainBundle]
                         URLForResource:@"bomb" withExtension:@"mp3"];
        NSURL* readyGoUrl = [[NSBundle mainBundle]
                          URLForResource:@"readygo" withExtension:@"mp3"];
        
        // 加载音效文件
        audioPlayerBlitz =[[AVAudioPlayer alloc] initWithContentsOfURL:disUrl error:nil];
        audioPlayerClick =[[AVAudioPlayer alloc] initWithContentsOfURL:guUrl error:nil];
        audioPlayerSearch =[[AVAudioPlayer alloc] initWithContentsOfURL:seaUrl error:nil];
        audioPlayerBomb = [[AVAudioPlayer alloc] initWithContentsOfURL:bombUrl error:nil];
        audioPlayerReadyGo = [[AVAudioPlayer alloc] initWithContentsOfURL:readyGoUrl error:nil];
        // 使用图片平铺作为定义连接线的颜色
        bubbleColor = [UIColor colorWithPatternImage:
                       [UIImage imageNamed:@"bubble.jpg"]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.gameService == nil)
        return;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ctx, [bubbleColor CGColor]);
    CGContextSetLineWidth(ctx, 10);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    NSArray* pieces = self.gameService.pieces;   
    if (pieces != nil)
    {
        // 遍历pieces二维数组
        for (int i = 0; i < pieces.count; i++)
        {
            for (int j = 0; j < [[pieces objectAtIndex:i] count]; j++)
            {
                // 如果二维数组中该元素为DBYPiece对象（即有方块），绘制该方块
                if ([[[pieces objectAtIndex:i] objectAtIndex:j]
                     class] == DBYPiece.class)
                {
                    // 得到这个DBYPiece对象
                    DBYPiece* piece =[[pieces objectAtIndex:i] objectAtIndex:j];
                    // 将该DBYPiece对象中包含的图片绘制在制定位置
                    [piece.image.image drawAtPoint:CGPointMake(piece.beginX+5, piece.beginY)];
                }
            }
        }
    }
    // 如果当前对象中的linkInfo属性不为nil,表明有连接信息
    if (self.linkInfo != nil)
    {
        // 绘制连接线
        [self drawLine: self.linkInfo context:ctx];
        // 处理完后清空linkInfo属性
        self.linkInfo = nil;
        [self performSelector:@selector(setNeedsDisplay)
                   withObject:nil afterDelay:0.3];
    }
    // 画选中标识的图片
    if (self.selectedPiece != nil)
    {
        [selectedImage drawAtPoint:CGPointMake(self.selectedPiece.beginX+5,
                                               self.selectedPiece.beginY)];
    }
}
// 根据DBYLinkInfo绘制连接线的方法。
- (void) drawLine:(DBYLinkInfo*)linkInfo context:(CGContextRef)ctx
{
    
    // 获取DBYLinkInfo中封装的所有连接点
    NSArray* points = linkInfo.points;
    DBYPoint* firstPoint = [points objectAtIndex:0];
    CGContextMoveToPoint(ctx, firstPoint.x, firstPoint.y);
    // 依次遍历DBYLinkInfo中的每个连接点
    for (int i = 1; i < points.count; i++)
    {
        // 获取当前连接点与下一个连接点
        DBYPoint* currentPoint = [points objectAtIndex:i];
        CGContextAddLineToPoint(ctx , currentPoint.x, currentPoint.y);
    }
    // 绘制路径
    CGContextStrokePath(ctx);
}
// 开始游戏方法
- (void) startGame
{
    [audioPlayerReadyGo play];
    [self.gameService start];
    [self setNeedsDisplay];
}
// 随机交换位置
- (void)randomOccurrence
{
    [self.gameService random];
    [audioPlayerSearch play];
    [self setNeedsDisplay];
}
//选中炸掉相同
- (BOOL)bombIdentical{
    
    // 获取DBYGameService中的DBYPiece二维数组
    NSArray* pieces = self.gameService.pieces;
    // 表示之前没有选中任何一个DBYPiece
    if (self.selectedPiece == nil){
        return NO;
    }else{
        // 播放方块连接成功的音效
        [audioPlayerBomb play];
        [self handleBombPriece:self.selectedPiece pieces:pieces];
        return YES;
    }
        
}

// 查找相同的
- (void)searchIdentical{
    // 获取DBYGameService中的DBYPiece二维数组
    NSArray * pieces = self.gameService.pieces;
    
    
    do{
        int arcX=arc4random()%(xSize-1)+1;
        int arcY=arc4random()%(ySize-1)+1;
        if ([pieces[arcX][arcY] class]==DBYPiece.class ){
            self.selectedPiece = ((DBYPiece* )pieces[arcX][arcY]);
            for(int x=1; x<xSize; x++){
                for(int y=1; y<ySize; y++){
                    if ([pieces[x][y] class]==DBYPiece.class ){
                        DBYPiece * currentPiece = ((DBYPiece* )pieces[x][y]);
                        // 在这里就要对currentPiece和prePiece进行判断并进行连接
                        DBYLinkInfo* linkInfo = [self.gameService linkWithBeginPiece:self.selectedPiece endPiece:currentPiece];
                        // 两个DBYPiece不可连, linkInfo为nil
                        if (linkInfo != nil)
                        {
                            // 播放方块连接成功的音效
                            [audioPlayerBlitz play];
                            
                            // 处理成功连接
                            [self handleSuccessLink:linkInfo prevPiece:self.selectedPiece
                                       currentPiece: currentPiece pieces:pieces];
                            return;
                        }
                    }
                }
            }
        }
    }while (1==1);


}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    // 获取DBYGameService中的DBYPiece二维数组
    NSArray* pieces = self.gameService.pieces;
    // 获取用户触碰的点
    CGPoint touchPoint = [touch locationInView:self];
    // 根据用户触碰的坐标得到对应的DBYPiece对象
    DBYPiece* currentPiece = [self.gameService findPieceAtTouchX: touchPoint.x
                                                         touchY: touchPoint.y];
    // 如果没有选中任何DBYPiece对象(即鼠标点击的地方没有图片), 不再往下执行
    if ([currentPiece class] != DBYPiece.class)
        return;
    // 表示之前没有选中任何一个DBYPiece
    if (self.selectedPiece == nil)
    {
        // 将当前方块设为已选中的方块, 通知DBYGameView重新绘制, 并不再往下执行
        self.selectedPiece = currentPiece;
        // 播放选中方块的音效
        [audioPlayerClick play];
        [self setNeedsDisplay];
        return;
    }
    // 表示之前已经选择了一个
    else
    {
        // 在这里就要对currentPiece和prePiece进行判断并进行连接
        DBYLinkInfo* linkInfo = [self.gameService linkWithBeginPiece:
                                self.selectedPiece endPiece:currentPiece];
        // 两个DBYPiece不可连, linkInfo为nil
        if (linkInfo == nil)
        {
            // 如果连接不成功, 将当前方块设为选中方块
            self.selectedPiece = currentPiece;
            // 播放选中一个方块的音效
            [audioPlayerClick play];
            
            [self setNeedsDisplay];
        }
        else
        {
            // 播放方块连接成功的音效
            [audioPlayerBlitz play];
            
            // 处理成功连接
            [self handleSuccessLink:linkInfo prevPiece:self	.selectedPiece
                       currentPiece: currentPiece pieces:pieces];

        }
    }
}
/**
 * 成功连接后处理
 *
 * @param linkInfo 连接信息
 * @param prePiece 前一个选中方块
 * @param currentPiece 当前选择方块
 * @param pieces 系统中还剩的全部方块
 */
- (void) handleSuccessLink:(DBYLinkInfo*)linkInfo
                 prevPiece:(DBYPiece*)prevPiece
              currentPiece:(DBYPiece*)currentPiece
                    pieces:(NSArray*) pieces  
{
    // 它们可以相连, 让UIGameView处理DBYLinkInfo
    _linkInfo = linkInfo;
    // 将gameView中的选中方块设为nil
    self.selectedPiece = nil;
    // 将两个DBYPiece对象从数组中删除
    [[pieces objectAtIndex:prevPiece.indexX] setObject:[NSObject new] atIndex:prevPiece.indexY];
    [[pieces objectAtIndex:currentPiece.indexX] setObject:[NSObject new] atIndex:currentPiece.indexY];
    [self.delegate checkWin:self];
    [self setNeedsDisplay];
    now+=100;
    
}

/**
 *  炸弹
 *
 *  @param prevPiece 选中方块
 *  @param pieces    系统中还剩的全部方块
 */
- (void) handleBombPriece:(DBYPiece*)prevPiece
                   pieces:(NSArray*) pieces
{
    // 将gameView中的选中方块设为nil
    self.selectedPiece = nil;
    
    for(int x=1; x<xSize; x++)
    {
        for(int y=1; y<ySize; y++)
            
        {
       
            if ([pieces[x][y] class]==DBYPiece.class ){
                
                if ([prevPiece.image.imageId isEqualToString:((DBYPiece* )pieces[x][y]).image.imageId]) {
                    NSInteger indexX = ((DBYPiece* )pieces[x][y]).indexX;
                    NSInteger indexY = ((DBYPiece* )pieces[x][y]).indexY;
                    if (indexX+indexY!=prevPiece.indexX+prevPiece.indexY) {
                        
                        [[pieces objectAtIndex:prevPiece.indexX] setObject:[NSObject new] atIndex:prevPiece.indexY];//清除选择方块
                        
                        [[pieces objectAtIndex:indexX]setObject:[NSObject new]atIndex:indexY];//清除最近相同方块
                        [self.delegate checkWin:self];
                        [self setNeedsDisplay];
                         now+=100;
                        return;
                    }

                }
                
            }
            
            
        }
    }
    
}

@end
