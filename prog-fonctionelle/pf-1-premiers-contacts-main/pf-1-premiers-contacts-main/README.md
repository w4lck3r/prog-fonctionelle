#   Premiers contacts

Ce dépôt correspond aux deux premières séances de TP de PF.


##  Instructions pour rendre votre travail avec gitlab

Pour permettre à votre chargé de TD de suivre votre travail sur ce projet :

-   *forkez* ce dépôt (bouton _Fork_),
-   dans le dépôt *forké*, ajoutez votre chargé de TD aux membres du
    projet avec l’accès _Developer_,
-   créez un fichier `RAPPORT.md` à la racine du dépôt.

Par ailleurs, vous ferez attention à **ignorer** (ne pas ajouter au
dépôt) tous les fichiers qui ne sont pas des sources Haskell. Utilisez
le fichier `.gitignore` pour éviter les mauvaises manipulations.


##  Contenu de votre `RAPPORT.md`

Votre rapport devra être au format [markdown] et être à la racine du
dépôt.

[markdown]: https://gitlab-etu.fil.univ-lille1.fr/help/user/markdown.md

Il contiendra :

-   vos noms et prénoms,
-   pour chaque sujet de TP, vous ferez une section contenant les
    3 sous-sections suivantes :

    1.  questions traitées : quelles questions vous avez traitées en
        précisant si elles vous ont posé une difficulté et laquelle,
    2.  questions non-traitées : quelles questions vous n’avez pas
        traitées et pourquoi,
    3.  notions : quelles sont les idées importantes à retenir de ce
        TP (notamment ce que vous avez appris en le faisant).


##  Contenu initial du dépôt

Il contient les fichiers suivants :

-   `dragon.hs` est le canevas pour le dessin de la courbe du Dragon,
-   `Setup.hs`, `premiers-contacts.cabal`, `stack.yaml` sont des
    fichiers de configuration pour
    [Cabal](https://www.haskell.org/cabal/) et
    [Stack](https://docs.haskellstack.org/en/stable/README/).

Ces fichiers ne sont réellement utiles que si vous voulez utiliser ces
outils pour installer les bibliothèques nécessaires sur une machine
personnelle.


##  Utilisation de `stack` sur votre machine personnelle.

Cette section n’est pas un substitut à la documentation de l’outil.
Elle vous donne juste une commande qui peut aider à démarrer.

Si vous voulez installer la bibliothèque Gloss nécessaire pour
dessiner la courbe du Dragon en utilisant l’outil `stack` (que vous
devrez avoir installé, bien entendu), vous pourrez utiliser :

```console
stack --install-ghc build
```

Cette commande devrait éventuellement installer GHC, Gloss, et autres
dépendances puis compiler `dragon.hs` en un exécutable créé quelque
part dans le répertoire `.stack-work/install` (le chemin dépend de
votre configuration).
