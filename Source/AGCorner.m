//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AGCorner.h"

extern BOOL AGCornerIsOnSide(AGCorner corner, AGSide side)
{
    return (corner & side) == side;
}

CGPoint AGCornerConvertToAnchorPoint(AGCorner corner)
{
    switch (corner) {
        case AGCornerTopLeft:
            return CGPointMake(0, 0);
            break;
        case AGCornerTopRight:
            return CGPointMake(1, 0);
            break;
        case AGCornerBottomLeft:
            return CGPointMake(0, 1);
            break;
        case AGCornerBottomRight:
            return CGPointMake(1, 1);
            break;
    }
}

CGPoint AGCornerConvertToPointForRect(AGCorner corner, CGRect rect)
{
    CGPoint anchor = AGCornerConvertToAnchorPoint(corner);
    CGPoint p = CGPointGetPointForAnchorPointInRect(anchor, rect);
    return p;
}
