within ThermalIntegrationLib.FactoryBuildings.HeatTransfer.Data.Solids;
record OpaqueGlass =
                 Buildings.HeatTransfer.Data.Solids.Generic (
    k=1.0,
    d=2500,
    c=720) "SafetyGlass"
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
