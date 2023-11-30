within ThermalIntegrationLib.FactoryBuilding.BuildingEnvelope.Records;
record RoofProperties "Basic parameter record for roof elements"
  extends Modelica.Icons.Record;
  parameter SI.Length length "length of the wall";
  parameter SI.Length width "width of the wall";
  parameter SI.CoefficientOfHeatTransfer k "coefficient of heat transfer of the wall";
  parameter SI.ThermalConductance G "thermal conductance of the wall";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end RoofProperties;
