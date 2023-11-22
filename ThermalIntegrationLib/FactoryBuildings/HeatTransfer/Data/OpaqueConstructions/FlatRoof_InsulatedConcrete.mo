within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.OpaqueConstructions;
record FlatRoof_InsulatedConcrete =
                      Buildings.HeatTransfer.Data.OpaqueConstructions.Generic (material={HeatTransfer.Data.Solids.Bitumen(x=0.015),HeatTransfer.Data.Solids.PIR_023(x=0.12),
        HeatTransfer.Data.Solids.ConcreteReinf2pc(x=0.2)}, final nLay=3) "Construction with 15 mm bitumen, 120 mm PIR 023, 200 mm reinforced concrete"
                                                                                    annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datOpaCon");
