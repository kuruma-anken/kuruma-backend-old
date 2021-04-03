<script lang="typescript">
  import { Upload } from "../icons/lib";
  export let label: string = "Choose a file...";
  export let onChange: ((e: any) => any) | undefined = undefined;
</script>

<div class="file">
  <label class="file-label">
    <input class="file-input" type="file" name="resume" on:change={onChange} />
    <span class="file-cta">
      <span class="file-icon">
        <Upload />
      </span>
      <span class="file-label">
        {label}
      </span>
    </span>
  </label>
</div>
