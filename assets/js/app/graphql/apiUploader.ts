import { ID } from "./interfaces/common";
import { writable } from "svelte/store";

const resolveAttachmentType = (file: File) => {
  if (file.type.match("image/")) return "image";
  return "document";
};

const apiUpload = async (
  vehicleId: number | string,
  file: File,
  progressCallback: (progress: number) => any
) => {
  return new Promise((resolve, reject) => {
    const body = new FormData();
    body.append("attachment", file);
    body.append("vehicle_id", String(vehicleId));
    body.append("attachment_type", resolveAttachmentType(file));
    const xhr = new XMLHttpRequest();

    xhr.upload.addEventListener("progress", function (ev) {
      if (ev.lengthComputable) {
        progressCallback(ev.loaded / ev.total);
      }
    });
    xhr.addEventListener("load", function () {
      resolve(xhr.response);
    });
    xhr.addEventListener("error", function (err) {
      reject(err);
    });
    // TODO: use a constant
    xhr.open("POST", "/api/vehicles/uploads", true);
    xhr.send(body);
  });
};

export const useUploadVehicleAttachment = () => {
  const progress = writable<number | undefined | null>(null);
  const upload = async (vehicleId: ID, file: File) => {
    const res = await apiUpload(vehicleId, file, progress.set);
    return res;
  };
  return {
    upload,
    progress
  };
};
