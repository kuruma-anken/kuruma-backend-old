<script lang="typescript">
  import { Link, useLocation } from "svelte-navigator";
  const location = useLocation();
  let className: string;
  export let to: string;
  export let title: string;

  $: className =
    $location?.pathname === to
      ? `outer-sidebar__link outer-sidebar__link--active`
      : "outer-sidebar__link";
</script>

<Link {to} class={className} {title}
  ><slot />{#if title}
    <p class="outer-sidebar__link__title">{title}</p>
  {/if}</Link
>
