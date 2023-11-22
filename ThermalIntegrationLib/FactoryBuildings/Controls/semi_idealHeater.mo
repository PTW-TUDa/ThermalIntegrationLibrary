within ThermalIntegrationLib.FactoryBuildings.Controls;
model semi_idealHeater

  parameter Real k "Gain constant";
  parameter Modelica.SIunits.HeatFlowRate pMaxHeat(displayUnit="kW") = Modelica.Constants.inf;
  parameter Modelica.SIunits.HeatFlowRate pMaxCool(displayUnit="kW") = Modelica.Constants.inf;
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,     y(unit="K")) annotation (Placement(transformation(extent={{-30,-60},{-12,-42}})));
  Modelica.Blocks.Interfaces.RealInput actTemperature(unit="K") annotation (Placement(transformation(extent={{-140,34},{-100,74}}), iconTransformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
                                                        annotation (Placement(transformation(extent={{2,70},{22,90}})));
  Modelica.Blocks.Logical.Switch switchT(y(unit="K")) annotation (Placement(transformation(extent={{-54,-42},{-34,-22}})));
  Modelica.Blocks.Interfaces.RealInput T_max(unit="K") annotation (Placement(transformation(extent={{-140,-48},{-100,-8}})));
  Modelica.Blocks.Interfaces.RealInput T_min(unit="K") annotation (Placement(transformation(extent={{-140,-92},{-100,-52}})));
  Modelica.Blocks.Logical.Switch switchT1(y(unit="K"))
                                                      annotation (Placement(transformation(extent={{40,38},{60,58}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{70,-6},{90,14}})));
  Modelica.Blocks.Logical.Or or1 annotation (Placement(transformation(extent={{-20,34},{0,54}})));
  Modelica.Blocks.Logical.Greater greater annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Logical.Less less annotation (Placement(transformation(extent={{-68,-2},{-48,18}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{94,-10},{114,10}})));
  Modelica.Blocks.Math.Gain gain(k=k)            annotation (Placement(transformation(extent={{2,-60},{22,-40}})));
  Modelica.Blocks.Logical.Greater greaterThreshold annotation (Placement(transformation(extent={{34,-60},{54,-40}})));
  Utilities.Switch3 switch1 annotation (Placement(transformation(extent={{66,-60},{86,-40}})));
  Modelica.Blocks.Logical.Less lessThreshold annotation (Placement(transformation(extent={{34,-92},{54,-72}})));
  Modelica.Blocks.Sources.RealExpression pMaxHeat1(y=pMaxHeat) annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
  Modelica.Blocks.Sources.RealExpression pMaxCool1(y=-pMaxCool) annotation (Placement(transformation(extent={{-30,-104},{-10,-84}})));
equation
  connect(realExpression.y, switchT1.u3) annotation (Line(points={{23,80},{30,80},{30,34},{38,34},{38,40}}, color={0,0,127}));
  connect(T_max, switchT.u1) annotation (Line(points={{-120,-28},{-64,-28},{-64,-24},{-56,-24}}, color={0,0,127}));
  connect(T_min, switchT.u3) annotation (Line(points={{-120,-72},{-62,-72},{-62,-40},{-56,-40}}, color={0,0,127}));
  connect(actTemperature, greater.u1) annotation (Line(points={{-120,54},{-88,54},{-88,50},{-82,50}}, color={0,0,127}));
  connect(actTemperature, less.u1) annotation (Line(points={{-120,54},{-78,54},{-78,8},{-70,8}}, color={0,0,127}));
  connect(T_max, greater.u2) annotation (Line(points={{-120,-28},{-64,-28},{-64,-6},{-40,-6},{-40,36},{-82,36},{-82,42}}, color={0,0,127}));
  connect(T_min, less.u2) annotation (Line(points={{-120,-72},{-74,-72},{-74,0},{-70,0}},                             color={0,0,127}));
  connect(greater.y, or1.u1) annotation (Line(points={{-59,50},{-30,50},{-30,44},{-22,44}}, color={255,0,255}));
  connect(less.y, or1.u2) annotation (Line(points={{-47,8},{-28,8},{-28,36},{-22,36}}, color={255,0,255}));
  connect(or1.y, switchT1.u2) annotation (Line(points={{1,44},{26,44},{26,48},{38,48}}, color={255,0,255}));
  connect(feedback.y, switchT1.u1) annotation (Line(points={{9,0},{32,0},{32,56},{38,56}},                      color={0,0,127}));
  connect(prescribedHeatFlow.port, port_b) annotation (Line(points={{90,4},{94,4},{94,0},{104,0}}, color={191,0,0}));
  connect(greater.y, switchT.u2) annotation (Line(points={{-59,50},{-30,50},{-30,-6},{-40,-6},{-40,-18},{-60,-18},{-60,-32},{-56,-32}}, color={255,0,255}));
  connect(actTemperature, feedback.u2) annotation (Line(points={{-120,54},{-88,54},{-88,34},{-26,34},{-26,-14},{0,-14},{0,-8}},  color={0,0,127}));
  connect(switchT.y, feedback.u1) annotation (Line(points={{-33,-32},{-22,-32},{-22,0},{-8,0}},   color={0,0,127}));
  connect(switchT1.y, firstOrder.u) annotation (Line(points={{61,48},{66,48},{66,10},{34,10},{34,-38},{-16,-38},{-16,-51},{-31.8,-51}}, color={0,0,127}));
  connect(firstOrder.y, gain.u) annotation (Line(points={{-11.1,-51},{0,-50}},                  color={0,0,127}));
  connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{55,-50},{58,-50},{58,-46},{64,-46}}, color={255,0,255}));
  connect(lessThreshold.y, switch1.u4) annotation (Line(points={{55,-82},{64,-82},{64,-64},{58,-64},{58,-54},{64,-54}}, color={255,0,255}));
  connect(gain.y, greaterThreshold.u1) annotation (Line(points={{23,-50},{32,-50}}, color={0,0,127}));
  connect(pMaxHeat1.y, greaterThreshold.u2) annotation (Line(points={{-9,-80},{28,-80},{28,-64},{32,-64},{32,-58}}, color={0,0,127}));
  connect(gain.y, lessThreshold.u1) annotation (Line(points={{23,-50},{26,-50},{26,-82},{32,-82}}, color={0,0,127}));
  connect(pMaxCool1.y, lessThreshold.u2) annotation (Line(points={{-9,-94},{26,-94},{26,-90},{32,-90}}, color={0,0,127}));
  connect(pMaxHeat1.y, switch1.u1) annotation (Line(points={{-9,-80},{28,-80},{28,-64},{58,-64},{58,-36},{64,-36},{64,-42}}, color={0,0,127}));
  connect(pMaxCool1.y, switch1.u3) annotation (Line(points={{-9,-94},{26,-94},{26,-96},{92,-96},{92,-36},{64,-36},{64,-50}}, color={0,0,127}));
  connect(gain.y, switch1.u5) annotation (Line(points={{23,-50},{28,-50},{28,-36},{56,-36},{56,-34},{64,-34},{64,-58}}, color={0,0,127}));
  connect(switch1.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{87,-50},{94,-50},{94,-14},{64,-14},{64,4},{70,4}}, color={0,0,127}));
                                                        annotation (Placement(transformation(extent={{68,52},{88,72}})),
                                                                    Placement(transformation(extent={{66,68},{86,88}})),
    Documentation(info="<html>
<p>This component can be used to easily determine heating and cooling demands using a range of a minimum and maximum set temperature.</p>
<p>Troubleshooting: If the room temperature exceeds the temperature limits it might be necessary to adjust the gain constant k.</p>
</html>"));
end semi_idealHeater;
