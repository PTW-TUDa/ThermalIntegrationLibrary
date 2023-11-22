within ThermalIntegrationLib.FactoryBuildings.InternalGains;
partial model PartialHeatGain
  Modelica.Blocks.Interfaces.RealOutput Qth_rad(unit="W/m2") "Radiative heat gain from heat source" annotation (Placement(transformation(extent={{100,-88},{136,-52}}), iconTransformation(extent={{100,-88},{136,-52}})));
  Modelica.Blocks.Interfaces.RealOutput Qth_conv(unit="W/m2") "Convective heat gain from heat source" annotation (Placement(transformation(extent={{100,-48},{136,-12}}), iconTransformation(extent={{100,-48},{136,-12}})));
  parameter Real shareRad "Radiative share of heat gain (else: convection)";
  Real Qth(unit="W/m2") "Total heat gain per area by heat source";
equation
  Qth_rad = Qth*shareRad;
  Qth_conv = Qth*(1-shareRad);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true)), Diagram(coordinateSystem(preserveAspectRatio=true)));
end PartialHeatGain;
