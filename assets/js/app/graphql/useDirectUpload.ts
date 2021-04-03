import gql from "graphql-tag";
import { mutation } from "svelte-apollo";
import { Writable, writable } from "svelte/store";
import { uploadWithProgress } from "./uploadToS3";
import type { ErrorObject, MutationResult } from "./interfaces/common";

export interface UploadData {
  publicUrl: string;
  uploadUrl: string;
}

export const GENERATE_UPLOAD_URL = gql`
  mutation GeneratePresignedUploadURL($filename: String!, $prefix: String!) {
    generatePresignedUploadUrl(filename: $filename, prefix: $prefix) {
      success
      errors
      data {
        uploadUrl
        publicUrl
      }
    }
  }
`;

export interface GeneratePresignedUploadUrlResponse {
  generatePresignedUploadUrl: MutationResult<UploadData>;
}

export interface GeneratePresignedUploadURLVariables {
  filename: string;
  prefix: string;
}

export interface UploadCallbackResult {
  success: boolean;
  errors?: ErrorObject;
  publicUrl: string | null;
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
    GeneratePresignedUploadUrlResponse,
    GeneratePresignedUploadURLVariables
  >(GENERATE_UPLOAD_URL);

  const upload = async (file: File) => {
    const source = file.name;
    progress.set(undefined);
    const { data } = await mutate({ variables: { prefix, filename: source } });
    const publicUrl = data?.generatePresignedUploadUrl?.data?.publicUrl;
    const uploadUrl = data?.generatePresignedUploadUrl?.data?.uploadUrl;
    if (!uploadUrl) {
      progress.set(null);
      return {
        success: false,
        publicURL: null
      };
    }
    try {
      await uploadWithProgress(uploadUrl, file, progress.set);
      progress.set(null);
      return {
        success: true,
        publicURL: publicUrl as string
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
