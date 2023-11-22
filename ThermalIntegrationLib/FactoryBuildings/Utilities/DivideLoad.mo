within ThermalIntegrationLib.FactoryBuildings.Utilities;
model DivideLoad "Divides load into heating (>0) and cooling (<0) load"
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(transformation(extent={{-90,-38},{-74,-26}})));
  Modelica.Blocks.Logical.Greater greater annotation (Placement(transformation(extent={{-48,6},{-34,20}})));
  Modelica.Blocks.Logical.Switch coolingSwitch annotation (Placement(transformation(extent={{28,-54},{42,-40}})));
  Modelica.Blocks.Logical.Switch heatingSwitch annotation (Placement(transformation(extent={{56,46},{70,60}})));
  Modelica.Blocks.Interfaces.RealInput totalLoad annotation (Placement(transformation(extent={{-138,-20},{-98,20}})));
  Modelica.Blocks.Interfaces.RealOutput heatingLoad annotation (Placement(transformation(extent={{100,-22},{142,20}}), iconTransformation(extent={{100,-22},{142,20}})));
  Modelica.Blocks.Interfaces.RealOutput coolingLoad annotation (Placement(transformation(extent={{100,-84},{142,-42}}), iconTransformation(extent={{100,38},{142,80}})));
  Modelica.Blocks.Math.Gain switchSign(k=-1) annotation (Placement(transformation(extent={{64,-68},{84,-48}})));
equation
  connect(zero.y, greater.u2) annotation (Line(points={{-73.2,-32},{-54,-32},{-54,7.4},{-49.4,7.4}}, color={0,0,127}));
  connect(greater.y, coolingSwitch.u2) annotation (Line(points={{-33.3,13},{24,13},{24,-36},{20,-36},{20,-47},{26.6,-47}}, color={255,0,255}));
  connect(zero.y, coolingSwitch.u1) annotation (Line(points={{-73.2,-32},{-54,-32},{-54,-22},{26.6,-22},{26.6,-41.4}}, color={0,0,127}));
  connect(greater.y, heatingSwitch.u2) annotation (Line(points={{-33.3,13},{48,13},{48,53},{54.6,53}}, color={255,0,255}));
  connect(zero.y, heatingSwitch.u3) annotation (Line(points={{-73.2,-32},{-54,-32},{-54,-22},{72,-22},{72,42},{54.6,42},{54.6,47.4}}, color={0,0,127}));
  connect(totalLoad, greater.u1) annotation (Line(points={{-118,0},{-56,0},{-56,13},{-49.4,13}}, color={0,0,127}));
  connect(totalLoad, heatingSwitch.u1) annotation (Line(points={{-118,0},{-56,0},{-56,64},{54.6,64},{54.6,58.6}}, color={0,0,127}));
  connect(totalLoad, coolingSwitch.u3) annotation (Line(points={{-118,0},{-92,0},{-92,-22},{-94,-22},{-94,-58},{26.6,-58},{26.6,-52.6}}, color={0,0,127}));
  connect(heatingSwitch.y, heatingLoad) annotation (Line(points={{70.7,53},{88.35,53},{88.35,-1},{121,-1}}, color={0,0,127}));
  connect(coolingSwitch.y, switchSign.u) annotation (Line(points={{42.7,-47},{54,-47},{54,-58},{62,-58}}, color={0,0,127}));
  connect(switchSign.y, coolingLoad) annotation (Line(points={{85,-58},{96,-58},{96,-63},{121,-63}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end DivideLoad;
