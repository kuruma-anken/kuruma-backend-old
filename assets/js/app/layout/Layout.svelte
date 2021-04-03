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
  export let searchPlaceholder: string | undefined = undefined;

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
        <slot />
      </main>
    </div>
  </div>
{/if}
