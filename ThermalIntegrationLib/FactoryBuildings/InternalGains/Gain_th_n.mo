within ThermalIntegrationLib.FactoryBuildings.InternalGains;
model Gain_th_n "Simple model for area related heat gain by heat source"
  extends PartialHeatGainSched;
  parameter Real nominalPower(unit="W") "Max. heat output of the heat source in W";
  parameter Integer n(min=0)=1 "Number of units";
  parameter Modelica.SIunits.Area area "Area to which the heat gain is releated";
equation
  Qth=schedule*nominalPower*n/area;
end Gain_th_n;
