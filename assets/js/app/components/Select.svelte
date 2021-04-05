<script lang="ts">
  import type { SelectOption } from "../graphql/interfaces/common";

  export let options: SelectOption[] = [];
  export let name: string;
  export let id: string = name;
  export let value: string | number;
  export let label: string;
  const onInput = (e: any) => {
    value = e.target.value;
  };
</script>

<div class="field is-fullwidth">
  <label class="label" for={id}>{label}</label>
  <div class="select is-fullwidth">
    <!-- svelte-ignore a11y-no-onchange -->
    <select class="select" {id} {name} on:change={onInput}>
      <option value="">Please select...</option>
      {#each options as option (option.value)}
        <option value={option.value}>{option.label}</option>
      {/each}
    </select>
  </div>
</div>
