## Projet mobile Cinephoria

Cette application permet à l'utilisateur de se connecter s'il a préalablement créé un compte sur le site web. Elle lui permet de consulter ses réservations et de générer un QR code afin d'accéder à la projection du film réservé.
Ce QR Code lors du scan, affiche la séance commandée ainsi que le nombre de personnes.



POUR TELECHARGER LE PROJET 
## Télécharger Flutter SDK
https://docs.flutter.dev/get-started/install

## Ajouter Flutter à votre PATH

## Exécutez flutter doctor dans le terminal pour vérifier que Flutter est correctement installé et pour voir s'il manque des outils.

## ---------
## Installer Xcode (pour iOS)
xcode-select --install

## OU 

## Installer Android Studio (pour Android)
Téléchargez et installez Android Studio depuis le site officiel.
Installez le SDK Android et les outils de ligne de commande pendant l'installation.
Configurez un émulateur Android dans AVD Manager.
## -----

## Installer Visual Studio (pour le développement Windows Desktop)

## Pour utiliser la version la plus récente de CocoaPods, vous devez mettre à jour Ruby à une version compatible (Ruby 2.7.0 ou ultérieure). Voici comment procéder :

1. Installer rbenv ou RVM pour Gérer les Versions de Ruby

brew install rbenv
brew install ruby-build

rbenv init

rbenv install 2.7.0

## Install CocoaPods
sudo gem install cocoapods

## pour l'update 
sudo gem update cocoapods

## Navigate to your Flutter project’s ios directory, Install Pods for Your Flutter Project

cd path/to/your/flutter/project/ios
pod install

## Nettoyer le projet flutter

flutter clean

## Mettre à jour les dépendances 
flutter pub get


## Ouvrir le projet iOS/macOS dans Xcode
open macos/Runner.xcworkspace

## tips : clean build folder : Shift + Command + K sur Xcode.