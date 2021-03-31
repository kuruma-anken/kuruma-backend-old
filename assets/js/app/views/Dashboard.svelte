<script>
  import { Link } from "svelte-navigator";
  import Layout from "../layout/Layout.svelte";
  import { HELLO_WORLD_QUERY } from "../graphql/queries/userQueries";
  import { query } from "svelte-apollo";

  const data = query(HELLO_WORLD_QUERY);
</script>

<Layout>
  <h1>Dashboard</h1>

  <p>
    <Link to="/login">Login</Link>
  </p>

  {#if $data.loading}
    Loading...
  {:else if $data.error}
    Error
  {:else}
    {$data.data.hello}
  {/if}
</Layout>
