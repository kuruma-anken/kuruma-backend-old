<script lang="ts">
  export let id = "";
  export let value = "";
  export let label: string | undefined;
  export let name: string | undefined;
  export let type = "text";
  export let autoFocus: ((target: any) => void) | null = null;
  let ref: HTMLInputElement;

  const focusEffect = (target: any) => {
    if (autoFocus) autoFocus(target);
  };

  const onInput = (e: any) => {
    value = e.target.value;
  };
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
    use:focusEffect
    on:input={onInput}
  />
</div>
