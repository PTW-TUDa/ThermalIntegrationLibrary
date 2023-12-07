within ThermalIntegrationLib.BaseClasses.Internals;
partial record PartialSummary "example summary record"
  extends Modelica.Icons.Record;
  // example can be also found here: Buildings.ThermalZones.Detailed.Validation.BESTEST.Cases6xx.Case600 using Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.ResultSummary
  Modelica.Units.SI.Temperature T_in "Temperature level at input";
  Modelica.Units.SI.Temperature T_out "Temperature level at output";
  Modelica.Units.SI.HeatFlowRate Q_flow_heating "Heat flow rate for heating demand";
  Modelica.Units.SI.HeatFlowRate Q_flow_cooling "Heat flow rate for cooling demand";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialSummary;
