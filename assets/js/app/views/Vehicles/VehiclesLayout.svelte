<script lang="typescript">
  import Layout from "../../layout/Layout.svelte";
  import { Link } from "svelte-navigator";

  export let contentTitle: string | null = null;
  export let loading = false;
</script>

<Layout title="Vehicles" {contentTitle} {loading}>
  <svelte:fragment slot="sidebar">
    <Link to="/vehicles/new" class="button is-primary is-fullwidth"
      >Create vehicle</Link
    >
  </svelte:fragment>

  <slot />
</Layout>
