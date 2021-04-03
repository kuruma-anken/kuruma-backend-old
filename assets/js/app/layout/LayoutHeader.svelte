<script lang="typescript">
  import { onDestroy, onMount } from "svelte";
  import clsx from "clsx";
  import { useLocation, useNavigate } from "svelte-navigator";

  import { Search } from "../icons/lib";

  let input: HTMLInputElement;
  export let searchPlaceholder: string | undefined;
  let hasFocus = false;

  const location = useLocation();
  const navigate = useNavigate();

  const search = (term: string) => {
    const pathname = $location.pathname;
    const search = term && new URLSearchParams({ q: term }).toString();
    const newPath = `${pathname}${search ? "?" : ""}${search}`;
    navigate(newPath);
  };

  const handleKey = (ev: KeyboardEvent) => {
    const focused = document.querySelector(
      "input:focus, textarea:focus, select:focus"
    );
    if (!focused && ev.key === "/") {
      ev.preventDefault();
      input.focus();
      hasFocus = true;
      if (input.value) input.select();
    }
  };

  const onKeyDown = (ev: KeyboardEvent) => {
    if (ev.key === "Escape") {
      input.blur();
    }
  };

  const onSubmit = () => {
    search(input.value);
    input.focus();
  };

  const onBlur = () => {
    hasFocus = false;
  };

  onMount(() => {
    document.addEventListener("keydown", handleKey);
  });

  onDestroy(() => {
    document.removeEventListener("keydown", handleKey);
  });
</script>

<header class="layout-header">
  <form
    class={clsx("layout-header__search", {
      "layout-header__search--focused": hasFocus
    })}
    on:submit|preventDefault={onSubmit}
  >
    <Search />
    <input
      name="q"
      type="text"
      class="layout-header__search__input"
      bind:this={input}
      on:blur={onBlur}
      on:keydown={onKeyDown}
      placeholder={searchPlaceholder || "Search vehicles..."}
    />
  </form>
</header>
