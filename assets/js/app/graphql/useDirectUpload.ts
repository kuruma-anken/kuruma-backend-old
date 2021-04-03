import gql from "graphql-tag";
import { mutation } from "svelte-apollo";
import { Writable, writable } from "svelte/store";
import { uploadWithProgress } from "./uploadToS3";
import type { ErrorObject, MutationResult } from "./interfaces/common";

export interface UploadData {
  publicURL: string;
  uploadURL: string;
}

export const GENERATE_UPLOAD_URL = gql`
  mutation GeneratePresignedUploadURL($source: String!, $prefix: String!) {
    generatePresignedUploadURL(source: $source, prefix: $prefix) {
      success
      errors
      data {
        uploadURL
        publicURL
      }
    }
  }
`;

export interface GeneratePresignedUploadURLResponse {
  generatePresignedUploadURL: MutationResult<UploadData>;
}

export interface GeneratePresignedUploadURLVariables {
  source?: string;
  prefix?: string;
}

export interface UploadCallbackResult {
  success: boolean;
  errors?: ErrorObject;
  publicURL: string | null;
}

export interface UseDirectUploadHookObject {
  upload(file: File): Promise<UploadCallbackResult>;
  progress: Writable<number | undefined | null>;
}

export default function useDirectUpload(
  prefix: string
): UseDirectUploadHookObject {
  const progress = writable<number | undefined | null>(null);
  const mutate = mutation<
    GeneratePresignedUploadURLResponse,
    GeneratePresignedUploadURLVariables
  >(GENERATE_UPLOAD_URL);

  const upload = async (file: File) => {
    const source = file.name;
    progress.set(undefined);
    const { data } = await mutate({ variables: { prefix, source } });
    const publicURL = data?.generatePresignedUploadURL?.data?.publicURL;
    const uploadURL = data?.generatePresignedUploadURL?.data?.uploadURL;
    if (!uploadURL) {
      progress.set(null);
      return {
        success: false,
        publicURL: null
      };
    }
    try {
      await uploadWithProgress(uploadURL, file, progress.set);
      progress.set(null);
      return {
        success: true,
        publicURL: publicURL as string
      };
    } catch (e) {
      return {
        success: false,
        errors: {
          message: e.message
        },
        publicURL: null
      };
    }
  };

  return {
    upload,
    progress
  };
}
