<script lang="typescript">
  import { Link, useLocation } from "svelte-navigator";
  import clsx from "clsx";
  const location = useLocation();
  export let to: string;
  export let title: string;

  const isActive =
    to === "/" ? $location.pathname === to : $location.pathname.startsWith(to);
</script>

<Link
  {to}
  class={clsx("outer-sidebar__link", {
    "outer-sidebar__link--active": isActive
  })}
  {title}
  ><slot />{#if title}
    <p class="outer-sidebar__link__title">{title}</p>
  {/if}</Link
>
