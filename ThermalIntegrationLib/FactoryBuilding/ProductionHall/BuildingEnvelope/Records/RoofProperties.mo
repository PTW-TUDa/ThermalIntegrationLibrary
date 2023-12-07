within ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope.Records;
record RoofProperties "Basic parameter record for roof elements"
  extends Modelica.Icons.Record;
  parameter SI.Length length "length of the roof";
  parameter SI.Length width "width of the roof";
  parameter SI.CoefficientOfHeatTransfer k "coefficient of heat transfer of the roof";
  parameter SI.ThermalConductance G "thermal conductance of the roof";
  parameter SI.Mass m "mass of roof";
  parameter SI.SpecificHeatCapacity cp "specific heat capacity of roof";
  parameter SI.HeatCapacity C "heat capacity of roof";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end RoofProperties;
