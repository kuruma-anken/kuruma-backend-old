<script>
  import { onMount, tick } from "svelte";
  export let id = "";
  export let value = "";
  export let label;
  export let name;
  export let type = "text";
  export let autofocus = false;

  let ref;

  const onInput = (e) => {
    value = e.target.value;
  };

  onMount(() => {
    if (autofocus) ref.focus();
  });
</script>

<div class="field">
  {#if label}<label class="label" for={id || name}>{label}</label>{/if}
  <input
    autofocus={autofocus ? "true" : undefined}
    id={id || name}
    {name}
    {value}
    {type}
    bind:this={ref}
    class="input"
    on:input={onInput}
  />
</div>
