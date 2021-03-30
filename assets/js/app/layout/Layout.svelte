<script>
  import { onMount } from "svelte";

  onMount(() => {
    console.log("Mounted");
  });
</script>

<div class="layout">
  <aside class="sidebar">Sidebar</aside>
  <main><slot /></main>
</div>
