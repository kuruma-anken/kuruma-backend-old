<script>
  import SidebarLink from "./SidebarLink.svelte";
  import { useSignOutMutation } from "../graphql/queries/userQueries";
  const signOut = useSignOutMutation();

  import {
    Car,
    UserCog,
    UserTie,
    DoorClosed,
    Dashboard
  } from "../icons/lib/index";
</script>

<aside class="sidebar">
  <h1 class="title is-3 has-text-centered">Kuruma</h1>

  <div class="sidebar-menu">
    <SidebarLink to="/"><Dashboard />Dashboard</SidebarLink>
    <SidebarLink to="/vehicles"><Car />Vehicles</SidebarLink>
    <SidebarLink to="/clients"><UserTie />Clients</SidebarLink>
    <SidebarLink to="/employees"><UserCog />Employees</SidebarLink>
  </div>

  <button class="sidebar-sign-out" type="button" on:click={signOut}
    ><DoorClosed />Sign out</button
  >
</aside>
