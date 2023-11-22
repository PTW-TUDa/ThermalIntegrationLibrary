within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record ExtrudedPolystyrene =
    Buildings.HeatTransfer.Data.Solids.Generic (
    k=0.035,
    d=28,
    c=129.2) "XPS (k=0.035)"
  annotation (
    defaultComponentPrefixes="parameter",
    defaultComponentName="datSol");
