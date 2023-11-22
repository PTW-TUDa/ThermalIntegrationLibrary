within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record EnclosureFloorValidation =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.OSB(x=0.012),HeatTransfer.Data.Solids.BuildingProtectionSheet(x=0.006),HeatTransfer.Data.Solids.VacuumInsulation(x=0.02),HeatTransfer.Data.Solids.BuildingProtectionSheet(x=0.006),HeatTransfer.Data.Solids.DUCON(x=0.05)}, final nLay=5) "Construction with 2 cm vacuum insulation and 5cm DUCON"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
