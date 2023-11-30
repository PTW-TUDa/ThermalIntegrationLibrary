within ThermalIntegrationLib.BaseClasses.Internals;
partial record PartialSummary "example summary record"
  // example can be also found here: Buildings.ThermalZones.Detailed.Validation.BESTEST.Cases6xx.Case600 using Buildings.ThermalZones.Detailed.Validation.BESTEST.Data.ResultSummary
  Modelica.SIunits.Temperature T_in "Temperature level at input";
  Modelica.SIunits.Temperature T_out "Temperature level at output";
  Modelica.SIunits.HeatFlowRate Q_flow_heating
    "Heat flow rate for heating demand";
  Modelica.SIunits.HeatFlowRate Q_flow_cooling
    "Heat flow rate for cooling demand";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialSummary;
