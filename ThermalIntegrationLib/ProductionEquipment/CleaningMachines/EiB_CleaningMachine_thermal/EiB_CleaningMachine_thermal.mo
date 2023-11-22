within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal;
model EiB_CleaningMachine_thermal
  extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
    electricDemands=1,
    ID=1,
    coolDemands=0,
    m=1300,
    cp=0.5,
    TInitial=298.15,
    heatDemands=2,
    tableOperationMode=[0,3; 12600,3; 12600,2; 15300,2; 15300,3; 27900,3; 27900,2; 28800,2; 28800,3; 41400,3; 41400,2; 44100,2; 44100,3; 56700,
        3; 56700,2; 57600,2; 57600,3; 70200,3; 70200,2; 72900,2; 72900,3; 85500,3; 85500,1; 86400,1],
    operationModes=3);
    parameter Integer tableProcessingProgramm[:,2]=[16,15; 5,30; 6,60; 7,60; 12,10; 11,15; 8,60; 11,15; 14,
      60; 13,90; 17,15; 2,60] "Washing programm (washing mode = first column, duration in s = second column)";
    replaceable parameter
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a
    TechnicalConfiguration constrainedby
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
  TankHeating.thermTankHeating1 thermTankHeating1
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  TankHeating.thermTankHeating2 thermTankHeating2
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hall(T=298.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,-80})));
  ProcessingProgramms.stateController stateController(stateTable=tableProcessingProgramm)
    annotation (Placement(transformation(extent={{-112,10},{-92,30}})));
  MechanicalProcesses.mech_processes mech_processes annotation (Placement(transformation(extent={{-10,110},{10,130}})));
  MechanicalProcesses.ah ah annotation (Placement(transformation(extent={{-10,80},{10,100}})));
  MechanicalProcesses.scc scc annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Modelica.Blocks.Math.MultiSum P_el(nu=4) annotation (Placement(transformation(extent={{54,68},{66,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=3)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-80})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_hall
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-110})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_heat
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={110,-30})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,0})));
  MechanicalProcesses.oil_separator oil_separator annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_mt1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=94.76658477) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-56})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_mt2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={20,-60})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,-102})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Batches.hot_batches hot_batches annotation (Placement(transformation(extent={{52,-150},{72,-130}})));
  Batches.batch batch annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-128})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heating(T=363.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={130,0})));
equation
  electricDemand[1].Power[1] = P_el.y;
  electricDemand[1].Power[2] = P_el.y;
  electricDemand[1].Power[3] = P_el.y;

// Heat demand represents heat influx from central heating system
  heatDemand[1].Q_flow[1] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[1] = T_heat.T;
  heatDemand[1].T_out[1] = T_mt1.T;

  heatDemand[1].Q_flow[2] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[2] = T_heat.T;
  heatDemand[1].T_out[2] = T_mt1.T;

  heatDemand[1].Q_flow[3] = thermTankHeating1.port_heating.Q_flow;
  heatDemand[1].T_in[3] = T_heat.T;
  heatDemand[1].T_out[3] = T_mt1.T;

  heatDemand[2].Q_flow[1] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[1] = T_heat.T;
  heatDemand[2].T_out[1] = T_mt2.T;

  heatDemand[2].Q_flow[2] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[2] = T_heat.T;
  heatDemand[2].T_out[2] = T_mt2.T;

  heatDemand[2].Q_flow[3] = thermTankHeating2.port_heating.Q_flow;
  heatDemand[2].T_in[3] = T_heat.T;
  heatDemand[2].T_out[3] = T_mt2.T;

  dissipationFlowRate = hall.port.Q_flow;
  connect(thermTankHeating2.state, stateController.state)
    annotation (Line(points={{28,-80},{-60,-80},{-60,20},{-91,20}},      color={255,127,0}));
  connect(thermTankHeating1.state, stateController.state)
    annotation (Line(points={{-12,-30},{-60,-30},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.state, stateController.state)
    annotation (Line(points={{-11,120},{-60,120},{-60,20},{-91,20}},    color={255,127,0}));
  connect(ah.state, stateController.state) annotation (Line(points={{-11,90},{-60,90},{-60,20},{-91,20}},    color={255,127,0}));
  connect(scc.state, stateController.state) annotation (Line(points={{-11,60},{-60,60},{-60,20},{-91,20}},    color={255,127,0}));
  connect(hall.port, thermalCollector.port_b) annotation (Line(points={{120,-80},{100,-80}}, color={191,0,0}));
  connect(T_hall.port, thermalCollector.port_b) annotation (Line(points={{110,-100},{110,-80},{100,-80}}, color={191,0,0}));
  connect(thermTankHeating1.port_hall, thermalCollector.port_a[1])
    annotation (Line(points={{10,-30},{79.3333,-30},{79.3333,-80}},
                                                              color={191,0,0}));
  connect(thermTankHeating2.port_hall, thermalCollector.port_a[2])
    annotation (Line(points={{50,-80},{80,-80}},   color={191,0,0}));
  connect(thermTankHeating1.port_heating, thermalCollector1.port_a[1])
    annotation (Line(points={{0,-20},{0,0},{79.5,0}}, color={191,0,0}));
  connect(thermTankHeating2.port_heating, thermalCollector1.port_a[2])
    annotation (Line(points={{40,-70},{40,0},{80.5,0}}, color={191,0,0}));
  connect(oil_separator.state, stateController.state)
    annotation (Line(points={{-11,35},{-60,35},{-60,20},{-91,20}},      color={255,127,0}));
  connect(mech_processes.P_el, P_el.u[1]) annotation (Line(points={{11,120},{40,120},{40,77.15},{54,77.15}}, color={0,0,127}));
  connect(ah.P_el, P_el.u[2]) annotation (Line(points={{11,90},{40,90},{40,75.05},{54,75.05}}, color={0,0,127}));
  connect(scc.P_el, P_el.u[3]) annotation (Line(points={{11,60},{42,60},{42,72.95},{54,72.95}}, color={0,0,127}));
  connect(oil_separator.P_el, P_el.u[4]) annotation (Line(points={{11,30},{42,30},{42,70.85},{54,70.85}}, color={0,0,127}));
  connect(T_mt1.port, thermTankHeating1.port_heating)
    annotation (Line(points={{-20,-1.22125e-15},{0,-1.22125e-15},{0,-20}},
                                                      color={191,0,0}));
  connect(thermTankHeating1.port_tank, thermalConductor.port_a)
    annotation (Line(points={{10,-36},{60,-36},{60,-46}}, color={191,0,0}));
  connect(thermalConductor.port_b, thermTankHeating2.port_tank)
    annotation (Line(points={{60,-66},{60,-86},{50,-86}}, color={191,0,0}));
  connect(thermTankHeating2.port_heating, T_mt2.port) annotation (Line(points={{40,-70},{40,-60},{30,-60}}, color={191,0,0}));
  connect(thermTankHeating1.port_batch, thermalCollector2.port_a[1]) annotation (Line(points={{0,-40},{0,-91.5}}, color={191,0,0}));
  connect(thermTankHeating2.port_batch, thermalCollector2.port_a[2])
    annotation (Line(points={{40,-90},{40,-92},{0,-92},{0,-92.5}}, color={191,0,0}));
  connect(stateController.opMode, integerExpression.y) annotation (Line(points={{-113,20},{-119,20}}, color={255,127,0}));
  connect(hot_batches.port_hall, thermalCollector.port_a[3])
    annotation (Line(points={{72,-140},{80.6667,-140},{80.6667,-80}}, color={191,0,0}));
  connect(thermalCollector2.port_b, batch.port_tank) annotation (Line(points={{0,-112},{1.77636e-15,-118}}, color={191,0,0}));
  connect(stateController.new_batch, batch.new_batch)
    annotation (Line(points={{-91,14},{-80,14},{-80,-128},{-12,-128}}, color={255,0,255}));
  connect(hot_batches.new_batch, batch.new_batch)
    annotation (Line(points={{51,-140},{-80,-140},{-80,-128},{-12,-128}}, color={255,0,255}));
  connect(stateController.dur_t1, oil_separator.dur_t1) annotation (Line(points={{-91,26},{-11,25}}, color={0,0,127}));
  connect(heating.port, thermalCollector1.port_b) annotation (Line(points={{120,1.22125e-15},{100,-6.10623e-16}}, color={191,0,0}));
  connect(T_heat.port, thermalCollector1.port_b)
    annotation (Line(points={{110,-20},{110,1.22125e-15},{100,-6.10623e-16}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})),
                                                                 Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
end EiB_CleaningMachine_thermal;
