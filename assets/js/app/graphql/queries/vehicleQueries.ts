import gql from "graphql-tag";
import { query } from "svelte-apollo";
import { ID, Page } from "../interfaces/common";

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
