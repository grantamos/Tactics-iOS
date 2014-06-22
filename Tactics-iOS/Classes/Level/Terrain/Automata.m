//
//  Automata.m
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import "Automata.h"
#include <stdlib.h>

#define print(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface Automata() {
    int _width;
    int _height;
    int _iterations;
    int _killAmount;
    int _growAmount;
}

@end

@implementation Automata

- (id)initWithWidth:(int)width
             height:(int)height
         iterations:(int)iterations
         killAmount:(int)killAmount
      andGrowAmount:(int)growAmount
{
    self = [super init];
    
    if (self)
    {
        _width = width;
        _height = height;
        _iterations = iterations;
        _killAmount = killAmount;
        _growAmount = growAmount;
    }
    
    return self;
}

- (UIImage*)createAutomataImage
{
    int *source = [self createAutomata];
    
    char* rgba = (char*)malloc(_width*_height*4);
    
    for (int x = 0; x < _width; x++)
    {
        for (int y = 0; y < _height; y++)
        {
            int i = _width * y + x;
            int val = source[i] * 127;
            
            rgba[4*i] = val;
            rgba[4*i+1] = 0;
            rgba[4*i+2] = 0;
            rgba[4*i+3] = 255;
        }
    }
    
    free(source);
    
    size_t bufferLength = _width * _height * 4;
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, rgba, bufferLength, NULL);
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = 4 * _width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    if(colorSpaceRef == NULL)
    {
        NSLog(@"Error allocating color space");
        CGDataProviderRelease(provider);
        return nil;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef iref = CGImageCreate(_width,
                                    _height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,   // data provider
                                    NULL,       // decode
                                    YES,            // should interpolate
                                    renderingIntent);
    
    uint32_t* pixels = (uint32_t*)malloc(bufferLength);
    
    if(pixels == NULL)
    {
        NSLog(@"Error: Memory not allocated for bitmap");
        CGDataProviderRelease(provider);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(iref);
        return nil;
    }
    
    CGContextRef context = CGBitmapContextCreate(pixels,
                                                 _width,
                                                 _height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 bitmapInfo);
    
    if(context == NULL)
    {
        NSLog(@"Error context not created");
        free(pixels);
    }
    
    UIImage *image = nil;
    if(context)
    {
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, _width, _height), iref);
        
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
        // Support both iPad 3.2 and iPhone 4 Retina displays with the correct scale
        if([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)]) {
            float scale = [[UIScreen mainScreen] scale];
            image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
        } else {
            image = [UIImage imageWithCGImage:imageRef];
        }
        
        CGImageRelease(imageRef);
        CGContextRelease(context);
    }
    
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(iref);
    CGDataProviderRelease(provider);
    
    if(pixels)
    {
        free(pixels);
    }
    
    return image;
}

- (int*)createAutomata
{
    int size = _width * _height;
    int *cell = (int*) malloc(size*sizeof(int));
    int *cell2 = (int*) malloc(size*sizeof(int));
    
    //Fill randomly
    for (int i = 0; i < size; i++)
    {
        cell[i] = arc4random_uniform(2);
        cell2[i] = cell[i];
    }
    
    [self printCell:cell];
    
    //Apply rules for X iterations
    for (int i = 0; i < _iterations; i++)
    {
        int *source = cell;
        int *dest = cell2;
        
        if (i % 2 != 0)
        {
            source = cell2;
            dest = cell;
        }
        
        for (int x = 0; x < _width / 2; x++)
        {
            for (int y = 0; y < _height; y++)
            {
                int currentVal = source[y * _width + x];
                dest[y * _width + x] = currentVal;
                
                int countNearMe = [self countNearX:x andY:y inArr:source];
                
                //Try to kill
                if (countNearMe < _killAmount && currentVal == 1)
                    dest[y * _width + x] = 0;
                
                //Try to grow
                if (countNearMe > _growAmount && currentVal == 0)
                    dest[y * _width + x] = 1;
                
                //Try to grow upwards?
                if (countNearMe > 5 && currentVal == 1)
                    dest[y * _width + x] = 2;
            }
        }
        
        [self printCell:dest];
    }
    
    if (_iterations % 2 == 0)
        free(cell2);
    else
    {
        free(cell);
        cell = cell2;
    }
    
    for (int x = 0; x < _width/2; x++)
    {
        for (int y = 0; y < _height; y++)
        {
            cell[y * _width + _width - 1 - x] = cell[y * _width + x];
        }
    }
    
    return cell;
}

- (int**)createAutomata2DArray
{
    int *source = [self createAutomata];
    int **output = malloc(sizeof(int*) * _width);
    
    for (int x = 0; x < _width; x++)
    {
        output[x] = malloc(sizeof(int) * _height);
        for (int y = 0; y < _height; y++)
        {
            output[x][y] = source[y * _width + x];
        }
    }
    
    free(source);
    
    return output;
}

- (NSArray*)createBoxedAutomata
{
    int *source = [self createAutomata];
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (int x = 0; x < _width; x++)
    {
        NSMutableArray *column = [NSMutableArray new];
        
        for (int y = 0; y < _height; y++)
        {
            [column addObject:[NSNumber numberWithInt:source[y * _width + x]]];
        }
        
        [result addObject:column];
    }
    
    return result;
}

- (int)countNearX:(int)xin andY:(int)yin inArr:(int*)arr
{
    int count = 0;
    
    for (int x = xin - 1; x <= xin + 1; x++)
    {
        for (int y = yin - 1; y <= yin + 1; y++)
        {
            if (x == xin && y == yin)
                continue;
            
            if (x >= 0 && x < _width && y >= 0 && y < _height)
                count += arr[y * _width + x];
        }
    }
    
    return count;
}

- (int)getValueFrom:(int*)arr atX:(int)x andY:(int)y
{
    return arr[_width * y + x];
}

- (void)printCell:(int*)cell
{
    print(@"---------------");
    NSString *row = @"";
    for (int y = 0; y < _height; y++)
    {
        for (int x = 0; x < _width; x++)
        {
            row = [row stringByAppendingString:[NSString stringWithFormat:@"%d", cell[y * _width + x]]];
        }
        
        print(row);
        row = @"";
    }
    print(@"---------------");
}

@end
