## Installation 
    gem install bundler

    bundle install

# Contexte

Nous gerons le systeme de gestion des stocks d'un client. Ce dernier demande une nouvelle feature.  

# Fonctionnement du systeme
- Chaque Item a une valeur `Name` qui le defini
- Chaque Item a une valeur `SellIn` qui indique dans combien de jour un Item doit etre vendu
- Chaque Item a une valeur `Quality` qui indique la qualité de l'item

A la fin de chaque journée la qualité et le compteur `SellIn` sont décrémenté.
  
# Comportements Spécifique
- Une fois la date de vente dépassé la qualité se dégrade 2x plus vite
- L'item `Aged Brie` gagne en qualité avec le temps
- Un item ne peut avoir une qualité supérieur a 50
- `Sulfuras` est un item legendaire, il ne doit jamais etre vendu et sa qualité ne change jamais.
- `Backstage passes` est un item qui gagne en qualité de la meme manière que le `Aged Brie`  10 jours avant le jour du concert la qualité s'incrémente de 2. 5 jours avant le concert le concert la qualité augmente de 3. Mais une fois la date du concert dépassé, la qualité tombe a 0.


# Demande client
- Ajouter les items `Conjured`. Un item `Conjured` voit sa qualité baisser 2x plus vite.
