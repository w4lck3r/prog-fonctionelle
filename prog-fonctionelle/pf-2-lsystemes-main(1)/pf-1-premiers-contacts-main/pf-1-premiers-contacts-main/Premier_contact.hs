-- 3
sommeDeXaY :: Num a => [a] -> a
sommeDeXaY [] = 0
sommeDeXaY (x:xs) = x + sommeDeXaY xs

-- 4 -- ici la fonction somme fait la meme chose que sommeDeXaY mais en utilisant head et tail
somme :: Num a => [a] -> a
somme [] = 0
somme x = head x + somme (tail x) 

-- 5
last' :: [a] -> a
last' [] = error "last d'une liste vide"
last' [x] = x
last' (x:xs) = last' xs
-- last' x = head ( reverse x )

init' :: [a] -> [a]
init' [] = error "init d'une liste vide"
init' [x] = []
init' (x:xs) = x:(init' xs)
-- init' x = reverse (tail ( reverse x))

-- 6
infix 5 !!!
(!!!) :: [a] -> Int -> a
(!!!) a i   | length a < (i+1)  = error "indice trop gros!"
            | otherwise         = last' ( take (i+1) a)

infixr 5 +++
(+++) :: [a] -> [a] -> [a]
(+++) [] a = a
(+++) a b = (init' a) +++ ((last' a) : b)

concat' :: [[a]] -> [a]
concat' [a, b] = a +++ b

map' :: (a -> b) -> [a] -> [b]
map' f [] = []
map' f (x:xs) = [f x] +++ (map' f xs)

-- 7
l = [1..10]
x = (!!) l
-- cette declaration represente une fonction prefixe !! sur la liste l
-- (par ce qu'on a utiliser les parenthese avec une fonction infixe: !! qui s'applique sur la list l deja definie)

-- 8
-- length' :: [a] => Int
length' a = somme(map (const 1) a)

-- 9
-- fn :: Num n => (a -> a) -> a -> n
fn _ _ 0 = []
fn f x n = x : (fn f (f x) (n-1)) 

-- 10
-- fnN :: Int a => n -> [a]
fnN n = fn (\x->x+1) 0 (n+1)