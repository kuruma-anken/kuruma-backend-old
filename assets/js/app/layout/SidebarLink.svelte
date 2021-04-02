<script lang="typescript">
  import { Link, useLocation } from "svelte-navigator";
  const location = useLocation();
  export let to: string;
  let className: string;

  $: className =
    $location?.pathname === to ? `sidebar-link is-active` : "sidebar-link";
</script>

<Link class={className} {to}>
  <slot />
</Link>
