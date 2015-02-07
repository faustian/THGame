//
//  Map.swift
//  THGame
//
//  Created by Alexander M. Shoup on 2/7/15.
//  Copyright (c) 2015 Kimberly Lister. All rights reserved.
//

struct Tile {
    var tileindex = 1
    var obstacle = false
}

class TileMap {
    let xwidth, ywidth: Int
    var array: Array<Tile>
    
    init(xwidth: Int, ywidth: Int) {
        self.xwidth = xwidth
        self.ywidth = ywidth
        array = Array<Tile>(count:xwidth*ywidth, repeatedValue: Tile())
    }
    
    convenience init(xwidth: Int, ywidth: Int, mapInfo: String) {
        self.init(xwidth: xwidth, ywidth:ywidth)
        //Load tile array from plist probably
        //TODO figure out how to do this
    }
    
    func getTile(#x: Int, y: Int) -> Tile {
        return array[x*xwidth + y]
    }
    
    func tryMove(xpos: Float, ypos: Float, xstep: Float, ystep: Float) -> (Float, Float) {
        //Given an object at postition (xpos, ypos), try to move as far as possible
        //towards postition (xpos+xstep + ypos + ystep).
        //Assumes a small (<<1.0) step length.
        var resx: Float?
        var resy: Float?
        
        let newx = xpos+xstep
        let newy = ypos+ystep
        if(Int(newx) == Int(xpos)) {resx = newx} //still within tile, so no need to check
        if(Int(newy) == Int(ypos)) {resy = newy} //still within tile, so no need to check
        if(resx != nil){
            if(resy != nil){
              return (resx!, resy!) //if we're still in the same tile, we're good
            }
            //we're in the same tile in the x direction, but not in the y
            let ytile = getTile(x: Int(xpos), y: Int(newy)) //next tile in the y direction
            if(!ytile.obstacle) {return (resx!, newy)}
            //truncate y to stop at the obstacle
            return (resx!, Float(Int(newy)))
        }
        if(resy != nil){
            //we're in the same tile in the y direction, but not in the x
            let xtile = getTile(x: Int(newx), y: Int(ypos)) //next tile in the x direction
            if(!xtile.obstacle) {return (newx, resy!)}
            //truncate y to stop at the obstacle
            return (Float(Int(newx)), resy!)
        }
        //diagonal!
        let xtile = getTile(x: Int(newx), y: Int(ypos)) //next tile in the x direction
        let ytile = getTile(x: Int(xpos), y: Int(newy)) //next tile in the y direction
        if(xtile.obstacle) {resx = Float(Int(newx))}
        if(ytile.obstacle) {resy = Float(Int(newy))}
        if(resx != nil && resy != nil) {return (resx!, resy!)} //both tiles are obstacles
        
        let newtile = getTile(x: Int(newx), y: Int(newy)) //next tile in both directions (diagonal)
        if(resx != nil || resy != nil) { //if only one of the adjacent tiles are blocked
            if(!newtile.obstacle) {return (newx, newy)} //we can get to the new tile
            //we hit the corner. case on the direction we are moving in
            if(abs(xstep) >= abs(ystep)) {return (newx, Float(Int(newy)))}
            return (Float(Int(newx)), newy)
        }
        
        return (xpos, ypos) //this shouldn't happen but w/e
    }
    
    
}