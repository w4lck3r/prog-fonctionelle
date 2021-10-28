import Graphics.Gloss
config = (((-150,0),0),100,1,pi/3,"F+-")
dessin = interpreteMot config "F+F--F+F"
-- main = display (InWindow "L-système" (1000, 1000) (0, 0)) white dessin
main = animate (InWindow "Testing" (500, 500) (0, 0)) white (dragonAnime)

type Symbole  = Char
type Mot      = [Symbole]
type Axiome   = Mot
type Regles   = Symbole -> Mot
type LSysteme = [Mot]

-- ### IMPLEMENTATION ###
-- 1
interpreterL :: Symbole -> Mot
interpreterL 'F' = "F - F + + F - F "
interpreterL '+' = "+"
interpreterL '-' = "-"
interpreterL ' ' = " "

motSuivant :: Regles -> Mot -> Mot
motSuivant regles mot = concat (map regles mot)

-- 2
-- correcte

-- 3
lsysteme :: Axiome -> Regles -> LSysteme
lsysteme axiome regles = axiome:lsysteme (motSuivant regles axiome) regles
-- take 3 (lsysteme "F" interpreterL)

-- ### TORTUE ###
type EtatTortue = (Point, Float)

type Config = (EtatTortue -- État initial de la tortue
              ,Float      -- Longueur initiale d’un pas
              ,Float      -- Facteur d’échelle
              ,Float      -- Angle pour les rotations de la tortue
              ,[Symbole]) -- Liste des symboles compris par la tortue

-- 4
etatInitial :: Config -> EtatTortue
etatInitial (a,b,c,d,e) = a

longueurPas :: Config -> Float
longueurPas (a,b,c,d,e) = b

facteurEchelle :: Config -> Float
facteurEchelle (a,b,c,d,e) = c

angle :: Config -> Float
angle (a,b,c,d,e) = d

symbolesTortue :: Config -> [Symbole]
symbolesTortue (a,b,c,d,e) = e

-- 5
avance :: Config -> EtatTortue -> EtatTortue
avance config ((xi, yi), capI) = ((xi + (longueurPas config) * (cos capI), yi + (longueurPas config) * (sin capI)), capI) 

-- 6
tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche config (posI, capI) = (posI, capI - (angle config))

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite config (posI, capI) = (posI, capI + (angle config))

-- 7
filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue config mot = filter (`elem` (symbolesTortue config) ) mot

-- on peut generer une Picture a partir d'un Path en utilisant la fonction line
--- line :: Path -> Picture

-- 8
type EtatDessin = (EtatTortue, Path)

-- on cree cette fonction pour pouvoir extraire la position d'un EtatTortue donner
-- pour la mettre a jour dans le nouveau EtatTortue qui se trouve dans l'EtatDessin retourne par interpreteSymbole
positionTortue :: EtatTortue -> Point
positionTortue (pos, cap) = pos

-- cette fonction n'est pas vraiment necessaire? 
capTortue :: EtatTortue -> Float
capTortue (pos, cap) = cap

-- d'apres la question cette fonction devrais extraire le symbole du config
-- l'interpreter de maniere non explicite donc ca devrait fonctionner pour tout les configs
-- quelque soit les symboles,
-- this function should at the beginning check if the symbole is 
-- a part of the rules defined in the config of this drawing filtreSymbolesTortue ::
-- then it should apply the function of the corresponding rule on this EtatDessin to produce a new EtatDessin
interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole config (e, p) 'F' = ( avance config e, (positionTortue (avance config e):p) )
interpreteSymbole config (e, p) '+' = ( tourneADroite config e, p )
interpreteSymbole config (e, p) '-' = ( tourneAGauche config e, p )
interpreteSymbole config (e, p) _ = (e, p)

-- interpreteSymbole' :: Config -> EtatDessin -> Symbole -> EtatDessin
-- interpreteSymbole' config etatDessin symbol | 

-- on va definir une fonction intermediaire qui sert comme une collection des regles pour pouvoir
-- l'utiliser dans interpreteSymbole?

-- interpreteSymbole' :: Config -> EtatDessin -> Symbole -> EtatDessin
-- interpreteSymbole' config (e, p) symbole = 

-- 9
-- nouse avons ajouter le nouveau point a l'entete de la liste de EtatDessin
-- cela nous permet d'avoir une complexite de temps de O(1) au lieu de O(n)

-- 10
-- au debut il y aura un EtatDessin avec un EtatTortue a l'etat initial qui n'est pas necessairement le point (0,0) et le cap 0,
-- donc qui n'est pas necessairement ((0,0), 0), mais un etat qu'on peut l'extraire du config en utilisant la fonction etatInital
-- et le path qui est une liste des point sera necessairement une liste vide comme le dessin doit etre au debut vide
-- donc l'EtatDessin sera: (etatInitial config, []), mais apres la premiere iteration on doit prendre le dernier EtatTortue a partir
-- du EtatDessin et le modifier pour trouver le nouveau EtatTortue et Path, donc le nouveau EtatDessin on utilise la fonction dessiner.
getPath :: EtatDessin -> Path
getPath (a, b) = b

interpreteMot :: Config -> Mot -> Picture
interpreteMot config mot = line (ptInitial:(reverse (getPath pathTortue)))
        where
            dessiner :: EtatDessin -> Mot -> EtatDessin
            dessiner etatDessin [] = etatDessin
            dessiner etatDessin (x:xs) =  dessiner (interpreteSymbole config etatDessin x) xs
            ptInitial = (positionTortue (etatInitial config))
            pathTortue = (dessiner (etatInitial config, []) mot)

-- 11
-- les exemples fournis
vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch2 :: LSysteme
vonKoch2 = lsysteme "F++F++F++" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

hilbert :: LSysteme
hilbert = lsysteme "X" regles
    where regles 'X' = "+YF-XFX-FY+"
          regles 'Y' = "-XF+YFY+FX-"
          regles  s  = [s]

dragon :: LSysteme
dragon = lsysteme "FX" regles
    where regles 'X' = "X+YF+"
          regles 'Y' = "-FX-Y"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

vonKoch2Anime :: Float -> Picture
vonKoch2Anime = lsystemeAnime vonKoch2 (((-400, -250), 0), 800, 1/3, pi/3, "F+-")

hilbertAnime :: Float -> Picture
hilbertAnime = lsystemeAnime hilbert (((-400, -400), 0), 800, 1/2, pi/2, "F+-")

dragonAnime :: Float -> Picture
dragonAnime = lsystemeAnime dragon (((0, 0), 0), 50, 1, pi/2, "F+-")
-----------------
lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime lsystem config t = interpreteMot config (lsystem !! enieme)
                where enieme = (round t `mod` 8)

-- ### TORTUE VOLANTE ###
-- 12


-- ### Exemples botanistes ###
