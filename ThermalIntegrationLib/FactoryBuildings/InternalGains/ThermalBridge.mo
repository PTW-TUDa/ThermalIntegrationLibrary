within ThermalIntegrationLib.FactoryBuildings.InternalGains;
model ThermalBridge "Simple model for area related heat gain by thermal bridge"
  extends PartialHeatGain;
  parameter Real nominalPower(unit="W/(m2.K)")=0.03 "Heat output by thermal bridge related to envelope area";
  parameter Modelica.SIunits.Area floorArea;
  parameter Modelica.SIunits.Area envelopeArea;
  Modelica.Blocks.Interfaces.RealInput Toutside(unit="K",displayUnit="degC") "Outside temperature" annotation (Placement(transformation(extent={{-140,39},{-100,79}}),
                                                                                                                                                     iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={59,101})));
  Modelica.Blocks.Interfaces.RealInput Tinside(unit="K",displayUnit="degC") "Inside temperature" annotation (Placement(transformation(extent={{-140,-79},{-100,-39}}),
                                                                                                                                                     iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-59,101})));
equation
  Qth = (Toutside-Tinside)*nominalPower*envelopeArea/floorArea; // Positive for heat flow from outside to inside related to floor area
end ThermalBridge;
