<script lang="typescript">
  import { onMount } from "svelte";
  import { useUploadVehicleAttachment } from "../graphql/apiUploader";
  import { ID } from "../graphql/interfaces/common";
  import PieLoader from "./PieLoader.svelte";
  export let file: File;
  export let onDone: () => void;
  export let vehicleId: ID;
  let dataUrl: string | null = null;

  const { upload, progress } = useUploadVehicleAttachment();

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
      const promise = upload(vehicleId, file);
      if (file.type.match("image/")) {
        dataUrl = await toDataURL(file);
      }
      const res = await promise;
      onDone();
      console.log(res);
    }
  });
</script>

<div class="uploader-thumbnail card">
  {#if dataUrl}
    <img src={dataUrl} class="preview" alt="" />
  {/if}
  <PieLoader progress={$progress} size={90} />
</div>
