#!/usr/bin/env bash
# Remove os selos (chips) dos tiles da home. Rodar na raiz do repo.
set -e
if [ ! -f _config.yml ]; then echo "ERRO: rode na raiz do repo."; exit 1; fi
cat > '_includes/tiles.html' <<'EOF_TILES'
{% comment %} Tiles da home — ordenados por tile-order {% endcomment %}
{% assign tiles = site.html_pages | where_exp: "item", "item.show_tile != false" | sort: "tile-order" %}
<section id="one" class="tiles">
  {% for tile in tiles limit:site.tiles-count %}
  <article>
    <span class="image">
      <img src="{{ tile.image | relative_url }}" alt="{{ tile.title }}" {% if tile.tile-position %}data-position="{{ tile.tile-position }}"{% endif %} />
    </span>
    <header class="major">
      <h3><a href="{{ tile.url | relative_url }}" class="link">{{ tile.title }}</a></h3>
      <p>{{ tile.description }}</p>
    </header>
  </article>
  {% endfor %}
</section>
EOF_TILES
echo "==> tiles.html atualizado (sem selos)."
echo "Publicar:  git add -A && git commit -m \"ui: remove selos dos tiles\" && git push"
