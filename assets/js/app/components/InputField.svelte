<script lang="ts">
  import { onMount } from "svelte";
  export let id = "";
  export let value = "";
  export let label: string | undefined;
  export let name: string | undefined;
  export let type = "text";
  export let autofocus = false;
  let ref: HTMLInputElement;

  const onInput = (e: any) => {
    value = e.target.value;
  };

  onMount(() => {
    if (autofocus)
      setTimeout(() => {
        ref.focus();
      }, 0);
  });
</script>

<div class="field">
  {#if label}<label class="label" for={id || name}>{label}</label>{/if}
  <input
    id={id || name}
    {name}
    {value}
    {type}
    bind:this={ref}
    class="input"
    on:input={onInput}
  />
</div>
