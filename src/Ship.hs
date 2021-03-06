module Ship (
    drawShip
    ) where

import Data.Complex
import Graphics.GD
import Plot

maxNumberOfIterations = 4096



drawShip::Coordinate->Color
drawShip (x,y) = getColor $ ship (0 :+ 0)  (x :+ y) 0

ship::Complex Double
    -> Complex Double
    -> Int
    -> Int
ship z c iter
    | iter > maxNumberOfIterations = 0
    | otherwise = let zNext = (abs(realPart z) :+ abs(imagPart z))^2 + c in 
                if magnitude zNext > 2 
                then iter
                else ship zNext c (iter+1)

colorPalette::[[Int]]
colorPalette = [[r,g,b] | r<-[0,16..255],g<-[0,16..255],b<-[0,16..255]]

getColor::Int -> Color
getColor x
    | x > maxNumberOfIterations = rgb 255 255 255
    | otherwise = let c = colorPalette !! x
                   --   r = x `mod` 4 * 64
                   --   g = x `mod` 8 * 32
                   --   b = x `mod` 16 * 16
                in rgb (c !! 0) (c !! 1) (c !! 2) 
