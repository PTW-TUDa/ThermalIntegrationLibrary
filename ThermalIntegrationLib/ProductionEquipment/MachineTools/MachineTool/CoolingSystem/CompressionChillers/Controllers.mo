within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.CoolingSystem.CompressionChillers;
package Controllers

  model PID_lim_Controller_TEva
    Modelica.Blocks.Sources.Constant T_Eva_target(k=T_target)          annotation (
        Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-10,38})));

    Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
            extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},
              {-100,10}})));
    Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
            extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
              10}})));
    parameter Real T_target=15                                                    "Target temperature of cooled water at evaporator outlet";
    Modelica.Blocks.Continuous.LimPID PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      k=k,
      Ti=Ti,
      Td=Td,
      yMax=0.2,
      yMin=0,
      Nd=1)   annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    parameter .Modelica.Blocks.Types.SimpleController controllerType=Modelica.Blocks.Types.SimpleController.PID
                                                       "Type of controller";

    parameter Real k=-0.4
                       "Gain of controller";
    parameter SI.Time Ti=600 "Time constant of Integrator block";
    parameter SI.Time Td=20 "Time constant of Derivative block";
  equation
    connect(PID1.y, y)
      annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
    connect(T_Eva_target.y, PID1.u_s)
      annotation (Line(points={{1,38},{18,38},{18,0},{38,0}}, color={0,0,127}));
    connect(u, PID1.u_m) annotation (Line(points={{-110,0},{-36,0},{-36,-20},{50,-20},{50,-12}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), Diagram(coordinateSystem(preserveAspectRatio=false))));
  end PID_lim_Controller_TEva;

  model disk_control_hysteresis_Frank
    Modelica.Blocks.Logical.Hysteresis hysteresis(
      uLow=283.15,
      uHigh=T_target_coldWater,
      pre_y_start=false)
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Modelica.Blocks.Sources.Constant const(k=1)
      annotation (Placement(transformation(extent={{-40,24},{-20,44}})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{-40,-38},{-20,-18}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{12,-10},{32,10}})));
    Modelica.Blocks.Interfaces.RealInput u annotation (Placement(
          transformation(extent={{-124,-12},{-100,12}}), iconTransformation(extent={{-124,-12},{-100,12}})));
    Modelica.Blocks.Interfaces.RealOutput y
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));

      parameter Modelica.SIunits.ThermodynamicTemperature T_target_coldWater=288.15;

  equation
    connect(const.y, switch1.u1) annotation (Line(points={{-19,34},{-6,34},{-6,8},{10,8}},
                              color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{-19,-28},{-4,-28},{-4,-8},{10,-8}},
                                   color={0,0,127}));
    connect(hysteresis.y, switch1.u2)
      annotation (Line(points={{-29,0},{10,0}},   color={255,0,255}));
    connect(switch1.y, y)
      annotation (Line(points={{33,0},{110,0}},   color={0,0,127}));
    connect(u, hysteresis.u) annotation (Line(points={{-112,0},{-52,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)));
  end disk_control_hysteresis_Frank;
end Controllers;
