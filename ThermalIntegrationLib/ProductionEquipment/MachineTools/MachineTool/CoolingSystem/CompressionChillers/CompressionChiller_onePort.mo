within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.CoolingSystem.CompressionChillers;
model CompressionChiller_onePort
  //## EXTENSIONS ##
  outer Modelica.Fluid.System system "System wide properties";

  //## PARAMETERS ##
  parameter .Modelica.Blocks.Types.SimpleController controllerType=Modelica.Blocks.Types.SimpleController.PID  "Type of controller" annotation (Dialog(group="Control Parameter"));
  parameter Real k=-0.4 "Gain of controller"
                                            annotation (Dialog(group="Control Parameter"));
  parameter SI.Time Ti=600 "Time constant of Integrator block"
                                                              annotation (Dialog(group="Control Parameter"));
  parameter SI.Time Td=20 "Time constant of Derivative block"
                                                             annotation (Dialog(group="Control Parameter"));
  parameter Boolean ContControl "True if continuous control. False if hysteresis";
  parameter Boolean IsUsed "True if used. False if unused";

  parameter Modelica.SIunits.ThermodynamicTemperature T_flow=TechnicalConfiguration.T_target_coldWater
                                                                    "Flow temperature of cooling system";
  parameter Modelica.SIunits.ThermodynamicTemperature T_target_coldWater=TechnicalConfiguration.T_target_coldWater;

  // deviceData
  replaceable parameter Data.Viessmann_Vitocal350G_BWC351A07
    deviceData constrainedby Data.BaseClasses.CompressionChillerProperties
    "Record with performance data" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{-98,-98},{-78,-78}})));

   parameter Boolean use_PressureLoss_evap=true    "= false to neglect pressure losses on evaporator side" annotation (Evaluate=true,Dialog(group="Nominal Performance"),choices(checkBox=true));
   parameter Boolean use_PressureLoss_cond=false   "= false to neglect pressure losses on condenser side" annotation (Evaluate=true,Dialog(group="Nominal Performance"),choices(checkBox=true));

   // Initialization
  parameter SI.Temperature T_start=273.15 + 20 "Start temperature of internal mixing volume" annotation (Dialog(group="Initialization"));

  //## COMPONENTS ##
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC
    annotation (Placement(transformation(extent={{-50,-29},{-40,-19}})));
  Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", final unit="W")
    "electric power consumed" annotation (Placement(transformation(extent={{100,-10},
            {120,10}}),       iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_cool(quantity="Power", final unit="W")
    "thermal power (cool) output" annotation (Placement(transformation(extent={{100,-90},
            {120,-70}}),          iconTransformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput P_th_heat(quantity="Power", final unit="W")
    "thermal power (heat) output" annotation (Placement(transformation(extent={{100,-50},
            {120,-30}}),         iconTransformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Tables.CombiTable2D Table_f_PthMax(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      table=deviceData.f_PthMax)
    annotation (Placement(transformation(extent={{-16,-40},{4,-20}})));
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
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
        iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput s_u "operation point"
    annotation (Placement(transformation(extent={{100,50},{120,70}}),
        iconTransformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Math.Gain gain_P_th_nom(k=deviceData.P_th_cool_nom)
    annotation (Placement(transformation(extent={{20,-36},{32,-24}})));
  Modelica.Blocks.Math.Add add(k2=+1) annotation (Placement(transformation(extent={{70,-24},
            {80,-14}})));
  Modelica.Blocks.Math.Gain signCorrect_cool(k=-1) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=180,
        origin={70,-78})));

  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=deviceData.tau)
    annotation (Placement(transformation(extent={{58,-82},{50,-74}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prePow1(final alpha=0)
    "Prescribed power (=heat and flow work) flow for dynamic model"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={84,60})));
  BaseClasses.ConditionCheck conditionCheck(
    T_in_cool_min=deviceData.T_in_cool_min,
    T_in_cool_max=deviceData.T_in_cool_max,
    T_in_heat_min=deviceData.T_in_heat_min,
    T_in_heat_max=deviceData.T_in_heat_max)
    annotation (Placement(transformation(extent={{-54,-6},{-42,6}})));
  Modelica.Blocks.Tables.CombiTable2D Table_f_PelMax(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      table=deviceData.f_PelMax)
    annotation (Placement(transformation(extent={{-16,20},{4,40}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin K2degC1
    annotation (Placement(transformation(extent={{-50,17},{-40,27}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=deviceData.tau)
    annotation (Placement(transformation(extent={{4,-4},{-4,4}},
        rotation=270,
        origin={84,36})));
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

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ColdWater
    annotation (Placement(transformation(extent={{-6,-110},{14,-90}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TempColdIn
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-52,-60})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TempHeatInHall
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-36,84})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Hall
    annotation (Placement(transformation(extent={{-8,90},{12,110}}),
        iconTransformation(extent={{-8,90},{12,110}})));
  Controllers.disk_control_hysteresis_Frank disk_control_hysteresis_Frank(T_target_coldWater=T_target_coldWater)
    annotation (Placement(transformation(extent={{-94,-28},{-82,-16}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-72,0})));
  Controllers.PID_lim_Controller_TEva pID_lim_Controller_TEva(T_target=T_target_coldWater,
      k=-0.8)                                                 annotation (
     Placement(transformation(extent={{-94,8},{-82,20}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=ContControl) annotation (Placement(transformation(extent={{-96,-6},{-82,6}})));
  Modelica.Blocks.Logical.Switch switch3
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={-60,-12})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression3(y=IsUsed)     annotation (Placement(transformation(extent={{-96,-18},{-82,-6}})));
  Modelica.Blocks.Sources.Constant const3(k=0)
    annotation (Placement(transformation(extent={{-76,-24},{-68,-16}})));
equation
  if use_PressureLoss_evap then
  else
  end if;

    if use_PressureLoss_cond then
  else
  end if;

  connect(signCorrect_cool.y, firstOrder.u)
    annotation (Line(points={{65.6,-78},{58.8,-78}}, color={0,0,127}));
  connect(firstOrder.y, prePow.Q_flow)
    annotation (Line(points={{49.6,-78},{42,-78}}, color={0,0,127}));
  connect(conditionCheck.s_dis, s_dis) annotation (Line(points={{-41.4,-2.4},{
          -32,-2.4},{-32,40},{110,40}},       color={255,0,255}));
  connect(Table_f_PthMax.u1, K2degC.Celsius) annotation (Line(points={{-18,-24},{-39.5,-24}},
                                          color={0,0,127}));
  connect(K2degC1.Celsius, Table_f_PthMax.u2) annotation (Line(points={{-39.5,22},{-24,22},{-24,-36},{-18,-36}},
                                     color={0,0,127}));
  connect(product_P_el.u1, gain_P_el_nom.y) annotation (Line(points={{24.8,3.6},
          {22,3.6},{22,16},{40,16},{40,30},{32.6,30}}, color={0,0,127}));
  connect(signCorrect_heat.y, P_th_heat)
    annotation (Line(points={{96.4,-40},{110,-40}}, color={0,0,127}));
  connect(Table_f_PelMax.u1, K2degC.Celsius) annotation (Line(points={{-18,36},{-28,36},{-28,-24},{-39.5,-24}},
                                            color={0,0,127}));
  connect(Table_f_PelMax.u2, Table_f_PthMax.u2) annotation (Line(points={{-18,24},
          {-24,24},{-24,-36},{-18,-36}},
                                      color={0,0,127}));
  connect(signCorrect_cool.u, P_th_cool) annotation (Line(points={{74.8,-78},{
          92,-78},{92,-80},{110,-80}},
                                    color={0,0,127}));
  connect(Table_f_Pel_partLoad.u, conditionCheck.s_u) annotation (Line(points={{-18,0},
          {-26,0},{-26,2.4},{-41.4,2.4}},  color={0,0,127}));
  connect(s_u, conditionCheck.s_u) annotation (Line(points={{110,60},{-34,60},{
          -34,2.4},{-41.4,2.4}},         color={0,0,127}));
  connect(product_P_th.u1, gain_P_th_nom.y) annotation (Line(points={{39,-40},{36,
          -40},{36,-30},{32.6,-30}}, color={0,0,127}));
  connect(product_P_th.u2, conditionCheck.s_u) annotation (Line(points={{39,-46},
          {-34,-46},{-34,2.4},{-41.4,2.4}},
                                      color={0,0,127}));
  connect(gain_P_el_nom1.y, add.u1)
    annotation (Line(points={{60.6,-16},{69,-16}}, color={0,0,127}));
  connect(product_P_th.y, P_th_cool) annotation (Line(points={{50.5,-43},{80,
          -43},{80,-82},{92,-82},{92,-80},{110,-80}},
                                                 color={0,0,127}));
  connect(add.u2, product_P_th.y) annotation (Line(points={{69,-22},{60,-22},{60,
          -43},{50.5,-43}}, color={0,0,127}));
  connect(gain_P_el_nom1.u, product_P_el.y) annotation (Line(points={{46.8,-16},
          {42,-16},{42,0},{38.6,0}}, color={0,0,127}));
  connect(P_el, product_P_el.y)
    annotation (Line(points={{110,0},{38.6,0}}, color={0,0,127}));
  connect(signCorrect_heat.u, add.y) annotation (Line(points={{87.2,-40},{84,-40},
          {84,-19},{80.5,-19}}, color={0,0,127}));
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
  connect(conditionCheck.T_in_heat, K2degC1.Kelvin) annotation (Line(points={{-54.6,3.6},{-60,3.6},{-60,22},{-51,22}},
                                         color={0,0,127}));
  connect(prePow.port, ColdWater)
    annotation (Line(points={{22,-78},{22,-100},{4,-100}}, color={191,0,0}));
  connect(TempColdIn.T, K2degC.Kelvin)
    annotation (Line(points={{-60,-60},{-60,-24},{-51,-24}}, color={0,0,127}));
  connect(conditionCheck.T_in_cool, K2degC.Kelvin) annotation (Line(points={{-54.6,-3.6},{-60,-3.6},{-60,-24},{-51,-24}},
                                             color={0,0,127}));
  connect(TempColdIn.port, ColdWater) annotation (Line(points={{-44,-60},{-42,-60},{-42,-100},{4,-100}},
                                color={191,0,0}));
  connect(firstOrder1.y, prePow1.Q_flow)
    annotation (Line(points={{84,40.4},{84,50}}, color={0,0,127}));
  connect(prePow1.port, Hall)
    annotation (Line(points={{84,70},{84,100},{2,100}},
                                                 color={191,0,0}));
  connect(s_u, s_u)
    annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  connect(firstOrder1.u, add.y) annotation (Line(points={{84,31.2},{84,-19},{
          80.5,-19}},       color={0,0,127}));
  connect(Hall, TempHeatInHall.port) annotation (Line(points={{2,100},{-16,100},
          {-16,84},{-28,84}},          color={191,0,0}));
  connect(disk_control_hysteresis_Frank.y, switch2.u3) annotation (Line(
        points={{-81.4,-22},{-80,-22},{-80,-4},{-76.8,-4},{-76.8,-3.2}},
        color={0,0,127}));
  connect(TempHeatInHall.T, K2degC1.Kelvin) annotation (Line(points={{-44,84},{-60,84},{-60,22},{-51,22}},
                                       color={0,0,127}));
  connect(pID_lim_Controller_TEva.y, switch2.u1) annotation (Line(points={{-81.4,14},{-80,14},{-80,3.2},{-76.8,3.2}}, color={0,0,127}));
  connect(switch2.u2, booleanExpression.y) annotation (Line(points={{-76.8,0},{-81.3,0}}, color={255,0,255}));
  connect(switch2.y, switch3.u1) annotation (Line(points={{-67.6,0},{-66,0},{-66,-8},{-64.8,-8},{-64.8,-8.8}}, color={0,0,127}));
  connect(conditionCheck.u, switch3.y) annotation (Line(points={{-54.6,0},{-56,0},{-56,-12},{-55.6,-12}}, color={0,0,127}));
  connect(switch3.u2, booleanExpression3.y) annotation (Line(points={{-64.8,-12},{-81.3,-12}}, color={255,0,255}));
  connect(switch3.u3, const3.y) annotation (Line(points={{-64.8,-15.2},{-64.8,-20},{-67.6,-20}}, color={0,0,127}));
  connect(TempColdIn.T, disk_control_hysteresis_Frank.u) annotation (Line(points={{-60,-60},{-100,-60},{-100,-22},{-94.72,-22}},color={0,0,127}));
  connect(TempColdIn.T, pID_lim_Controller_TEva.u) annotation (Line(points={{-60,-60},{-100,-60},{-100,14},{-94.6,14}}, color={0,0,127}));
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
end CompressionChiller_onePort;
