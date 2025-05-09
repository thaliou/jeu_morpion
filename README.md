# Projet Morpion

Ce projet est une implémentation du jeu classique Morpion (Tic-tac-toe) en Ruby, conçu pour être joué par deux joueurs humains dans un terminal. Le code est structuré selon les principes de la programmation orientée objet, avec une séparation claire des responsabilités entre différentes classes.

## Table des matières

- [Présentation](#présentation)
- [Fonctionnalités](#fonctionnalités)
- [Versions disponibles](#versions-disponibles)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Structure du code](#structure-du-code)
- [Contribution](#contribution)

## Présentation

Le Morpion est un jeu de réflexion se pratiquant à deux joueurs, tour par tour, dont le but est d'être le premier à créer un alignement de trois symboles identiques (X ou O) horizontalement, verticalement ou en diagonale sur une grille de 3×3 cases. Cette implémentation permet de jouer directement dans le terminal avec une interface textuelle soignée.

## Fonctionnalités

**Version de base :**
- Interface utilisateur en mode texte pour le terminal
- Gestion des tours alternés entre deux joueurs
- Détection automatique des victoires et des égalités
- Possibilité de jouer plusieurs parties consécutives
- Affichage stylisé du plateau de jeu
- Représentation claire des positions (A1, B2, C3, etc.)

**Version améliorée :**
- Texte coloré pour une meilleure lisibilité grâce à la gem `colorize`
- Système de score pour suivre les victoires de chaque joueur
- Interface utilisateur enrichie avec des couleurs et des éléments graphiques
- Affichage des scores après chaque partie et à la fin de la session
- Distinction visuelle entre les joueurs (X en rouge, O en bleu)

## Versions disponibles

### Version standard (`app.rb`)

La version standard offre toutes les fonctionnalités de base nécessaires pour jouer au Morpion dans le terminal. Le plateau est affiché de manière claire, et le jeu guide les joueurs tout au long de la partie. Les programmes sont contenus dans le répertoire `lib/app`.

### Version améliorée (`app_02.rb`)

La version améliorée enrichit l'expérience de jeu avec des couleurs, des éléments graphiques supplémentaires et un système de score. Elle nécessite l'installation de la gem `colorize`. Les programmes sont contenus dans le répertoire `lib/app` et contiennent le mot `V2`.

## Prérequis

- Ruby (version 2.5.0 ou supérieure recommandée)
- Pour la version améliorée uniquement : gem `colorize`

## Installation

1. Clonez ce dépôt ou téléchargez les fichiers source :

```bash
git clone https://github.com/votre-nom/projet-morpion.git
cd projet-morpion
```

2. Pour la version améliorée, installez la gem colorize :

```bash
gem install colorize
```

3. Rendez le fichier exécutable (pour les systèmes Unix/Linux/Mac) :

```bash
chmod +x morpion.rb
# ou
chmod +x morpion_enhanced.rb
```

## Utilisation

### Version standard

```bash
./app.rb
# ou
ruby app.rb
```

### Version améliorée

```bash
./app_02.rb
# ou
ruby app_02.rb
```

### Comment jouer

1. Lancez le programme.
2. Entrez le nom du premier joueur (qui utilisera les X).
3. Entrez le nom du deuxième joueur (qui utilisera les O).
4. À votre tour, saisissez les coordonnées de la case où vous souhaitez placer votre symbole (par exemple : A1, B2, C3).
5. Le programme alternera automatiquement entre les joueurs jusqu'à ce qu'il y ait un gagnant ou un match nul.
6. À la fin de la partie, choisissez si vous souhaitez jouer une nouvelle partie.

## Structure du code

Le projet est composé de 6 classes principales :

1. **BoardCase** : Représente une case individuelle du plateau de jeu.
2. **Board** : Représente le plateau complet et gère l'état du jeu.
3. **Player** : Représente un joueur avec son nom et son symbole.
4. **Show** : Gère l'affichage du jeu dans le terminal.
5. **Game** : Contrôle la logique du jeu et l'interaction entre les différents composants.
6. **Application** : Classe principale qui exécute le programme et gère la boucle de jeu.

Cette structure modulaire permet une séparation claire des responsabilités et facilite la maintenance et l'extension du code.

## Contribution

Les contributions à ce projet sont les bienvenues ! Voici quelques façons dont vous pourriez améliorer le jeu :

- Ajout d'une option pour jouer contre l'ordinateur
- Implémentation d'une interface graphique (GUI)
- Sauvegarde et chargement des parties
- Statistiques de jeu plus détaillées
- Thèmes visuels personnalisables

Pour contribuer, veuillez soumettre une pull request ou ouvrir une issue pour discuter des changements que vous souhaitez apporter.

## Licence

Ce projet est sous licence MIT. Consultez le fichier [LICENSE](LICENSE) pour plus de détails.

## Auteurs
- [THIAM](https://github.com/thaliou)
- [ASSY](https://github.com/AssyaJalo)
- [SOUARE](https://github.com/bbkouty)
- [FANAR](https://github.com/fanarbandia)
- [MAIGA](https://github.com/Fadelion)

---

Développé dans le cadre d'un projet d'apprentissage de la programmation orientée objet en Ruby.
