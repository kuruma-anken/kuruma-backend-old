import { Vehicle } from "../graphql/queries/vehicleQueries";

export const formatVehicleDisplayName = (
  vehicle: Vehicle | null | undefined
) => {
  if (!vehicle) return null;
  return `${vehicle.registration} (${vehicle.manufacturingYear} ${vehicle.carModel.carMaker.name} ${vehicle.carModel.name})`;
};
