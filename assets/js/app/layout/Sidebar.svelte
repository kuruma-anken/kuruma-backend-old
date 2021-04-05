<script lang="typescript">
  export let title: string | null;
</script>

<aside class="sidebar">
  <header class="sidebar__header">
    <h1 class="sidebar__header__title">{title}</h1>
  </header>
  <div class="sidebar__content">
    <slot />
  </div>
</aside>
