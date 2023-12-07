within ThermalIntegrationLib.FactoryBuilding.BuildingElements.Records;
record FloorProperties "Basic parameter record for floor elements"
  extends Modelica.Icons.Record;
  parameter SI.Length length "length of the floor";
  parameter SI.Length width "width of the floor";
  parameter SI.CoefficientOfHeatTransfer k "coefficient of heat transfer of the floor";
  parameter SI.ThermalConductance G "thermal conductance of the floor";
  parameter SI.Mass m "mass of floor";
  parameter SI.SpecificHeatCapacity cp "specific heat capacity of floor";
  parameter SI.HeatCapacity C "heat capacity of floor";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end FloorProperties;
