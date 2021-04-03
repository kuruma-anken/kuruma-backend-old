export const uploadWithProgress = (
  url: string,
  file: File,
  progressCallback: (progress: number) => any
) => {
  return new Promise((resolve, reject) => {
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
    xhr.open("PUT", url, true);
    xhr.setRequestHeader(
      "cache-control",
      "public, max-age=31536000, immutable"
    );
    xhr.send(file);
  });
};
