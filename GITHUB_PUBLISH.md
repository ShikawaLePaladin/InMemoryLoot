# Guide de Publication GitHub

## Prérequis
- Compte GitHub
- Git configuré avec vos credentials

## Étapes de Publication

### 1. Créer le Repository sur GitHub

1. Allez sur [github.com](https://github.com)
2. Cliquez sur "New repository" (bouton vert)
3. Remplissez:
   - **Repository name**: `InMemoryLoot`
   - **Description**: "SR (Suicide Roll) and Loot Management System for World of Warcraft - InMemory Guild"
   - **Public**: ✅ (pour que les membres puissent télécharger)
   - **Initialize**: ❌ Ne PAS initialiser (on a déjà le code)
4. Cliquez "Create repository"

### 2. Pousser le Code

```bash
cd /root/InMemoryLoot

# Configurer Git (si pas déjà fait)
git config user.name "InMemory Guild"
git config user.email "admin@inmemory.cloud"

# Ajouter le remote GitHub (remplacer YOUR_USERNAME)
git remote add origin https://github.com/YOUR_USERNAME/InMemoryLoot.git

# Pousser le code
git branch -M main
git push -u origin main
```

### 3. Créer la Release v1.0.0

1. Sur GitHub, allez dans votre repo
2. Cliquez sur "Releases" (colonne de droite)
3. Cliquez "Create a new release"
4. Remplissez:
   - **Tag version**: `v1.0.0`
   - **Release title**: `InMemoryLoot v1.0.0 - Initial Release`
   - **Description**: Copiez le contenu de CHANGELOG.md
5. **Upload asset**: Uploadez `/root/InMemoryLoot-v1.0.0.zip`
6. Cliquez "Publish release"

### 4. Configuration GitHub

#### Topics (tags)
Ajoutez ces topics pour améliorer la découvrabilité:
- `wow-addon`
- `world-of-warcraft`
- `vanilla-wow`
- `turtle-wow`
- `loot-management`
- `suicide-roll`
- `guild-management`
- `lua`

#### About Section
```
🎯 SR and Loot Management for WoW Vanilla | InMemory Guild
Website: https://inmemory.cloud
```

#### GitHub Pages (optionnel)
Pour héberger la documentation:
1. Settings → Pages
2. Source: Deploy from branch `main`
3. Folder: `/ (root)`
4. Save
5. Votre README sera accessible via: `https://YOUR_USERNAME.github.io/InMemoryLoot/`

### 5. Ajouter le Badge

Dans README.md, remplacez le lien du badge version par le vrai:
```markdown
[![Version](https://img.shields.io/github/v/release/YOUR_USERNAME/InMemoryLoot)](https://github.com/YOUR_USERNAME/InMemoryLoot/releases)
```

### 6. Communication aux Membres

#### Discord Announcement
```
🎉 **Nouveau: InMemoryLoot AddOn disponible!**

Gérez vos SR directement in-game avec notre nouvel addon!

📥 **Télécharger**: https://github.com/YOUR_USERNAME/InMemoryLoot/releases/latest
📖 **Documentation**: https://github.com/YOUR_USERNAME/InMemoryLoot

**Features**:
✅ Import des SR depuis le site
✅ Interface colorée et intuitive
✅ Assignation de loot en 1 clic
✅ Export automatique des résultats
✅ Historique complet

**Installation**: Téléchargez le ZIP, extrayez dans `Interface/AddOns/`, et tapez `/iml` in-game!

Questions? MP Natolie in-game ou demandez sur Discord 💬
```

#### Message In-Game
```
/guild Nouveau système SR disponible! Téléchargez l'addon InMemoryLoot sur notre GitHub. Plus d'infos sur inmemory.cloud/events
```

### 7. Intégration Site Web

Sur `inmemory.cloud`, ajoutez un lien:

```html
<!-- Sur la page Events -->
<div class="addon-download">
  <h3>🎮 WoW AddOn</h3>
  <p>Téléchargez InMemoryLoot pour gérer vos SR in-game</p>
  <a href="https://github.com/YOUR_USERNAME/InMemoryLoot" class="btn btn-primary">
    Télécharger l'AddOn
  </a>
</div>
```

### 8. Instructions pour les Joueurs

**Message simplifié pour les raiders**:

```
📥 INSTALLATION RAPIDE

1. Télécharge: github.com/YOUR_USERNAME/InMemoryLoot/releases
2. Extrais le ZIP
3. Copie le dossier dans: World of Warcraft\Interface\AddOns\
4. In-game: /iml

UTILISATION:
- /iml import → Colle les données de l'event
- /iml → Voir les SR
- /iml export → Après le raid, copie les résultats

Support: Chuchote Natolie in-game
```

## Maintenance Future

### Pour mettre à jour l'addon:

```bash
cd /root/InMemoryLoot

# Faire vos modifications
vim Core/Constants.lua  # par exemple

# Mettre à jour la version
vim InMemoryLoot.toc    # Version: 1.1.0
vim CHANGELOG.md        # Ajouter entrée [1.1.0]

# Commit
git add .
git commit -m "Version 1.1.0 - Description des changements"
git tag v1.1.0
git push origin main --tags

# Créer nouveau ZIP
cd /root
zip -r InMemoryLoot-v1.1.0.zip InMemoryLoot -x "*.git*"

# Publier release sur GitHub
```

### Gestion des Issues

Quand quelqu'un reporte un bug sur GitHub:
1. Reproduisez le problème
2. Fixez dans le code
3. Testez in-game
4. Commitez avec message clair
5. Référencez l'issue: `Fixes #42`
6. Créez nouvelle release si nécessaire

## Checklist Avant Publication

- [ ] Tous les fichiers committés
- [ ] README complet et clair
- [ ] INSTALL.md vérifié
- [ ] CHANGELOG à jour
- [ ] Version dans .toc correcte
- [ ] ZIP créé et testé
- [ ] Pas de données sensibles dans le code
- [ ] License MIT présente
- [ ] Examples fournis

## Support

Pour questions sur GitHub:
- Configuration: `git config --list`
- Remote: `git remote -v`
- Branches: `git branch -a`
- Status: `git status`

Bon lancement! 🚀
