Allocine
---------

Parseur d'[Allocine][6] pour récupérer des informations sur les films et séries.

## Installation

Dépendances:

  (sudo) gem install activesupport vegas sinatra
  
Dépendances optionelles (mais recommandées, nécéssite `curl`)

  (sudo) gem install curb zlib

Via RubyGems:

  (sudo) gem install allocine

Ou via git:

  git clone git://github.com/webs/allocine.git

## Utilisation

### Recherche

Les recherches s’effectuent avec `Allocine.find_movie` et `Allocine.find_show`, et renvoie un Hash de l’ID Allocine et du titre exact.

### Récupérer les informations d'un film

`Allocine::Movie.new(ID)`

### Récupérer les informations d'une série

`Allocine::Show.new(ID)`

Voir la [documentation complète][3].

## Frontend web

Une petite application Sinatra est fournie. Pour la démarrer, 

- [Homepage][1]
- [Source Code][2]
- [Documentation][3]
- [Issues][4]
- [Try it live!][5]

Mis a disposition sous licence MIT. (c) 2008 [Jordan Bracco][7], [Florian Lamache][8], [Sunny Ripert][9].

[1]: http://webs.github.com/allocine
[2]: http://github.com/webs/allocine
[3]: http://yardoc.org/docs/webs-allocine
[4]: http://github.com/webs/allocine/issues
[5]: http://allocine.heroku.com
[6]: http://allocine.fr
[7]: http://github.com/webs
[8]: http://github.com/florian95
[9]: http://github.com/sunny