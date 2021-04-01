<script>
  import { useNavigate } from "svelte-navigator";
  import Loader from "../components/Loader.svelte";

  import { useAuth } from "../graphql/queries/userQueries";
  const user = useAuth();
  const navigate = useNavigate();

  $: if (!$user.loading && !$user.data?.currentUser) {
    navigate("/login");
  }
</script>

{#if $user.loading}
  <Loader />
{:else if $user.data && $user.data.currentUser}
  <div class="layout">
    <aside class="sidebar">Sidebar</aside>
    <main><slot /></main>
  </div>
{/if}
