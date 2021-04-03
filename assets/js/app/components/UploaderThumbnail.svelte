<script lang="typescript">
  import { onMount } from "svelte";
  import useDirectUpload from "../graphql/useDirectUpload";
  import PieLoader from "./PieLoader.svelte";
  export let file: File;
  export let prefix: string;
  export let onDone: () => void;
  let dataUrl: string | null = null;

  const { upload, progress } = useDirectUpload(prefix);

  const toDataURL = (file: File): Promise<string> => {
    return new Promise((resolve) => {
      const reader = new FileReader();
      reader.addEventListener("load", function () {
        if (typeof this.result === "string") resolve(this.result);
      });
      reader.readAsDataURL(file);
    });
  };

  onMount(async () => {
    if (file) {
      const promise = upload(file);
      if (file.type.match("image/")) {
        dataUrl = await toDataURL(file);
      }
      const { publicUrl } = await promise;
      onDone();
      console.log(publicUrl);
    }
  });
</script>

<div class="uploader-thumbnail card">
  {#if dataUrl}
    <img src={dataUrl} class="preview" alt="" />
  {/if}
  <PieLoader progress={$progress} size={90} />
</div>
