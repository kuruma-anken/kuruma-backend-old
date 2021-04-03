<script lang="typescript">
  import { useNavigate } from "svelte-navigator";
  import Loader from "../components/Loader.svelte";
  import OuterSidebar from "./OuterSidebar.svelte";
  import Sidebar from "./Sidebar.svelte";

  import { useAuth } from "../graphql/queries/userQueries";
  import LayoutHeader from "./LayoutHeader.svelte";
  const user = useAuth();
  const navigate = useNavigate();
  export let title: string | null = null;
  export let contentTitle: string | null = null;
  export let searchPlaceholder: string | undefined = undefined;
  export let loading = false;

  $: if (!$user.loading && !$user.data?.currentUser) {
    navigate("/login");
  }
</script>

{#if $user.loading}
  <Loader />
{:else if $user.data && $user.data.currentUser}
  <div class="layout">
    <OuterSidebar />
    <Sidebar {title} />
    <div class="layout__right">
      <LayoutHeader {searchPlaceholder} />
      <main role="main" class="main">
        {#if loading}
          <Loader />
        {:else}
          {#if contentTitle}
            <h1 class="title">{contentTitle}</h1>
          {/if}
          <slot />
        {/if}
      </main>
    </div>
  </div>
{/if}
