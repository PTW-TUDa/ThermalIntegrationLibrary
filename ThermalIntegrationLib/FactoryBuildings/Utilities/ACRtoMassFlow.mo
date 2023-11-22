within ThermalIntegrationLib.FactoryBuildings.Utilities;
model ACRtoMassFlow "Calculates infiltration mass flow rate"
  parameter Modelica.SIunits.Volume volume "Volume of the infiltrated room";
  parameter Boolean inputACR=false "True if air change rate is defined by input";
  Modelica.Blocks.Interfaces.RealInput acr(min=0,unit="1/h") if inputACR annotation (Placement(transformation(extent={{-140,19},{-100,59}}),                   iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-117,-1})));
  parameter Real acr_fixed(unit="1/h")=0.5 if not inputACR "Air change rate in 1/h" annotation(Dialog(enable=not inputACR));
  Modelica.Blocks.Interfaces.RealInput mediumDensity(unit="kg/m3") "Density of the room air" annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,115}),                                                                                                                                       iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={1,111})));
  Modelica.Blocks.Interfaces.RealOutput m_flow(final unit="kg/s") "Prescribed mass flow rate" annotation (Placement(transformation(extent={{100,-20},{140,20}}),
                         iconTransformation(extent={{100,-20},{140,20}})));
  Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(extent={{-16,-6},{4,14}})));
  Modelica.Blocks.Sources.RealExpression factor(y=1/3600*volume*mediumDensity) annotation (Placement(transformation(extent={{-56,48},{-36,68}})));
  Modelica.Blocks.Sources.RealExpression acr_expr(y=acr_fixed) if not inputACR;
equation
  if inputACR then
    connect(acr,product1.u2);
  else
    connect(acr_expr.y,product1.u2);
  end if;
  connect(factor.y,product1.u1);
  connect(product1.y,m_flow);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Convertes an air exchange rate [1/h] to a mass flow rate using the density as an input.</p>
</html>"));
end ACRtoMassFlow;
