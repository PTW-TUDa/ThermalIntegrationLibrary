within ThermalIntegrationLib.FactoryBuildings.InternalGains;
model Gain_th "Simple model for heat gain by heat source"
  extends PartialHeatGainSched;
  parameter Real nominalPower(unit="W") "Max. heat output of the heat source in W";
equation
  Qth=schedule*nominalPower;
end Gain_th;
