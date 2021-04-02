<script lang="typescript">
  import { useNavigate } from "svelte-navigator";
  import Loader from "../components/Loader.svelte";
  import Sidebar from "./Sidebar.svelte";

  import { useAuth } from "../graphql/queries/userQueries";
  const user = useAuth();
  const navigate = useNavigate();
  export let title: string | null = null;

  $: if (!$user.loading && !$user.data?.currentUser) {
    navigate("/login");
  }
</script>

{#if $user.loading}
  <Loader />
{:else if $user.data && $user.data.currentUser}
  <div class="layout">
    <Sidebar />
    <main role="main">
      {#if title}
        <h1 class="title">{title}</h1>
      {/if}
      <slot />
    </main>
  </div>
{/if}
