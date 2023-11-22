within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record Ducon_VacuumInsulated =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.VacuumInsulation(x=0.02),HeatTransfer.Data.Solids.DUCON(x=0.025,nSta=5),HeatTransfer.Data.Solids.DUCON(x=0.025,nSta=5)}, final nLay=3) "Construction with 2 cm vacuum insulation and 5cm DUCON parted in two for use of capillary tube mats"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
