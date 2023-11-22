within ThermalIntegrationLib.FactoryBuildings.InternalGains;
model Gain_elEq "Simple model for area related heat gain and electrical power consumption by electrical equipment"
  extends PartialHeatGainSched;
  Modelica.Blocks.Interfaces.RealOutput Pel(unit="W/m2") "Electrical power consumed by electrical equipment" annotation (Placement(transformation(extent={{100,30},{138,68}}), iconTransformation(extent={{100,30},{138,68}})));
  parameter Real nominalPower(unit="W/m2") "Installed electrical power of the electrical equipment";
  parameter Modelica.SIunits.Efficiency efficiency "(1-effiency)*power is treated as heat gain";
equation
  Pel=schedule*nominalPower*efficiency;
  Qth=schedule*nominalPower*(1 - efficiency);
end Gain_elEq;
