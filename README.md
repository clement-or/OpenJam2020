# Open Jam 2020 - Alpagames team

## Arborescence du projet

```
.
├── nodes /
│   └── example_node/
│       ├── ExampleNode.tscn
│       └── ExampleNode.gd
├── resources/
│   ├── audio
│   ├── fonts
│   └── sprites
├── scenes
├── scripts
└── singletons
```

* nodes : Nodes qui seront instanciés dans une scène (Player, Enemy, etc.)
* resources : Contenus du jeu (audio, images...)
* scenes : Scènes qui seront dans le jeu (TestScene, Game, Level...)
* scripts : Scripts indépendants
* singletons : Singletons

## Règles de nommage

* PascalCase : Noms de classes, noms de fichiers .tscn et .gd, noms de variables qui référencent une classe (ex : `var Bullet = preload("res://nodes/bullet/Bullet.tscn`)
* snake_case : Noms de fichier, variables, fonctions, signaux

Les noms sont toujours en anglais.
Les signaux sont au passé (ex : enemy_died, player_won)
Les booléens commencent par is_, can_, has_ etc.

Les fonctions "privées" commencent par un _. Une fonction privée est prévue pour être utilisée uniquement à l'intérieur de son script.

## Bonnes pratiques

### Typage statique

Si possible, utiliser le typage statique de Godot pour bénéficier de l'autocomplétion

```
    # Variable de type Vector2
    var ma_variable : Vector2
    
    # Pas besoin, le type est induit par l'assignation
    var mon_autre_variable = Vector2(0,0)
    
    # Cette fonction attend 2 paramètres entier et ne retourne rien
    func une_fonction(x : int, x : int) -> void:
        pass
```

### Signaux

Utiliser un maximum les signaux pour transmettre des infos entre les nodes.

### Assert

Utiliser des `assert()` dans le code, pour vérifier qu'une variable est bien assignée si elle est nécessaire au fonctionnement du node.
`assert` renvoie une erreur si la variable n'est pas assignée, uniquement en mode éditeur.

```
    onready var grid = get_parent()
    
    func _ready():
        assert(grid)    # Renvoie une erreur si grid est null
```

## Documenter le code

Précéder l'entête d'une fonction d'un commentaire expliquant son fonctionnement ainsi que ses paramètres, quand nécessaire

```
    # Demande à la Grid parente si une cellule est libre
    # x : Coordonnée X de la cellule
    # y : Coordonnée Y de la cellule
    func request_cell(x, y):
        pass
    
    # Pas besoin de commentaire ici
    func get_grid_position():
        pass
```
