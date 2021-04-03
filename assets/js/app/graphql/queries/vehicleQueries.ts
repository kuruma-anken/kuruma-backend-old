import gql from "graphql-tag";
import { mutation, query } from "svelte-apollo";
import { ID, MutationResult, Page } from "../interfaces/common";

export const PAGINATE_VEHICLES_QUERY = gql`
  query PaginateVehicles($page: Int = 1) {
    result: paginateVehicles(page: $page) {
      pageInfo {
        totalPages
        totalEntries
        pageSize
        page
      }
      data {
        id
        carModel {
          id
          name
          carMaker {
            id
            name
          }
        }
        manufacturingYear
        registration
      }
    }
  }
`;

export interface Vehicle {
  id: ID;
  carModelId: ID;
  carModel: CarModel;
  manufacturingYear: number;
  registration: string;
  attachments: VehicleAttachment[];
  insertedAt: string;
  updatedAt: string;
}

export enum VehicleAttachmentType {
  Image = "IMAGE",
  Document = "DOCUMENT"
}

export interface VehicleAttachment {
  id: ID;
  url: string;
  publicUrl: string;
  attachmentType: VehicleAttachmentType;
  insertedAt: string;
  updatedAt: string;
}

export interface CarModel {
  id: ID;
  name: string;
  carMaker: CarMaker;
}

export interface CarMaker {
  id: ID;
  name: string;
}

export interface PaginateVehiclesQueryVariables {
  page?: number;
}

export interface PaginateVehiclesQueryResult {
  result: Page<Vehicle>;
}

export const usePaginateVehiclesQuery = (
  variables: PaginateVehiclesQueryVariables
) =>
  query<PaginateVehiclesQueryResult, PaginateVehiclesQueryVariables>(
    PAGINATE_VEHICLES_QUERY,
    { variables }
  );

export const GET_VEHICLE_QUERY = gql`
  query GetVehicle($id: ID!) {
    vehicle: getVehicle(id: $id) {
      id
      carModel {
        id
        name
        carMaker {
          id
          name
        }
      }
      registration
      manufacturingYear
      attachments {
        id
        publicUrl
        attachmentType
      }
    }
  }
`;

export interface GetVehicleQueryResult {
  vehicle: Vehicle | null;
}

export interface GetVehicleQueryVariables {
  id: ID;
}

export const useGetVehicleQuery = (id: ID) =>
  query<GetVehicleQueryResult, GetVehicleQueryVariables>(GET_VEHICLE_QUERY, {
    variables: { id }
  });

export const CREATE_VEHICLE_ATTACHMENT_MUTATION = gql`
  mutation CreateVehicleAttachment($input: VehicleAttachmentInput) {
    result: createVehicleAttachment(input: $input) {
      success
      errors
      data {
        id
        publicUrl
      }
    }
  }
`;

export interface CreateVehicleAttachmentResult {
  result: MutationResult<VehicleAttachment>;
}

export interface CreateVehicleAttachmentVariables {
  input: VehicleAttachmentInput;
}

export interface VehicleAttachmentInput {
  vehicleId: ID;
  url: string;
}

export const useCreateVehicleAttachmentMutation = () =>
  mutation<CreateVehicleAttachmentResult, CreateVehicleAttachmentVariables>(
    CREATE_VEHICLE_ATTACHMENT_MUTATION
  );
