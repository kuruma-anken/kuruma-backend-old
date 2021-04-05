export type ID = number | string;

export interface PageInfo {
  totalPages: number;
  totalEntries: number;
  pageSize: number;
  page: number;
}

export interface Page<T> {
  data: ReadonlyArray<T>;
  pageInfo: PageInfo;
}

export type ErrorObject = Record<string, string>;

export interface MutationResult<T> {
  success: boolean;
  errors?: ErrorObject;
  data?: T;
}

export interface SelectOption {
  label: string;
  value: string | number;
}
