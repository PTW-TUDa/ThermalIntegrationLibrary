within ThermalIntegrationLib.ProductionEquipment.CleaningMachines;
package EiB_CleaningMachine1Tank_electrical
  package TankHeating
    model Tank1_heating
      parameter Modelica.SIunits.Power P_heat "Electrical power of tank heating";
      parameter Real eta_heat "Efficiency factor of electrical heating (0-1)";
      parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
      parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";

      parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid";
      parameter Modelica.SIunits.Area A_t1 "Surface area of tank";
      parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";

      parameter Modelica.SIunits.Length d_ins "Thickness insulation";
      parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation";

      parameter Integer washingTable[:,1]=fill(0,1,1);
      Integer rows = size(washingTable,1);

      Real T_t1(start=341.15),
           Q_dot_t1(start=0),
           Q_dot_hall(start = 0);

      Modelica.Blocks.Interfaces.IntegerInput state
        annotation (Placement(transformation(extent={{-120,20},{-100,40}}),  iconTransformation(extent={{-120,20},
                {-100,40}})));
      Modelica.Blocks.Interfaces.RealInput Q_dot_batch
        annotation (Placement(transformation(extent={{-120,-40},{-100,-20}}), iconTransformation(extent={{-120,
                -40},{-100,-20}})));
      Modelica.Blocks.Interfaces.RealOutput P_el
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput t1_state
        annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      Modelica.Blocks.Interfaces.RealInput T_amb
        annotation (Placement(transformation(extent={{-120,70},{-100,90}}), iconTransformation(extent={{-120,70},{-100,90}})));
      Modelica.Blocks.Interfaces.RealInput T_batch
        annotation (Placement(transformation(extent={{-120,-90},{-100,-70}}), iconTransformation(extent={{-120,-90},{-100,-70}})));
      Modelica.Blocks.Interfaces.RealOutput T1 annotation (Placement(transformation(extent={{100,50},{120,70}})));
      Modelica.Blocks.Interfaces.BooleanOutput heating annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,110})));
    protected
      Real a_H2O = 350,
           a_air = 8,
           d_tt = 0.002,
           lambda_tt = 20,
           k = 1/(1/a_H2O+d_tt/lambda_tt+d_ins/lambda_ins+1/a_air);
                        // heat transfer coefficient resting water [W/m^2K]
                      // heat transfer coefficient air [W/m^2K]
                         // thickness wall without insulation [m]
                           // thermal conductivity stainless steel [W/mK]

    initial equation
      pre(heating) = false;

    equation
      heating = T_t1 <= T_lim or pre(heating) and T_t1 < T_req; // state tank1 heating on/off

      if state < washingTable[1,1] or state > washingTable[rows,1] then // cleaning NOT in progress, fluid stays in tank
        Q_dot_hall = (T_t1-T_amb)*k*A_t1; // heat transfere to hall
        t1_state = false; // fluid is not in contact with batch
        if heating then // heating on, plus heat extraction by tankwall
          Q_dot_t1 = eta_heat*P_heat - Q_dot_hall;
          P_el = P_heat;
        else // heating off, only heat extraction by tankwall
          Q_dot_t1 = -Q_dot_hall;
          P_el = 0;
        end if;
      else // cleaning in progress, heat extraction by batch
        t1_state = true; // fluid is in contact with batch
        Q_dot_t1 = -Q_dot_batch;
        P_el = 0;
        Q_dot_hall = 0; // what is heat transfere to hall while cleaning?
      end if;

      der(T_t1) = Q_dot_t1/(m_t1*c_fluid); // tank1 temperature slope

      T1 = T_t1;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-64,34}},
              color={0,0,0},
              thickness=0.5),
            Text(
              extent={{-60,-66},{60,-100}},
              lineColor={0,0,0},
              textString="T1"),
            Rectangle(
              extent={{-40,-40},{40,-46}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-30,-40},{-30,80},{-20,86},{-10,80},{-8,0},{0,-8},{8,0},{10,80},{20,86},{30,80},
                  {30,-40}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Line(
              points={{-26,-40},{-26,76},{-20,82},{-14,76},{-12,-4},{0,-12},{12,-4},{14,76},{20,82},{26,
                  76},{26,-40}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Rectangle(
              extent={{-30,-52},{-20,-60}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Rectangle(
              extent={{20,-52},{30,-60}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Rectangle(
              extent={{-42,-46},{42,-52}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Rectangle(
              extent={{-6,-52},{6,-60}},
              lineColor={0,0,0},
              lineThickness=0.5)}),          Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Tank1_heating;

  end TankHeating;

  package MechanicalProcesses
    model mech_processes
      parameter Real CustomStateTable[:,2]=fill(0,2,2) "Custom state definition(washing mode = first column, el. Power [kW] = second column)";
      Integer rows = size(CustomStateTable,1);
      Modelica.Blocks.Interfaces.RealOutput P_el
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Interfaces.IntegerInput state
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    algorithm
      for i in 1:rows loop
    //     when state == CustomStateTable[i,1] then
    //       P_el := CustomStateTable[i,2];
    //     end when;
        if state == CustomStateTable[i,1] then
          P_el := CustomStateTable[i,2];
        else
          P_el := 0;
        end if;
      end for;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Rectangle(
              extent={{-70,50},{-10,-10}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.None),
            Ellipse(
              extent={{-70,-30},{-10,-90}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.None),
            Polygon(
              points={{10,-10},{40,50},{70,-10},{10,-10}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.None),
            Polygon(
              points={{58,-90},{22,-90},{10,-60},{40,-30},{70,-60},{58,-90}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.None),
            Text(
              extent={{-80,100},{80,60}},
              lineColor={0,0,0},
              textString="mech proc")}),
                                     Diagram(coordinateSystem(preserveAspectRatio=false)));
    end mech_processes;

  end MechanicalProcesses;

  package Batches
    model batch
      parameter Modelica.SIunits.Mass m_batch "Mass of batch";
      parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";

      parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
      parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";
      Real T_batch,
           Q_dot_batch(start=0);
      Modelica.Blocks.Interfaces.BooleanInput t1_state annotation (Placement(transformation(extent={{-160,110},{-140,130}}),
                                       iconTransformation(extent={{-160,110},{-140,130}})));
      Modelica.Blocks.Interfaces.RealInput T_t1 annotation (Placement(transformation(extent={{-160,50},{-140,
                70}}),       iconTransformation(extent={{-160,50},{-140,70}})));
      Modelica.Blocks.Interfaces.RealInput tank_time annotation (Placement(transformation(extent={{-160,-10},
                {-140,10}}),     iconTransformation(extent={{-160,-10},{-140,10}})));
      Modelica.Blocks.Interfaces.BooleanInput new_batch annotation (Placement(transformation(extent={{-160,-70},
                {-140,-50}}),          iconTransformation(extent={{-160,-70},{-140,-50}})));
      Modelica.Blocks.Interfaces.RealInput T_amb annotation (Placement(transformation(extent={{-160,-130},{-140,
                -110}}),      iconTransformation(extent={{-160,-130},{-140,-110}})));
      Modelica.Blocks.Interfaces.RealOutput q_dot_batch
        annotation (Placement(transformation(extent={{140,60},{160,80}})));
      Modelica.Blocks.Interfaces.RealOutput t_batch
        annotation (Placement(transformation(extent={{140,-80},{160,-60}})));
    initial equation
      T_batch = T_amb;
    equation

      if t1_state then // cleaning in progress, heat extraction by batch
        Q_dot_batch = (m_batch*c_batch+m_rack*c_rack)*(T_t1-T_batch)/tank_time;
      else // cleaning NOT in progress
        Q_dot_batch = 0;
      end if;

      der(T_batch) = Q_dot_batch/((m_batch*c_batch+m_rack*c_rack)); // batch temperature slope

      t_batch = T_batch;
      q_dot_batch = Q_dot_batch;

      when edge(new_batch) then
        reinit(T_batch, T_amb);
      end when;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}}),
                                                                    graphics={
            Rectangle(
              extent={{-140,140},{140,-140}},
              lineColor={0,0,0},
              lineThickness=0.5,
              fillColor={0,0,0},
              fillPattern=FillPattern.None),
            Polygon(
              points={{0,80},{-120,28},{0,-20},{120,28},{0,80}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-60,4},{-120,-22},{0,-70},{120,-22},{60,4}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-60,-46},{-120,-72},{0,-120},{120,-72},{60,-46}},
              color={0,0,0},
              thickness=0.5),
            Text(
              extent={{-100,140},{100,80}},
              lineColor={0,0,0},
              textString="batch")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
    end batch;

    model hot_batches
      parameter Modelica.SIunits.Mass m_batch "Mass of batch";
      parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";
      parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
      parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";
      parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
      Modelica.Blocks.Interfaces.BooleanInput new_batch
        annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),iconTransformation(extent={{-140,
                -60},{-100,-20}})));
      single_hot_batch single_hot_batch1(
        m_batch=m_batch,
        c_batch=c_batch,
        m_rack=m_rack,
        c_rack=c_rack,
        T_req=T_req,                     batch_number=1)
        annotation (Placement(transformation(extent={{-10,70},{10,90}})));
      Modelica.Blocks.Interfaces.RealInput T_hall
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.RealOutput Q_dot
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      Modelica.Blocks.Math.MultiSum multiSum(nu=5)
        annotation (Placement(transformation(extent={{54,-6},{66,6}})));
      single_hot_batch single_hot_batch2(
        m_batch=m_batch,
        c_batch=c_batch,
        m_rack=m_rack,
        c_rack=c_rack,
        T_req=T_req,
        batch_number=2)
        annotation (Placement(transformation(extent={{-10,30},{10,50}})));
      single_hot_batch single_hot_batch3(
        m_batch=m_batch,
        c_batch=c_batch,
        m_rack=m_rack,
        c_rack=c_rack,
        T_req=T_req,
        batch_number=3)
        annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
      single_hot_batch single_hot_batch4(
        m_batch=m_batch,
        c_batch=c_batch,
        m_rack=m_rack,
        c_rack=c_rack,
        T_req=T_req,
        batch_number=4)
        annotation (Placement(transformation(extent={{-12,-50},{8,-30}})));
      single_hot_batch single_hot_batch5(
        m_batch=m_batch,
        c_batch=c_batch,
        m_rack=m_rack,
        c_rack=c_rack,
        T_req=T_req,
        batch_number=5)
        annotation (Placement(transformation(extent={{-12,-90},{8,-70}})));
      batch_controller batch_controller1 annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    equation
      connect(new_batch, batch_controller1.new_batch) annotation (Line(points={{-120,-40},{-81,-40}},
                                                                                                  color={255,0,255}));
      connect(T_hall, single_hot_batch1.T_hall)
        annotation (Line(points={{-120,40},{-50,40},{-50,84},{-12,84}}, color={0,0,127}));
      connect(Q_dot, multiSum.y) annotation (Line(points={{110,0},{67.02,0}}, color={0,0,127}));
      connect(single_hot_batch1.Q_dot_single_hot_batch, multiSum.u[1])
        annotation (Line(points={{11,80},{40,80},{40,3.36},{54,3.36}}, color={0,0,127}));
      connect(single_hot_batch5.T_hall, T_hall) annotation (Line(points={{-14,-76},{-50,-76},{-50,40},{-120,40}}, color={0,0,127}));
      connect(single_hot_batch3.T_hall, T_hall) annotation (Line(points={{-14,4},{-50,4},{-50,40},{-120,40}}, color={0,0,127}));
      connect(single_hot_batch2.T_hall, single_hot_batch1.T_hall)
        annotation (Line(points={{-12,44},{-50,44},{-50,84},{-12,84}}, color={0,0,127}));
      connect(single_hot_batch4.T_hall, T_hall) annotation (Line(points={{-14,-36},{-50,-36},{-50,40},{-120,40}}, color={0,0,127}));
      connect(single_hot_batch3.batch_nr, single_hot_batch1.batch_nr)
        annotation (Line(points={{-14,-5},{-40,-5},{-40,75},{-12,75}}, color={255,127,0}));
      connect(single_hot_batch2.batch_nr, single_hot_batch1.batch_nr)
        annotation (Line(points={{-12,35},{-40,35},{-40,75},{-12,75}}, color={255,127,0}));
      connect(single_hot_batch2.Q_dot_single_hot_batch, multiSum.u[2])
        annotation (Line(points={{11,40},{40,40},{40,1.68},{54,1.68}}, color={0,0,127}));
      connect(single_hot_batch3.Q_dot_single_hot_batch, multiSum.u[3])
        annotation (Line(points={{9,0},{32,0},{32,0},{54,0}}, color={0,0,127}));
      connect(single_hot_batch4.Q_dot_single_hot_batch, multiSum.u[4])
        annotation (Line(points={{9,-40},{42,-40},{42,-1.68},{54,-1.68}}, color={0,0,127}));
      connect(single_hot_batch5.Q_dot_single_hot_batch, multiSum.u[5])
        annotation (Line(points={{9,-80},{42,-80},{42,-3.36},{54,-3.36}}, color={0,0,127}));
      connect(single_hot_batch5.batch_nr, batch_controller1.batch_number)
        annotation (Line(points={{-14,-85},{-40,-85},{-40,-40},{-59,-40}}, color={255,127,0}));
      connect(single_hot_batch3.batch_nr, batch_controller1.batch_number)
        annotation (Line(points={{-14,-5},{-40,-5},{-40,-40},{-59,-40}}, color={255,127,0}));
      connect(batch_controller1.batch_number, single_hot_batch4.batch_nr)
        annotation (Line(points={{-59,-40},{-40,-40},{-40,-45},{-14,-45}}, color={255,127,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-60,-52},{-80,-58},{-60,-64},{-40,-58},{-60,-52}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-68,-62},{-80,-66},{-60,-72},{-40,-66},{-52,-62}},
              color={0,0,0},
              thickness=0.5),
            Text(
              extent={{-80,100},{80,40}},
              lineColor={0,0,0},
              textString="hot batches"),
            Line(
              points={{-60,-22},{-64,-34},{-56,-42},{-60,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-68,-70},{-80,-74},{-60,-80},{-40,-74},{-52,-70}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-50,-22},{-54,-34},{-46,-42},{-50,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-70,-22},{-74,-34},{-66,-42},{-70,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Polygon(
              points={{60,-52},{40,-58},{60,-64},{80,-58},{60,-52}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{52,-62},{40,-66},{60,-72},{80,-66},{68,-62}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{60,-22},{56,-34},{64,-42},{60,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{52,-70},{40,-74},{60,-80},{80,-74},{68,-70}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{70,-22},{66,-34},{74,-42},{70,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{50,-22},{46,-34},{54,-42},{50,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Polygon(
              points={{0,-52},{-20,-58},{0,-64},{20,-58},{0,-52}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-8,-62},{-20,-66},{0,-72},{20,-66},{8,-62}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{0,-22},{-4,-34},{4,-42},{0,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-8,-70},{-20,-74},{0,-80},{20,-74},{8,-70}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{10,-22},{6,-34},{14,-42},{10,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-10,-22},{-14,-34},{-6,-42},{-10,-50}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Polygon(
              points={{-30,18},{-50,12},{-30,6},{-10,12},{-30,18}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-38,8},{-50,4},{-30,-2},{-10,4},{-22,8}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-30,48},{-34,36},{-26,28},{-30,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-38,0},{-50,-4},{-30,-10},{-10,-4},{-22,0}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-20,48},{-24,36},{-16,28},{-20,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-40,48},{-44,36},{-36,28},{-40,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Polygon(
              points={{30,18},{10,12},{30,6},{50,12},{30,18}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{22,8},{10,4},{30,-2},{50,4},{38,8}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{30,48},{26,36},{34,28},{30,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{22,0},{10,-4},{30,-10},{50,-4},{38,0}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{40,48},{36,36},{44,28},{40,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{20,48},{16,36},{24,28},{20,20}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end hot_batches;

    model batch_controller
      Integer counter;
      Modelica.Blocks.Interfaces.BooleanInput new_batch
        annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
      Modelica.Blocks.Interfaces.IntegerOutput batch_number annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    initial algorithm
      counter :=0;

    algorithm
      when edge(new_batch) then
        if counter >= 5 then
          counter :=1;
        else
          counter :=counter + 1;
        end if;
      end when;

      batch_number :=counter;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5), Text(
              extent={{-80,100},{80,-100}},
              lineColor={0,0,0},
              textString="batch
ctrl")}),                                                            Diagram(coordinateSystem(preserveAspectRatio=false)));
    end batch_controller;

    model single_hot_batch
      parameter Modelica.SIunits.Mass m_batch "Mass of batch";
      parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";
      parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
      parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";
      parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
      parameter Integer batch_number;
      Real T(start=T_req);

      Modelica.Blocks.Interfaces.IntegerInput batch_nr
        annotation (Placement(transformation(extent={{-140,-70},{-100,-30}}),iconTransformation(extent={{-140,
                -70},{-100,-30}})));
      Modelica.Blocks.Interfaces.RealInput T_hall
        annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
      Modelica.Blocks.Interfaces.RealOutput Q_dot_single_hot_batch
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation
      when batch_nr == batch_number then
        reinit(T, T_req);
      end when;

      if batch_nr == batch_number then
        Q_dot_single_hot_batch = 0.06*(T-T_hall);
        (c_batch*m_batch+c_rack*m_rack)*der(T) = Q_dot_single_hot_batch;
      else
        der(T) = 0;
        Q_dot_single_hot_batch = 0;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Polygon(
              points={{0,-18},{-60,-38},{0,-58},{60,-38},{0,-18}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-30,-48},{-60,-58},{0,-78},{60,-58},{30,-48}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-30,-68},{-60,-78},{0,-98},{60,-78},{30,-68}},
              color={0,0,0},
              thickness=0.5),
            Text(
              extent={{-80,100},{80,40}},
              lineColor={0,0,0},
              textString="hot batch"),
            Line(
              points={{-40,-12}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{0,46},{-10,24},{10,4},{0,-14}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{-30,46},{-40,24},{-20,4},{-30,-14}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None}),
            Line(
              points={{30,46},{20,24},{40,4},{30,-14}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier,
              arrow={Arrow.Filled,Arrow.None})}),                    Diagram(coordinateSystem(preserveAspectRatio=false)));
    end single_hot_batch;
  end Batches;

  package ProcessingProgramms
    model stateController
      parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
      parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";
      parameter Integer stateTable[:,2]=fill(0,1,2) "first col state, sec col duration in s";
      parameter Integer washingTable[:,1]=fill(0,1,1);
      Integer rows = size(stateTable,1),
              rows2 = size(washingTable,1),
              i;
      Real dur_mt1,
           t_in_state;
      Boolean ready;
      Modelica.Blocks.Interfaces.IntegerOutput state annotation (Placement(transformation(extent={{100,50},{
                120,70}})));
      Modelica.Blocks.Interfaces.RealOutput tank_time annotation (Placement(transformation(extent={{100,-10},
                {120,10}})));
      Modelica.Blocks.Interfaces.BooleanOutput new_batch annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
      Modelica.Blocks.Interfaces.IntegerInput opMode
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput T_mt annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-50,-120})));
      Modelica.Blocks.Interfaces.BooleanInput heating annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=90,
            origin={48,-120})));
    protected
           Modelica.SIunits.Time startTime;
           Boolean washing;

    algorithm
       dur_mt1 := 0;
       for j in 1:rows loop
         if stateTable[i,1] >= washingTable[1,1] and stateTable[i,1] <= washingTable[rows2,1] then // Add time for cleaning with MT1
           dur_mt1 := dur_mt1 + stateTable[j,2];
         else
           dur_mt1 := dur_mt1 + 0;
         end if;
       end for;

    initial equation
      i = 1;
      t_in_state = stateTable[1,2];
      pre(ready) = false;

    equation

      if heating then // tank is heating
        ready = T_mt>=T_req or i<rows; // heating done if T_req is reached
      else // no heating active
        ready = T_mt>T_lim or i<rows; // machine remains ready until the temperature of tank falls below T_lim
      end if; // the condition 'i<rows' ensures that the washing cycle is not interrupted

      when time >= pre(t_in_state) and opMode == 3 and pre(ready) then // next state reached
       if pre(i) >= rows or opMode > pre(opMode) then // if cleaning programm is finished or if operation mode is changing to 'working', start over again
         i = 1;
         new_batch = true; // (problem to fix) stays true for duration of first state
       else // else go to next state
         i = pre(i) + 1;
         new_batch = false;
       end if;
       t_in_state= time + stateTable[i, 2];
      end when;

      if stateTable[i,1] == washingTable[1,1] then // cleaning process with MT is running
        washing = true;
      else
        washing = false;
      end if;

      when edge(washing) then // set startTime to actuall sim-time when cleaning process startet
        startTime = time;
      end when;

      if stateTable[i,1] >= washingTable[1,1] and stateTable[i,1] <= washingTable[rows2,1] then // if cleaning with MT1 is running, set tank_time to remaining time in cleaning
        tank_time = dur_mt1 - (time-startTime) + 0.000001;
      else
        tank_time = 1;
      end if;

      if opMode == 1 then // Operation mode is 'off'
        state = 1;
      elseif opMode == 2 or not pre(ready) then // Operation mode is 'standby'
        state = 2;
      else // Operation mode is 'working'
        state = stateTable[i, 1];
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
              extent={{-80,40},{-20,10}},
              lineThickness=0.5,
              pattern=LinePattern.None,
              lineColor={0,0,0},
              fillColor={215,215,215},
              fillPattern=FillPattern.Solid),
            Line(points={{-40,-30}}, color={0,0,0}),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Rectangle(
              extent={{-80,40},{-20,-80}},
              lineColor={0,0,0},
              lineThickness=0.5),
            Line(
              points={{-50,40},{-50,-80}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-80,10},{-20,10}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-80,-20},{-20,-20}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-80,-50},{-20,-50}},
              color={0,0,0},
              thickness=0.5),
            Text(
              extent={{-48,34},{-22,16}},
              lineColor={0,0,0},
              textString="state"),
            Text(
              extent={{-78,34},{-52,16}},
              lineColor={0,0,0},
              textString="t"),
            Line(
              points={{-20,-20},{20,-20},{20,40},{60,40}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Line(
              points={{-20,-20},{20,-20},{20,-80},{60,-80}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Line(
              points={{60,46},{60,34},{72,40},{60,46}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{60,-34},{60,-46},{72,-40},{60,-34}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{60,-74},{60,-86},{72,-80},{60,-74}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{60,6},{60,-6},{72,0},{60,6}},
              color={0,0,0},
              thickness=0.5),
            Line(
              points={{-20,-20},{20,-20},{30,-40},{60,-40}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Line(
              points={{-20,-20},{20,-20},{30,0},{60,0}},
              color={0,0,0},
              thickness=0.5,
              smooth=Smooth.Bezier),
            Text(
              extent={{-60,100},{60,60}},
              lineColor={0,0,0},
              textString="stc")}),Diagram(coordinateSystem(preserveAspectRatio=false)));
    end stateController;

  end ProcessingProgramms;

  package TechnicalConfiguration
    package BaseClasses
      record TechnicalConfiguration_base

        parameter Modelica.SIunits.Mass m_batch "Mass of batch" annotation(Dialog(tab = "Batch", group = "Batch"));
        parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch" annotation(Dialog(tab = "Batch", group = "Batch"));

        parameter Modelica.SIunits.Mass m_rack "Mass of batching rack" annotation(Dialog(tab = "Batch", group = "Batching rack"));
        parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack" annotation(Dialog(tab = "Batch", group = "Batching rack"));

        parameter Modelica.SIunits.Power P_heat "Electrical power of tank heating" annotation(Dialog(tab = "Tanks", group = "Heating"));
        parameter Real eta_heat "Efficiency factor of electrical heating (0-1)" annotation(Dialog(tab = "Tanks", group = "Heating"));
        parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Heating"));
        parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Heating"));

        parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
        parameter Modelica.SIunits.Area A_t1 "Surface area of tank" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));
        parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid" annotation(Dialog(tab = "Tanks", group = "Tank parameters"));

        parameter Modelica.SIunits.Length d_ins "Thickness insulation" annotation(Dialog(tab = "Insulation"));
        parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation" annotation(Dialog(tab = "Insulation"));

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
                preserveAspectRatio=false)));
      end TechnicalConfiguration_base;
    end BaseClasses;

    record TechnicalConfiguration_a
      extends BaseClasses.TechnicalConfiguration_base(
      m_batch = 50,
      c_batch = 0.477,
      m_rack = 132,
      c_rack = 0.477,
      P_heat = 10000,
      eta_heat = 0.98,
      T_req = 343.15,
      T_lim = 341.15,
      m_t1 = 540,
      A_t1 = 2.49138,
      c_fluid = 4186,
      d_ins = 0.021,
      lambda_ins = 0.04);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end TechnicalConfiguration_a;

    record TechnicalConfiguration_htk
     extends BaseClasses.TechnicalConfiguration_base(
      m_batch = 150,
      c_batch = 0.477,
      m_rack = 50,
      c_rack = 0.477,
      P_heat = 22700,
      eta_heat = 0.98,
      T_req = 339.45,
      T_lim = 337.45,
      m_t1 = 600,
      A_t1 = 2.49138,
      c_fluid = 4186,
      d_ins = 0,
      lambda_ins = 0.04);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end TechnicalConfiguration_htk;

  end TechnicalConfiguration;

  model EiB_CleaningMachine1Tank_electrical
    extends ThermalIntegrationLib.ProductionEquipment.BaseClasses.BaseProductionEquipment(
      electricDemands=1,
      ID=1,
      coolDemands=0,
      m=1300,
      cp=0.5,
      TInitial=298.15,
      heatDemands=0,
      tableOperationMode=[0,3; 28800,3],
      operationModes=3);
      parameter Integer tableProcessingProgramm[:,2]=[6,15; 3,80; 4,120; 5,320; 7,15]
                    "Washing programm (washing mode = first column, duration in s = second column)";
      parameter Real tableStates[:,2]=[1,0; 2,0; 3,5500; 4,1780; 5,1100; 6,0; 7,0]
                                                                           "State power definition for mechanical processes, heating power excluded (washing mode = first column, el. Power [W] = second column)";
      parameter Integer tableWashing[:,1]=[3] "States when washing is active";
    replaceable parameter
      ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.TechnicalConfiguration.TechnicalConfiguration_htk
      TechnicalConfiguration constrainedby
      ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base;
    Modelica.Blocks.Math.MultiSum Sum_elPow(k={0.001,0.001,0.001},
                                            nu=3)
                                            annotation (Placement(transformation(extent={{128,-6},{140,
              6}})));
    .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.TankHeating.Tank1_heating
      tank1_heating(
      P_heat=TechnicalConfiguration.P_heat,
      eta_heat=TechnicalConfiguration.eta_heat,
      T_req=TechnicalConfiguration.T_req,
      T_lim=TechnicalConfiguration.T_lim,
      m_t1=TechnicalConfiguration.m_t1,
      A_t1=TechnicalConfiguration.A_t1,
      c_fluid=TechnicalConfiguration.c_fluid,
      d_ins=TechnicalConfiguration.d_ins,
      lambda_ins=TechnicalConfiguration.lambda_ins,
                    T_t1(start=298.15), washingTable=tableWashing)
                                        annotation (Placement(transformation(extent={{2,-20},{22,0}})));
    .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.Batches.batch
      batch(
      m_batch=TechnicalConfiguration.m_batch,
      c_batch=TechnicalConfiguration.c_batch,
      m_rack=TechnicalConfiguration.m_rack,
      c_rack=TechnicalConfiguration.c_rack)
            annotation (Placement(transformation(extent={{66,-94},{94,-66}})));
    .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.ProcessingProgramms.stateController
      stateController(
      T_req=TechnicalConfiguration.T_req,
      T_lim=TechnicalConfiguration.T_lim,
                      stateTable=tableProcessingProgramm, washingTable=tableWashing)
      annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
    Modelica.Blocks.Sources.RealExpression T_amb(y=298.15) annotation (Placement(transformation(extent={{-92,-102},{-72,-82}})));
    Modelica.Blocks.Sources.RealExpression elBaseLoad(y=0.2) annotation (Placement(transformation(extent={{96,-130},{108,-120}})));
    Modelica.Blocks.Math.MultiSum Sum_Qhall(nu=2) annotation (Placement(transformation(extent={{-86,74},{-74,86}})));
    Modelica.Blocks.Sources.RealExpression Q_dot_hall_T1(y=tank1_heating.Q_dot_hall)
      annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
    .ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.Batches.hot_batches
      hot_batches(
      m_batch=TechnicalConfiguration.m_batch,
      c_batch=TechnicalConfiguration.c_batch,
      m_rack=TechnicalConfiguration.m_rack,
      c_rack=TechnicalConfiguration.c_rack,
      T_req=TechnicalConfiguration.T_req)
                  annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-80,-60})));
    Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode)
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
    Modelica.Blocks.Sources.RealExpression T_mt(y=tank1_heating.T1) annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-87,-27})));
    Modelica.Blocks.Sources.BooleanExpression heating(y=tank1_heating.heating) annotation (Placement(
          transformation(
          extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-77,-27})));
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_electrical.MechanicalProcesses.mech_processes mech_processes(
        CustomStateTable=tableStates) annotation (Placement(transformation(extent={{0,80},{20,100}})));
  equation
    electricDemand[1].Power[1] = Sum_elPow.y;
    electricDemand[1].Power[2] = Sum_elPow.y;
    electricDemand[1].Power[3] = Sum_elPow.y;
    dissipationFlowRate = Sum_Qhall.y * 1000;

    connect(batch.tank_time, stateController.tank_time) annotation (Line(points={{65,-80},{-56,-80},{-56,0},
            {-71,0}},                                                                                                   color={0,0,127}));
    connect(stateController.new_batch, batch.new_batch) annotation (Line(points={{-71,-6},{-60,-6},{-60,-86},{65,-86}}, color={255,0,255}));
    connect(tank1_heating.T_amb, T_amb.y) annotation (Line(points={{1,-2},{-32,-2},{-32,-92},{-71,-92}},    color={0,0,127}));
    connect(tank1_heating.T1, batch.T_t1) annotation (Line(points={{23,-4},{34,-4},{34,-74},{65,-74}}, color={0,0,127}));
    connect(batch.T_amb, T_amb.y) annotation (Line(points={{65,-92},{-71,-92}},                      color={0,0,127}));
    connect(batch.q_dot_batch, tank1_heating.Q_dot_batch)
      annotation (Line(points={{95,-73},{106,-73},{106,-62},{-12,-62},{-12,-13},{1,-13}},   color={0,0,127}));
    connect(batch.t_batch, tank1_heating.T_batch)
      annotation (Line(points={{95,-87},{112,-87},{112,-54},{-6,-54},{-6,-18},{1,-18}},     color={0,0,127}));
    connect(Sum_Qhall.u[1], Q_dot_hall_T1.y) annotation (Line(points={{-86,82.1},{-92,82.1},{-92,90},{-99,90}},    color={0,0,127}));
    connect(hot_batches.new_batch, batch.new_batch)
      annotation (Line(points={{-68,-56},{-60,-56},{-60,-86},{65,-86}}, color={255,0,255}));
    connect(stateController.opMode, integerExpression.y)
      annotation (Line(points={{-94,0},{-99,0}},   color={255,127,0}));
    connect(hot_batches.T_hall, T_amb.y) annotation (Line(points={{-68,-64},{-64,-64},{-64,-92},{-71,
            -92}},                                                                                          color={0,0,127}));
    connect(hot_batches.Q_dot, Sum_Qhall.u[2]) annotation (Line(points={{-91,-60},{-130,-60},{-130,77.9},
            {-86,77.9}},                                                                                              color={0,0,127}));
    connect(tank1_heating.P_el, Sum_elPow.u[1])
      annotation (Line(points={{23,-10},{122,-10},{122,-16},{128,-16},{128,2.8}},   color={0,0,127}));
    connect(elBaseLoad.y, Sum_elPow.u[2])
      annotation (Line(points={{108.6,-125},{120,-125},{120,-16},{128,-16},{128,4.44089e-16}},
                                                                                         color={0,0,127}));
    connect(stateController.T_mt, T_mt.y)
      annotation (Line(points={{-87,-12},{-87,-19.3}}, color={0,0,127}));
    connect(heating.y, stateController.heating)
      annotation (Line(points={{-77,-19.3},{-77.2,-19.3},{-77.2,-12}}, color={255,0,255}));
    connect(tank1_heating.t1_state, batch.t1_state)
      annotation (Line(points={{23,-16},{40,-16},{40,-68},{65,-68}}, color={255,0,255}));
    connect(mech_processes.P_el, Sum_elPow.u[3])
      annotation (Line(points={{21,90},{120,90},{120,-10},{128,-10},{128,-2.8}}, color={0,0,127}));
    connect(stateController.state, mech_processes.state)
      annotation (Line(points={{-71,6},{-6,6},{-6,90},{-1,90}}, color={255,127,0}));
    connect(stateController.state, tank1_heating.state)
      annotation (Line(points={{-71,6},{-6,6},{-6,-7},{1,-7}},  color={255,127,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}}), graphics={
                                                                        Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Bitmap(extent={{-80,-80},{80,80}}, fileName="modelica://ThermalIntegrationLib/Resources/Icon-Maschine.png"),
          Text(
            extent={{-160,140},{160,110}},
            textColor={106,106,106},
            textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,140}})));
  end EiB_CleaningMachine1Tank_electrical;
end EiB_CleaningMachine1Tank_electrical;
