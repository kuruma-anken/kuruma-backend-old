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
