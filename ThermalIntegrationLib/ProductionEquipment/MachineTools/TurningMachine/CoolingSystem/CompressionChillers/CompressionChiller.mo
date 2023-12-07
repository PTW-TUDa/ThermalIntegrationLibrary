within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem.CompressionChillers;
model CompressionChiller
  //## EXTENSIONS ##
  outer Modelica.Fluid.System system "System wide properties";

  //## PARAMETERS ##
  parameter Boolean WaterCooled "exhaust heat in cool water network";
  parameter Boolean ContControl;
  parameter Boolean IsUsed "True if used. False if unused";

  parameter .Modelica.Blocks.Types.SimpleController controllerType=Modelica.Blocks.Types.SimpleController.PID  "Type of controller" annotation (Dialog(group="Control Parameter"));
  parameter Real k=-0.4 "Gain of controller"
                                            annotation (Dialog(group="Control Parameter"));
  parameter SI.Time Ti=600 "Time constant of Integrator block"
                                                              annotation (Dialog(group="Control Parameter"));
  parameter SI.Time Td=20 "Time constant of Derivative block"
                                                             annotation (Dialog(group="Control Parameter"));

  parameter Modelica.Units.SI.ThermodynamicTemperature T_flow=TechnicalConfiguration.T_target_coldWater - 5 "Flow temperature of cooling system";
  parameter Modelica.Units.SI.ThermodynamicTemperature T_target_coldWater=TechnicalConfiguration.T_target_coldWater;

  // deviceData
  replaceable parameter Data.Viessmann_Vitocal350G_BWC351A07 deviceData
    constrainedby Data.BaseClasses.CompressionChillerProperties
    "Record with performance data" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-98,-98},{-82,-82}})));

   parameter Boolean use_PressureLoss_evap=true    "= false to neglect pressure losses on evaporator side" annotation (Evaluate=true,Dialog(group="Nominal Performance"),choices(checkBox=true));
   parameter Boolean use_PressureLoss_cond=false   "= false to neglect pressure losses on condenser side" annotation (Evaluate=true,Dialog(group="Nominal Performance"),choices(checkBox=true));

  // Initialization
  parameter SI.Temperature T_start=273.15 + 20 "Start temperature of internal mixing volume" annotation (Dialog(group="Initialization"));

  //## COMPONENTS ##
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC
    annotation (Placement(transformation(extent={{-60,-29},{-50,-19}})));
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", final unit="W")
    "electric power consumed" annotation (Placement(transformation(extent={{100,-10},
            {120,10}}),       iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_cool(quantity="Power", final unit="W")
    "thermal power (cool) output" annotation (Placement(transformation(extent={{100,-90},
            {120,-70}}),          iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_heat(quantity="Power", final unit="W")
    "thermal power (heat) output" annotation (Placement(transformation(extent={{100,-50},
            {120,-30}}),         iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Tables.CombiTable2Ds Table_f_PthMax(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=deviceData.f_PthMax) annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prePow(final alpha=0)
    "Prescribed power (=heat and flow work) flow for dynamic model"
    annotation (Placement(transformation(extent={{42,-88},{22,-68}})));
  Modelica.Blocks.Tables.CombiTable1Ds Table_f_Pel_partLoad(
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    columns={2},
    table=deviceData.f_Pel_partLoad)
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  Modelica.Blocks.Math.Gain gain_P_el_nom(k=deviceData.P_el_nom)
    annotation (Placement(transformation(extent={{20,24},{32,36}})));
  Modelica.Blocks.Interfaces.BooleanOutput s_dis "disturbance because of operational conditions"
    annotation (Placement(transformation(extent={{100,28},{120,48}}),
        iconTransformation(extent={{100,28},{120,48}})));
  Modelica.Blocks.Interfaces.RealOutput s_u "operation point"
    annotation (Placement(transformation(extent={{100,68},{120,88}}),
        iconTransformation(extent={{100,68},{120,88}})));
  Modelica.Blocks.Math.Gain gain_P_th_nom(k=deviceData.P_th_cool_nom)
    annotation (Placement(transformation(extent={{20,-36},{32,-24}})));
  Modelica.Blocks.Math.Add add(k2=+1) annotation (Placement(transformation(extent={{68,-24},{78,-14}})));
  Modelica.Blocks.Math.Gain signCorrect_cool(k=-1) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={78,-78})));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=deviceData.tau)
    annotation (Placement(transformation(extent={{58,-82},{50,-74}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prePow1(final alpha=0)
    "Prescribed power (=heat and flow work) flow for dynamic model"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={18,84})));
  BaseClasses.ConditionCheck conditionCheck(
    T_in_cool_min=deviceData.T_in_cool_min,
    T_in_cool_max=deviceData.T_in_cool_max,
    T_in_heat_min=deviceData.T_in_heat_min,
    T_in_heat_max=deviceData.T_in_heat_max)
    annotation (Placement(transformation(extent={{-48,-6},{-36,6}})));
  Modelica.Blocks.Tables.CombiTable2Ds Table_f_PelMax(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=deviceData.f_PelMax) annotation (Placement(transformation(extent={{-16,20},{4,40}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC1
    annotation (Placement(transformation(extent={{-58,17},{-48,27}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=deviceData.tau)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={42,68})));
  Modelica.Blocks.Math.Gain signCorrect_heat(k=-1) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=0,
        origin={92,-40})));
  Modelica.Blocks.Math.Gain gain_P_el_nom1(k=deviceData.alpha)
    annotation (Placement(transformation(extent={{48,-22},{60,-10}})));
  Modelica.Blocks.Math.Product product_P_el
    annotation (Placement(transformation(extent={{26,-6},{38,6}})));
  Modelica.Blocks.Math.Product product_P_th
    annotation (Placement(transformation(extent={{40,-48},{50,-38}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{10,28},{14,32}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{12,-2},{16,2}})));
  Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1, uMin=0)
    annotation (Placement(transformation(extent={{10,-32},{14,-28}})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a coolWater
    annotation (Placement(transformation(extent={{40,90},{60,110}}),
        iconTransformation(extent={{40,90},{60,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ColdWater
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TempColdIn
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-58,-60})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TempHeatInHall
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-20,84})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Hall
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prePow2(final alpha=0)
    "Prescribed power (=heat and flow work) flow for dynamic model"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={74,84})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=deviceData.tau)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={90,70})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TempHeatInCoolWater
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-20,60})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-66,36})));
  Controllers.disk_control_hysteresis_Frank disk_control_hysteresis_Frank(T_target_coldWater=T_target_coldWater)
    annotation (Placement(transformation(extent={{-96,-26},{-84,-14}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-72,0})));
  Controllers.PID_lim_Controller_TEva pID_lim_Controller_TEva(
    T_target=T_target_coldWater,
    k=-0.8,
    Ti=600) annotation (Placement(transformation(extent={{-96,8},{-84,20}})));
  Modelica.Blocks.Logical.Switch switch4
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={68,56})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{44,36},{56,48}})));
  Modelica.Blocks.Logical.Switch switch5
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=90,
        origin={90,54})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={50,20})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=ContControl) annotation (Placement(transformation(extent={{-98,-6},{-84,6}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=WaterCooled)
                                                                             annotation (Placement(transformation(extent={{-96,48},{-82,60}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=WaterCooled)
                                                                             annotation (Placement(transformation(extent={{58,22},{72,34}})));
  parameter Modelica.Blocks.Interfaces.BooleanOutput y=WaterCooled "Value of Boolean output";
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=IsUsed)     annotation (Placement(transformation(extent={{-98,-16},{-84,-4}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-58,-10})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-78,-22},{-70,-14}})));
equation
  if use_PressureLoss_evap then
  else
  end if;

    if use_PressureLoss_cond then
  else
  end if;

  connect(firstOrder.y, prePow.Q_flow)
    annotation (Line(points={{49.6,-78},{42,-78}}, color={0,0,127}));
  connect(conditionCheck.s_dis, s_dis) annotation (Line(points={{-35.4,-2.4},{-32,-2.4},{-32,38},{110,38}},
                                              color={255,0,255}));
  connect(Table_f_PthMax.u1, K2degC.Celsius) annotation (Line(points={{-18,-24},
          {-49.5,-24}},                   color={0,0,127}));
  connect(K2degC1.Celsius, Table_f_PthMax.u2) annotation (Line(points={{-47.5,
          22},{-24,22},{-24,-36},{-18,-36}},
                                     color={0,0,127}));
  connect(product_P_el.u1, gain_P_el_nom.y) annotation (Line(points={{24.8,3.6},
          {22,3.6},{22,16},{40,16},{40,30},{32.6,30}}, color={0,0,127}));
  connect(signCorrect_heat.y, P_th_heat)
    annotation (Line(points={{96.4,-40},{110,-40}}, color={0,0,127}));
  connect(Table_f_PelMax.u1, K2degC.Celsius) annotation (Line(points={{-18,36},{
          -28,36},{-28,-24},{-49.5,-24}},   color={0,0,127}));
  connect(Table_f_PelMax.u2, Table_f_PthMax.u2) annotation (Line(points={{-18,24},
          {-24,24},{-24,-36},{-18,-36}},
                                      color={0,0,127}));
  connect(signCorrect_cool.u, P_th_cool) annotation (Line(points={{82.8,-78},{94,-78},{94,-80},{110,-80}},
                                    color={0,0,127}));
  connect(Table_f_Pel_partLoad.u, conditionCheck.s_u) annotation (Line(points={{-18,0},{-26,0},{-26,2.4},{-35.4,2.4}},
                                           color={0,0,127}));
  connect(s_u, conditionCheck.s_u) annotation (Line(points={{110,78},{-34,78},{-34,2.4},{-35.4,2.4}},
                                         color={0,0,127}));
  connect(product_P_th.u1, gain_P_th_nom.y) annotation (Line(points={{39,-40},{36,
          -40},{36,-30},{32.6,-30}}, color={0,0,127}));
  connect(product_P_th.u2, conditionCheck.s_u) annotation (Line(points={{39,-46},{-34,-46},{-34,2.4},{-35.4,2.4}},
                                      color={0,0,127}));
  connect(gain_P_el_nom1.y, add.u1)
    annotation (Line(points={{60.6,-16},{67,-16}}, color={0,0,127}));
  connect(product_P_th.y, P_th_cool) annotation (Line(points={{50.5,-43},{80,-43},{80,-82},{92,-82},{92,-80},{110,-80}},
                                                 color={0,0,127}));
  connect(add.u2, product_P_th.y) annotation (Line(points={{67,-22},{60,-22},{60,-43},{50.5,-43}},
                            color={0,0,127}));
  connect(gain_P_el_nom1.u, product_P_el.y) annotation (Line(points={{46.8,-16},
          {42,-16},{42,0},{38.6,0}}, color={0,0,127}));
  connect(P_el, product_P_el.y)
    annotation (Line(points={{110,0},{38.6,0}}, color={0,0,127}));
  connect(signCorrect_heat.u, add.y) annotation (Line(points={{87.2,-40},{82,-40},{82,-19},{78.5,-19}},
                                color={0,0,127}));
  connect(Table_f_PelMax.y, limiter.u)
    annotation (Line(points={{5,30},{9.6,30}}, color={0,0,127}));
  connect(limiter.y, gain_P_el_nom.u)
    annotation (Line(points={{14.2,30},{18.8,30}}, color={0,0,127}));
  connect(Table_f_PthMax.y, limiter2.u)
    annotation (Line(points={{5,-30},{9.6,-30}}, color={0,0,127}));
  connect(limiter2.y, gain_P_th_nom.u)
    annotation (Line(points={{14.2,-30},{18.8,-30}}, color={0,0,127}));
  connect(Table_f_Pel_partLoad.y[1], limiter1.u)
    annotation (Line(points={{5,0},{11.6,0}}, color={0,0,127}));
  connect(limiter1.y, product_P_el.u2) annotation (Line(points={{16.2,0},{20,0},
          {20,-3.6},{24.8,-3.6}}, color={0,0,127}));
  connect(conditionCheck.T_in_heat, K2degC1.Kelvin) annotation (Line(points={{-48.6,3.6},{-66,3.6},{-66,22},{-59,22}},
                                         color={0,0,127}));
  connect(prePow.port, ColdWater)
    annotation (Line(points={{22,-78},{22,-100},{0,-100}}, color={191,0,0}));
  connect(TempColdIn.T, K2degC.Kelvin)
    annotation (Line(points={{-66,-60},{-66,-24},{-61,-24}}, color={0,0,127}));
  connect(conditionCheck.T_in_cool, K2degC.Kelvin) annotation (Line(points={{-48.6,-3.6},{-66,-3.6},{-66,-24},{-61,-24}},
                                             color={0,0,127}));
  connect(TempColdIn.port, ColdWater) annotation (Line(points={{-50,-60},{-42,
          -60},{-42,-100},{0,-100}},
                                color={191,0,0}));
  connect(firstOrder1.y, prePow1.Q_flow)
    annotation (Line(points={{42,72.4},{42,84},{28,84}},
                                                 color={0,0,127}));
  connect(firstOrder2.y, prePow2.Q_flow)
    annotation (Line(points={{90,74.4},{90,84},{84,84}},
                                                   color={0,0,127}));
  connect(prePow2.port, coolWater)
    annotation (Line(points={{64,84},{58,84},{58,100},{50,100}},
                                                             color={191,0,0}));
  connect(prePow1.port, Hall)
    annotation (Line(points={{8,84},{8,100},{0,100}},
                                                 color={191,0,0}));
  connect(s_u, s_u)
    annotation (Line(points={{110,78},{110,78}}, color={0,0,127}));
  connect(TempHeatInCoolWater.T, switch1.u1) annotation (Line(points={{-28,60},{-61.2,60},{-61.2,43.2}},
                                              color={0,0,127}));
  connect(TempHeatInHall.T, switch1.u3) annotation (Line(points={{-28,84},{-70.8,84},{-70.8,43.2}},
                                     color={0,0,127}));
  connect(Hall, TempHeatInHall.port) annotation (Line(points={{0,100},{0,84},{-12,84}},
                                       color={191,0,0}));
  connect(coolWater, TempHeatInCoolWater.port) annotation (Line(points={{50,100},{50,60},{-12,60}},
                                                   color={191,0,0}));
  connect(switch1.y, K2degC1.Kelvin) annotation (Line(points={{-66,29.4},{-66,22},{-59,22}},
                              color={0,0,127}));
  connect(switch4.y, firstOrder1.u)
    annotation (Line(points={{68,62.6},{68,63.2},{42,63.2}},
                                                   color={0,0,127}));
  connect(switch4.u3, add.y) annotation (Line(points={{72.8,48.8},{72.8,10},{82,10},{82,-19},{78.5,-19}},
                                            color={0,0,127}));
  connect(const1.y, switch4.u1) annotation (Line(points={{56.6,42},{63.2,42},{63.2,48.8}},
                            color={0,0,127}));
  connect(firstOrder2.u, switch5.y) annotation (Line(points={{90,65.2},{90,60.6}},
                                 color={0,0,127}));
  connect(switch5.u1, add.y) annotation (Line(points={{85.2,46.8},{85.2,46},{84.8,46},{84.8,-19},{78.5,-19}},
                                                                color={0,
          0,127}));
  connect(const2.y, switch5.u3) annotation (Line(points={{56.6,20},{94.8,20},{94.8,46.8}},
                                   color={0,0,127}));
  connect(disk_control_hysteresis_Frank.y, switch2.u3) annotation (Line(points={{-83.4,-20},{-80,-20},{-80,-3.2},{-76.8,-3.2}}, color={0,0,127}));
  connect(pID_lim_Controller_TEva.y, switch2.u1) annotation (Line(points={{-83.4,14},{-80,14},{-80,3.2},{-76.8,3.2}}, color={0,0,127}));
  connect(switch2.u2, booleanExpression.y) annotation (Line(points={{-76.8,0},{-83.3,0}}, color={255,0,255}));
  connect(booleanExpression1.y, switch1.u2) annotation (Line(points={{-81.3,54},{-66,54},{-66,43.2}}, color={255,0,255}));
  connect(booleanExpression2.y, switch5.u2) annotation (Line(points={{72.7,28},{90,28},{90,46.8}}, color={255,0,255}));
  connect(booleanExpression2.y, switch4.u2) annotation (Line(points={{72.7,28},{78,28},{78,42},{68,42},{68,48.8}}, color={255,0,255}));
  connect(firstOrder.u, signCorrect_cool.y) annotation (Line(points={{58.8,-78},{73.6,-78}}, color={0,0,127}));
  connect(switch3.u2, booleanExpression3.y) annotation (Line(points={{-62.8,-10},{-83.3,-10}}, color={255,0,255}));
  connect(switch2.y, switch3.u1) annotation (Line(points={{-67.6,0},{-66,0},{-66,-8},{-62.8,-8},{-62.8,-6.8}}, color={0,0,127}));
  connect(conditionCheck.u, switch3.y) annotation (Line(points={{-48.6,0},{-54,0},{-54,-10},{-53.6,-10}}, color={0,0,127}));
  connect(switch3.u3, const3.y) annotation (Line(points={{-62.8,-13.2},{-66,-13.2},{-66,-18},{-69.6,-18}}, color={0,0,127}));
  connect(TempColdIn.T, pID_lim_Controller_TEva.u) annotation (Line(points={{-66,-60},{-100,-60},{-100,14},{-96.6,14}}, color={0,0,127}));
  connect(TempColdIn.T, disk_control_hysteresis_Frank.u) annotation (Line(points={{-66,-60},{-100,-60},{-100,-20},{-96.72,-20}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),                                                                                             graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-30,52},{56,20}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-30,-52},{56,-20}},
          color={0,0,0},
          thickness=0.5)}), extent={{-140,
            -100},{160,140}});
end CompressionChiller;
