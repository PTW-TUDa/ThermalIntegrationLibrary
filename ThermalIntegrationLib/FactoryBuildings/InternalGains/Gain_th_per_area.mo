within ThermalIntegrationLib.FactoryBuildings.InternalGains;
model Gain_th_per_area "Simple model for area related heat gain by heat source"
  extends PartialHeatGainSched;
  parameter Real nominalPower "Max. heat output of the heat source in W/m2";
equation
  Qth=schedule*nominalPower;
end Gain_th_per_area;
