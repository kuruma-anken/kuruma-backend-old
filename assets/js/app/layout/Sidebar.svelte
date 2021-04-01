<script>
  import SidebarLink from "./SidebarLink.svelte";
  import { useSignOutMutation } from "../graphql/queries/userQueries";
  const signOut = useSignOutMutation();
</script>

<aside class="sidebar">
  <h1 class="title is-3 has-text-centered">Kuruma</h1>

  <div class="sidebar-menu">
    <SidebarLink to="/">Dashboard</SidebarLink>
    <SidebarLink to="/vehicles">Vehicles</SidebarLink>
    <SidebarLink to="/clients">Clients</SidebarLink>
    <SidebarLink to="/employees">Employees</SidebarLink>
  </div>

  <button class="sidebar-sign-out" type="button" on:click={signOut}
    >Sign out</button
  >
</aside>
