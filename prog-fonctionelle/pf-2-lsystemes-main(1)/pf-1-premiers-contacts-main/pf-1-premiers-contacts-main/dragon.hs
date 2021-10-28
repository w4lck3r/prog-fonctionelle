import Graphics.Gloss

main = animate (InWindow "DragonOrdre" (500, 500) (0, 0)) white (dragonAnime (50,250) (450,250))

dragonAnime a b t = Line (dragonOrdre a b 20)

--- Échauffement ###
-- 1
alterne :: [a] -> [a]
alterne [] = []
alterne [a] = [a]
alterne (a:b:xs) = a : alterne xs

-- 2
combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine f [] _ = []
combine f _ [] = []
combine f (x:xs) (y:ys) = (f x y) : (combine f xs ys)

--- Triangle de Pascal ###
-- 3
pasPascal :: [Integer] -> [Integer]
pasPascal (x:xs) = 1:(zipWith (+) (x:xs) (xs))++[1]

-- 4
pascal :: [[Integer]]
pascal = iterate (pasPascal) [1]

pascal' :: [[Integer]]
pascal' = [1]: map (pasPascal) pascal 

--- Courbe du dragon ###
-- 5
pointAintercaler :: Point -> Point -> Point
pointAintercaler (xA, yA) (xB, yB) = ((xA+xB)/2+(yB-yA)/2,(yA+yB)/2+(xA-xB)/2)

-- 6
pasDragon :: Path -> Path
pasDragon [] = []
pasDragon [x] = [x]
pasDragon [x,xs] = [x, (pointAintercaler x xs), xs]
pasDragon (x:xs:xss:xsss) = [x,(pointAintercaler x xs), xs, (pointAintercaler xss xs)] ++ pasDragon(xss:xsss)

-- 7
dragon :: Point -> Point -> [Path]
dragon a b = iterate (pasDragon) [a,b]

dragon' :: Point -> Point -> [Path]
dragon' a b = [a,b] : map (pasDragon) (dragon a b)

-- 8
dragonOrdre :: Point -> Point -> Int -> Path
dragonOrdre a b i =  last (take i (dragon a b))
