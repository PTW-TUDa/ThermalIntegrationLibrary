within ThermalIntegrationLibrary.BaseClasses.Internals;
model ControlUnit

  parameter String calcType = "Step"
    "Calculation type for progression between prescribed values"
    annotation(choices(
      choice="Step",
      choice="Linear",
      choice="Smooth",
      choice="Constant"));

  parameter Integer points = 20
    "Number of sampling points must be between 2 and 20"
    annotation(Dialog(enable=(choice=="Step" or choice=="Linear" or choice=="Smooth")));
  parameter Real startValue = 0 "Value at begin of observation period (Time=0)";
  parameter Real[auxPoints] inputValue = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    "20 parameters needs to be defined, but only the number of sampling points will be calculated"
    annotation(Dialog(enable=(choice=="Step" or choice=="Linear" or choice=="Smooth")));
  parameter SI.Time startTime=0 "Begin of observation period"
    annotation (Dialog(enable=(choice == "Step" or choice == "Linear" or
          choice == "Smooth")));
  parameter SI.Period stepPeriod=600
    "Time between two sampling points" annotation (Dialog(enable=(choice ==
          "Step" or choice == "Linear" or choice == "Smooth")));
  parameter SI.Period firstStepPeriod=2400
    "Time between begin and first sampling point" annotation (Dialog(enable=(
          choice == "Step" or choice == "Linear" or choice == "Smooth")));

  Modelica.Blocks.Interfaces.RealOutput y "Output value" annotation (Placement(transformation(extent={{96,-10},{116,10}})));

protected
  Real[auxPoints] weightingFactor
    "For smooth operator. Differs between 0 and 1";
  Real[auxPoints] auxValue "Calculation for each y";
  constant Integer i = 4 "For weightingFactor calculation";
  constant Integer j = 1 "For auxValue calculation";
  constant Integer auxPoints = 20;

equation
/************************* WeightingFactors ********************************/
  weightingFactor[1] = ThermalIntegrationLibrary.BaseClasses.Internals.smoothTransition(
    time,
    startTime + firstStepPeriod/2.0,
    firstStepPeriod);
  weightingFactor[2] = ThermalIntegrationLibrary.BaseClasses.Internals.smoothTransition(
    time,
    startTime + firstStepPeriod + stepPeriod/2.0,
    stepPeriod);
  weightingFactor[3] = ThermalIntegrationLibrary.BaseClasses.Internals.smoothTransition(
    time,
    startTime + firstStepPeriod + stepPeriod + stepPeriod/2.0,
    stepPeriod);

  for i in 4:auxPoints loop
    weightingFactor[i] = ThermalIntegrationLibrary.BaseClasses.Internals.smoothTransition(
      time,
      startTime + firstStepPeriod + stepPeriod*(i - 2) + stepPeriod/2.0,
      stepPeriod);
  end for;

/************************* Case differentiation ****************************/
//Smooth
  if (calcType == "Smooth") then

  auxValue[1] = weightingFactor[1]*startValue + (1-weightingFactor[1])*inputValue[1];

//Calculation for different numbers of sampling points
    if (points == 2) then
      auxValue[2] = weightingFactor[2]*inputValue[1] + (1-weightingFactor[2])*inputValue[2];

      for j in 3:auxPoints loop
        auxValue[j] = auxValue[2];
      end for;

    elseif (points == 3) then
      for j in 2:3 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 4:auxPoints loop
        auxValue[j] = auxValue[3];
      end for;

    elseif (points == 4) then
      for j in 2:4 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 5:auxPoints loop
        auxValue[j] = auxValue[4];
      end for;

    elseif (points == 5) then
      for j in 2:5 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 6:auxPoints loop
        auxValue[j] = auxValue[5];
      end for;

    elseif (points == 6) then
      for j in 2:6 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 7:auxPoints loop
        auxValue[j] = auxValue[6];
      end for;

    elseif (points == 7) then
      for j in 2:7 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 8:auxPoints loop
        auxValue[j] = auxValue[7];
      end for;

    elseif (points == 8) then
      for j in 2:8 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 9:auxPoints loop
        auxValue[j] = auxValue[8];
      end for;

    elseif (points == 9) then
      for j in 2:9 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 10:auxPoints loop
        auxValue[j] = auxValue[9];
      end for;

    elseif (points == 10) then
      for j in 2:10 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 11:auxPoints loop
        auxValue[j] = auxValue[10];
      end for;

    elseif (points == 11) then
      for j in 2:11 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 12:auxPoints loop
        auxValue[j] = auxValue[11];
      end for;

    elseif (points == 12) then
      for j in 2:12 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 13:auxPoints loop
        auxValue[j] = auxValue[12];
      end for;

    elseif (points == 13) then
      for j in 2:13 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 14:auxPoints loop
        auxValue[j] = auxValue[13];
      end for;

    elseif (points == 14) then
      for j in 2:14 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 15:auxPoints loop
        auxValue[j] = auxValue[14];
      end for;

    elseif (points == 15) then
      for j in 2:15 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 16:auxPoints loop
        auxValue[j] = auxValue[15];
      end for;

    elseif (points == 16) then
      for j in 2:16 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 17:auxPoints loop
        auxValue[j] = auxValue[16];
      end for;

    elseif (points == 17) then
      for j in 2:17 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 18:auxPoints loop
        auxValue[j] = auxValue[17];
      end for;

    elseif (points == 18) then
      for j in 2:18 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      for j in 19:auxPoints loop
        auxValue[j] = auxValue[18];
      end for;

    elseif (points == 19) then
      for j in 2:19 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

      auxValue[20] = auxValue[19];

    elseif (points == 20) then
      for j in 2:20 loop
        auxValue[j] = weightingFactor[j]*inputValue[j-1] + (1-weightingFactor[j])*inputValue[j];
      end for;

    end if;

//Calculation for different cases in "Smooth"
    y = if (time < startTime) then startValue
                  elseif (time < startTime+firstStepPeriod) then auxValue[1]
                  elseif (time < startTime+firstStepPeriod+stepPeriod and points >= 3) then auxValue[2]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*2 and points >= 4) then auxValue[3]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*3 and points >= 5) then auxValue[4]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*4 and points >= 6) then auxValue[5]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*5 and points >= 7) then auxValue[6]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*6 and points >= 8) then auxValue[7]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*7 and points >= 9) then auxValue[8]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*8 and points >= 10) then auxValue[9]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*9 and points >= 11) then auxValue[10]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*10 and points >= 12) then auxValue[11]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*11 and points >= 13) then auxValue[12]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*12 and points >= 14) then auxValue[13]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*13 and points >= 15) then auxValue[14]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*14 and points >= 16) then auxValue[15]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*15 and points >= 17) then auxValue[16]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*16 and points >= 18) then auxValue[17]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*17 and points >= 19) then auxValue[18]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*18 and points >= 20) then auxValue[19]
                  else auxValue[20];

//Step
  elseif (calcType == "Step") then

    for j in 1:auxPoints-1 loop
      auxValue[j] = inputValue[j];
    end for;

//Calculation for different numbers of sampling points
    if (points == 2) then
      auxValue[auxPoints] = inputValue[2];
    elseif (points == 3) then
      auxValue[auxPoints] = inputValue[3];
    elseif (points == 4) then
      auxValue[auxPoints] = inputValue[4];
    elseif (points == 5) then
      auxValue[auxPoints] = inputValue[5];
    elseif (points == 6) then
      auxValue[auxPoints] = inputValue[6];
    elseif (points == 7) then
      auxValue[auxPoints] = inputValue[7];
    elseif (points == 8) then
      auxValue[auxPoints] = inputValue[8];
    elseif (points == 9) then
      auxValue[auxPoints] = inputValue[9];
    elseif (points == 10) then
      auxValue[auxPoints] = inputValue[10];
    elseif (points == 11) then
      auxValue[auxPoints] = inputValue[11];
    elseif (points == 12) then
      auxValue[auxPoints] = inputValue[12];
    elseif (points == 13) then
      auxValue[auxPoints] = inputValue[13];
    elseif (points == 14) then
      auxValue[auxPoints] = inputValue[14];
    elseif (points == 15) then
      auxValue[auxPoints] = inputValue[15];
    elseif (points == 16) then
      auxValue[auxPoints] = inputValue[16];
    elseif (points == 17) then
      auxValue[auxPoints] = inputValue[17];
    elseif (points == 18) then
      auxValue[auxPoints] = inputValue[18];
    elseif (points == 19) then
      auxValue[auxPoints] = inputValue[19];
    elseif (points == 20) then
      auxValue[auxPoints] = inputValue[20];
    end if;

//Calculation for different cases in "Step"
    y = if (time < startTime) then startValue
                  elseif (time < startTime+firstStepPeriod and points >= 2) then auxValue[1]
                  elseif (time < startTime+firstStepPeriod+stepPeriod and points >= 3) then auxValue[2]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*2 and points >= 4) then auxValue[3]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*3 and points >= 5) then auxValue[4]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*4 and points >= 6) then auxValue[5]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*5 and points >= 7) then auxValue[6]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*6 and points >= 8) then auxValue[7]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*7 and points >= 9) then auxValue[8]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*8 and points >= 10) then auxValue[9]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*9 and points >= 11) then auxValue[10]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*10 and points >= 12) then auxValue[11]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*11 and points >= 13) then auxValue[12]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*12 and points >= 14) then auxValue[13]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*13 and points >= 15) then auxValue[14]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*14 and points >= 16) then auxValue[15]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*15 and points >= 17) then auxValue[16]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*16 and points >= 18) then auxValue[17]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*17 and points >= 19) then auxValue[18]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*18 and points >= 20) then auxValue[19]
                  else auxValue[20];

//Constant
  elseif (calcType == "Constant") then

  for j in 1:auxPoints loop
    auxValue[j] = startValue;
  end for;

    y = startValue;

//Linear
  else

    auxValue[1] = ((inputValue[1] - startValue)/firstStepPeriod)*(time-startTime) + startValue;

//Calculation for different numbers of sampling points
    if (points == 2) then
      auxValue[2] = ((inputValue[2] - inputValue[1])/stepPeriod)*(time-firstStepPeriod-startTime) + inputValue[1];

      for j in 3:auxPoints loop
        auxValue[j] = inputValue[2];
      end for;

    elseif (points == 3) then
      for j in 2:3 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 4:auxPoints loop
        auxValue[j] = inputValue[3];
      end for;

    elseif (points == 4) then
      for j in 2:4 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 5:auxPoints loop
        auxValue[j] = inputValue[4];
      end for;

    elseif (points == 5) then
      for j in 2:5 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 6:auxPoints loop
        auxValue[j] = inputValue[5];
      end for;

    elseif (points == 6) then
      for j in 2:6 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 7:auxPoints loop
        auxValue[j] = inputValue[6];
      end for;

    elseif (points == 7) then
      for j in 2:7 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 8:auxPoints loop
        auxValue[j] = inputValue[7];
      end for;

    elseif (points == 8) then
      for j in 2:8 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 9:auxPoints loop
        auxValue[j] = inputValue[8];
      end for;

    elseif (points == 9) then
      for j in 2:9 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 10:auxPoints loop
        auxValue[j] = inputValue[9];
      end for;

    elseif (points == 10) then
      for j in 2:10 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 11:auxPoints loop
        auxValue[j] = inputValue[10];
      end for;

    elseif (points == 11) then
      for j in 2:11 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 12:auxPoints loop
        auxValue[j] = inputValue[11];
      end for;

    elseif (points == 12) then
      for j in 2:12 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 13:auxPoints loop
        auxValue[j] = inputValue[12];
      end for;

    elseif (points == 13) then
      for j in 2:13 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 14:auxPoints loop
        auxValue[j] = inputValue[13];
      end for;

    elseif (points == 14) then
      for j in 2:14 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 15:auxPoints loop
        auxValue[j] = inputValue[14];
      end for;

    elseif (points == 15) then
      for j in 2:15 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 16:auxPoints loop
        auxValue[j] = inputValue[15];
      end for;

    elseif (points == 16) then
      for j in 2:16 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 17:auxPoints loop
        auxValue[j] = inputValue[16];
      end for;

    elseif (points == 17) then
      for j in 2:17 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 18:auxPoints loop
        auxValue[j] = inputValue[17];
      end for;

    elseif (points == 18) then
      for j in 2:18 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      for j in 19:auxPoints loop
        auxValue[j] = inputValue[18];
      end for;

    elseif (points == 19) then
      for j in 2:19 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

        auxValue[20] = inputValue[19];

    elseif (points == 20) then
      for j in 2:19 loop
        auxValue[j] = ((inputValue[j] - inputValue[j-1])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*(j-2)) + inputValue[j-1];
      end for;

      if (time < startTime+firstStepPeriod+stepPeriod*19) then
        auxValue[20] = ((inputValue[20] - inputValue[19])/stepPeriod)*(time-firstStepPeriod-startTime-stepPeriod*18) + inputValue[19];
      else
        auxValue[20] = inputValue[20];
      end if;

    end if;

//Calculation for different cases in "Linear"
    y = if (time < startTime) then startValue
                  elseif (time < startTime+firstStepPeriod) then auxValue[1]
                  elseif (time < startTime+firstStepPeriod+stepPeriod and points >= 2) then auxValue[2]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*2 and points >= 3) then auxValue[3]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*3 and points >= 4) then auxValue[4]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*4 and points >= 5) then auxValue[5]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*5 and points >= 6) then auxValue[6]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*6 and points >= 7) then auxValue[7]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*7 and points >= 8) then auxValue[8]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*8 and points >= 9) then auxValue[9]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*9 and points >= 10) then auxValue[10]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*10 and points >= 11) then auxValue[11]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*11 and points >= 12) then auxValue[12]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*12 and points >= 13) then auxValue[13]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*13 and points >= 14) then auxValue[14]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*14 and points >= 15) then auxValue[15]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*15 and points >= 16) then auxValue[16]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*16 and points >= 17) then auxValue[17]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*17 and points >= 18) then auxValue[18]
                  elseif (time < startTime+firstStepPeriod+stepPeriod*18 and points >= 19) then auxValue[19]
                  else auxValue[20];
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),                                                                  graphics={
                             Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-60,26},{60,-24}},
          lineColor={0,0,0},
          textString="ControlUnit")}));
end ControlUnit;
