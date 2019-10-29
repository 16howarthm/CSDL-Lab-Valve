function Valve_Plot(ValueMatrix,ValueMatrixE,funcNum,fileN)
[m,~] = size(ValueMatrix);

Names = {};
NamesH = {};
NamesV = {};
NamesT = {};
NamesTime = {};
NamesChar = {};
NamesP ={};
NamesS = {};
TrialList = {};
color_array = {};
for a = 1:m
    N1 = strcat('P_G1_',int2str(a));
    N2 = strcat('P_D1_',int2str(a));
    N3 = strcat('P_S1_',int2str(a));
    N4 = strcat('P_G2_',int2str(a));
    N5 = strcat('P_D2_',int2str(a));
    N6 = strcat('P_Act_',int2str(a));
    N7 = strcat('Q1_',int2str(a));
    N8 = strcat('Q2_',int2str(a));
    N9 = strcat('P_DS1_',int2str(a));
    N10 = strcat("P_DS2_",int2str(a));
    N11 = strcat("P_{G1 Rise Time }_",int2str(a));
    N12 =strcat("P_{G1 Fall Time }_",int2str(a));
    N13 =strcat("P_{G2 }_",int2str(a));
    N14 =strcat("P_{S1 Rise Time }_",int2str(a));
    N15 =strcat("P_{S1 Fall Time }_",int2str(a));
    Trial = strcat('Trial ',int2str(a));
    Names = [Names,N1,N2,N3,N4,N5,N6,N7,N8,N9,N10];
    NamesP = [NamesP,N1,N2];
    NamesV = [NamesV,N1];
    NamesH = [NamesH,Trial];
    NamesT = [NamesT,N1,N4,N3];
    NamesTime = cellstr([N11,N12,N13,N14,N15]);
    NamesTime2 = cellstr([N11,N12]);
    NamesTime3 = cellstr([N14,N15]);
    TrialList = [TrialList,Trial];
    NamesS = [NamesS,N1];  

end 
    for i= 1:length(ValueMatrix{1,1})
        NamesChar = [NamesChar,strcat('P_G_',int2str(i))];
    end     
    color_array = {[1,0,0],[0,1,0],[0,0,1],[1,0.6,0.5],[0,0,0],[1,0.3,1],[0,1,1],[0.5,0,0.8], [0.1,0,0.5],[0.8,0,0.5],[0.5,0,0.5]};

%% plot
if funcNum == 1 %Varying Control Pressure
    %Pds
    figure();
    hold on
    for i=1:m
        P_V_Plot = plot(ValueMatrix{i,10}(:,1),ValueMatrix{i,8}(:,1),'-o','LineWidth',2);
        %P_V_Plote = errorbar(ValueMatrix{i,10}(1:3:end,1),ValueMatrix{i,8}(1:3:end,1),-1.*ValueMatrixE{i,8}(1:3:end,1),ValueMatrixE{i,8}(1:3:end,1),-1.*ValueMatrixE{i,10}(1:3:end,1),ValueMatrixE{i,10}(1:3:end,1),'.','HandleVisibility','off','LineWidth',1);
        if fileN == 'ValveArd07-22-19_1' | fileN == 'ValveArd07-22-19_2'
            if i == 1 || i ==2 || i ==3
                set(P_V_Plot,'Color',[1 0 0]);
               % set(P_V_Plote,'Color',[1 0 0]);
            elseif  i == 4 || i ==5 || i ==6
                set(P_V_Plot,'Color',[0 1 0]);
               % set(P_V_Plote,'Color',[0 1 0]);
            elseif  i == 7 || i ==8 || i ==9
                set(P_V_Plot,'Color',[0 0 1]);
                %set(P_V_Plote,'Color',[0 0 1]);
            else
                set(P_V_Plot,'Color',[1 0 1]);
               % set(P_V_Plote,'Color',[1 0 1]);
            end
        else
                        set(P_V_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_V_Plote,'Color',[0 1-i./5 i./5]);
        end
    end
    hold off
    leg = legend(NamesV,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS1} [ml/min]');
    xlabel('P_{DS1} [Psi]');
    tit = title(strcat(fileN,'_1'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
    %Pds where Ps = 0
    figure();
    hold on
    for i=1:m
        P_V2_Plot = plot(ValueMatrix{i,3}(:,1),ValueMatrix{i,8}(:,1),'-o','LineWidth',2);
        %P_V2_Plote = errorbar(ValueMatrix{i,3}(1:3:end,1),ValueMatrix{i,8}(1:3:end,1),-1.*ValueMatrixE{i,8}(1:3:end,1),ValueMatrixE{i,8}(1:3:end,1),-1.*ValueMatrixE{i,3}(1:3:end,1),ValueMatrixE{i,3}(1:3:end,1),'.','HandleVisibility','off','LineWidth',2);
        if fileN == 'ValveArd07-22-19_1' | fileN == 'ValveArd07-22-19_2'
            if i == 1 || i ==2 || i ==3
                set(P_V2_Plot,'Color',[1 0 0]);
               % set(P_V2_Plote,'Color',[1 0 0]);
            elseif  i == 4 || i ==5 || i ==6
                set(P_V2_Plot,'Color',[0 1 0]);
                %set(P_V2_Plote,'Color',[0 1 0]);
            elseif  i == 7 || i ==8 || i ==9
                set(P_V2_Plot,'Color',[0 0 1]);
                %set(P_V2_Plote,'Color',[0 0 1]);
            else
                set(P_V2_Plot,'Color',[1 0 1]);
                %set(P_V2_Plote,'Color',[1 0 1]);
            end
        else
                        set(P_V2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_V2_Plote,'Color',[0 1-i./5 i./5]);
        end
    end
    
    hold off
    leg = legend(NamesV,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS1} [ml/min]');
    xlabel('P_{DS1} [Psi]');
    tit = title(strcat(fileN,'_2'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 2 %Varying Control Pressure 2
    figure();
    hold on
    for i=1:m
        P_V_Plot = plot(ValueMatrix{i,10}(:,1),ValueMatrix{i,8}(:,1),'LineWidth',2);
       % P_V_Plote = errorbar(ValueMatrix{i,10}(1:100:end,1),ValueMatrix{i,8}(1:100:end,1),-1.*ValueMatrixE{i,8}(1:100:end,1),ValueMatrixE{i,8}(1:100:end,1),-1.*ValueMatrixE{i,10}(1:100:end,1),ValueMatrixE{i,10}(1:100:end,1),'.','HandleVisibility','off','LineWidth',2);
                    set(P_V_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_V_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesV,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('P_{DS} [Psi]');
    tit = title(fileN);
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 3 %Hysteresis
    figure();
    hold on
    for i=1:m
        hyst = -1:0.01:ValueMatrix{i,3}(end,1);
        hystLim = ValueMatrix{i,3}(end,1).*ones(1,length(hyst));
        
        P_H_Plot = plot(ValueMatrix{i,2}(:,1),ValueMatrix{i,4}(:,1),'LineWidth',2);
       % P_H_Plote = errorbar(ValueMatrix{i,2}(1:50:end,1),ValueMatrix{i,4}(1:50:end,1),-1.*ValueMatrixE{i,4}(1:50:end,1),ValueMatrixE{i,4}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
        plot(hyst,hystLim,'--k','HandleVisibility','off','LineWidth',2);
        plot(hystLim,hyst,'--k','HandleVisibility','off','LineWidth',2);
                    set(P_H_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_H_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesH,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    xlabel('P_{G1} [Psi]');
    ylabel('P_{S1} [Psi]');
    tit = title(fileN);
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 4    %Pressurization and Depressurization Time
    figure();
    hold on
    for i=1:m
        P_G1_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,2}(:,1),'--','LineWidth',3);
        P_G2_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,5}(:,1),':','LineWidth',3);
        P_S1_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,4}(:,1),'LineWidth',3);
        %P_G1_Plote = errorbar(ValueMatrix{i,1}(1:100:end,1),ValueMatrix{i,2}(1:100:end,1),-1.*ValueMatrixE{i,2}(1:100:end,1),ValueMatrixE{i,2}(1:100:end,1),-1.*ValueMatrixE{i,1}(1:100:end,1),ValueMatrixE{i,1}(1:100:end,1),'.','HandleVisibility','off','LineWidth',3);           %P_G1 versus time
        %P_G2_Plote = errorbar(ValueMatrix{i,1}(1:100:end,1),ValueMatrix{i,5}(1:100:end,1),-1.*ValueMatrixE{i,5}(1:100:end,1),ValueMatrixE{i,5}(1:100:end,1),-1.*ValueMatrixE{i,1}(1:100:end,1),ValueMatrixE{i,1}(1:100:end,1),'.','HandleVisibility','off','LineWidth',3);           %P_G2 versus time
        %P_S1_Plote = errorbar(ValueMatrix{i,1}(1:100:end,1),ValueMatrix{i,4}(1:100:end,1),-1.*ValueMatrixE{i,4}(1:100:end,1),ValueMatrixE{i,4}(1:100:end,1),-1.*ValueMatrixE{i,1}(1:100:end,1),ValueMatrixE{i,1}(1:100:end,1),'.','HandleVisibility','off','LineWidth',3);           %P_S1 versus time
        
        set(P_G1_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_G1_Plote,'Color',[0 1-i./5 i./5]);
            set(P_G2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_G2_Plote,'Color',[0 1-i./5 i./5]);
            set(P_S1_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_S1_Plote,'Color',[0 1-i./5 i./5]);
    end
    hold off
    leg = legend(NamesT,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    xlabel('Time [s]');
    ylabel('Pressure [Psi]');
    tit = title(fileN);
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
    if month == 7
        timeVal_1 = 100;
        timeVal_2 = 400;
        timeVal_3 = 610;
    else
        timeVal_1 = 500;
        timeVal_2 = 1500;
        timeVal_3 = 2000;
    end
    time = [];   %PinS, PinE, PoutS, PoutE
    timeStep = [];
    timeStepE = [];     %only precision error
    for r = 1:m
        timeIdxP1_S1_S = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_1,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_1,1)-0.5)';
        tIdxP1_S1_S = timeIdxP1_S1_S(find(timeIdxP1_S1_S(1,:) < timeVal_2,1,'last'));
        time(r,1) = ValueMatrix{r,1}(tIdxP1_S1_S,1); timeE(r,1) = ValueMatrixE{r,1}(tIdxP1_S1_S,1);
        timeIdxP1_S1_E = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_2,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_2,1)-0.5)';
        tIdxP1_S1_E = timeIdxP1_S1_E(find(timeIdxP1_S1_E(1,:) > timeVal_1 & timeIdxP1_S1_E(1,:) < timeVal_2,1,'first'));
        time(r,2) = ValueMatrix{r,1}(tIdxP1_S1_E,1);  timeE(r,2) = ValueMatrixE{r,1}(tIdxP1_S1_E,1);
        timeIdxP2_S1_S = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_2,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_2,1)-0.5)';
        tIdxP2_S1_S = timeIdxP2_S1_S(find(timeIdxP2_S1_S(1,:) > timeVal_2,1,'last'));
        time(r,3) = ValueMatrix{r,1}(tIdxP2_S1_S,1); timeE(r,3) = ValueMatrixE{r,1}(tIdxP2_S1_S,1);
        timeIdxP2_S1_E = find(ValueMatrix{r,2}<=ValueMatrix{r,2}(timeVal_3,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_3,1)-0.5)';
        tIdxP2_S1_E = timeIdxP2_S1_E(find(timeIdxP2_S1_E(1,:) > timeVal_2,1,'first'));
        time(r,4) = ValueMatrix{r,1}(tIdxP2_S1_E,1); timeE(r,4) = ValueMatrixE{r,1}(tIdxP2_S1_E,1);
        timeIdxP_G2_S = find(ValueMatrix{r,5} <= ValueMatrix{r,5}(timeVal_2,1)+0.5 & ValueMatrix{r,5} >= ValueMatrix{r,5}(timeVal_2,1)-0.5)';
        tIdxP_G2_S = timeIdxP_G2_S(find(timeIdxP_G2_S(1,:) > timeVal_2,1,'last'));
        time(r,5) = ValueMatrix{r,1}(tIdxP_G2_S,1); timeE(r,5) = ValueMatrixE{r,1}(tIdxP_G2_S,1);
        timeIdxP_G2_E = find(ValueMatrix{r,5}==ValueMatrix{r,5}(end,1))';
        tIdxP_G2_E = timeIdxP_G2_E(find(timeIdxP_G2_E(1,:) > timeVal_2,1,'first'));
        time(r,6) = ValueMatrix{r,1}(tIdxP_G2_E,1); timeE(r,6) = ValueMatrixE{r,1}(tIdxP_G2_E,1);
        timeIdxP1_S1_S = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_1,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_1,1)-0.5)';
        tIdxP1_S1_S = timeIdxP1_S1_S(find(timeIdxP1_S1_S(1,:) < timeVal_2,1,'last'));
        time(r,7) = ValueMatrix{r,1}(tIdxP1_S1_S,1);  timeE(r,7) = ValueMatrixE{r,1}(tIdxP1_S1_S,1);
        timeIdxP1_S1_E = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_2,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_2,1)-0.5)';
        tIdxP1_S1_E = timeIdxP1_S1_E(find(timeIdxP1_S1_E(1,:) < timeVal_3,1,'first'));
        time(r,8) = ValueMatrix{r,1}(tIdxP1_S1_E,1); timeE(r,8) = ValueMatrixE{r,1}(tIdxP1_S1_E,1);
        timeIdxP2_S1_S = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_2,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_2,1)-0.5)';
        tIdxP2_S1_S = timeIdxP2_S1_S(find(timeIdxP2_S1_S(1,:) > timeVal_2,1,'last'));
        time(r,9) = ValueMatrix{r,1}(tIdxP2_S1_S,1); timeE(r,9) = ValueMatrixE{r,1}(tIdxP2_S1_S,1);
        timeIdxP2_S1_E = find(ValueMatrix{r,4}<=ValueMatrix{r,4}(timeVal_3,1)+0.5 & ValueMatrix{r,4}>=ValueMatrix{r,4}(timeVal_3,1)-0.5)';
        tIdxP2_S1_E = timeIdxP2_S1_E(find(timeIdxP2_S1_E(1,:) < timeVal_3 & timeIdxP2_S1_E(1,:) > timeVal_2,1,'first'));
        time(r,10) = ValueMatrix{r,1}(tIdxP2_S1_E,1); timeE(r,10) = ValueMatrixE{r,1}(tIdxP2_S1_E,1);
        
        
        timeStep(r,1) = time(r,2) - time(r,1);
        timeStep(r,2) = time(r,4) - time(r,3);
        timeStep(r,3) = time(r,6) - time(r,5);
        timeStep(r,4) = time(r,8) - time(r,7);
        timeStep(r,5) = time(r,10) - time(r,9);
        
        timeStepE(r,1) = (timeE(r,2)+timeE(r,1))./2;
        timeStepE(r,2) = (timeE(r,4) + timeE(r,3))./2;
        timeStepE(r,3) = (timeE(r,6) + timeE(r,5))./2;
        timeStepE(r,4) = (timeE(r,8) + timeE(r,7))./2;
        timeStepE(r,5) = (timeE(r,10) + timeE(r,9))./2;
    end
    timeFigName = strcat(fileN,' Time Step');
    
    figure();
    timePlot = bar(timeStep');
    for r = 1:m
        ctr(r,:) = bsxfun(@plus, timePlot(1).XData, [timePlot(r).XOffset]');
        ydt(r,:) = timePlot(r).YData;
    end
    hold on
    errtimePlot = errorbar(ctr,ydt,-1.*timeStepE,timeStepE,'.k','HandleVisibility','off','LineWidth',2);
    
    hold off
    ax = gca;
    ax.XTickLabels = NamesTime;
    legend(TrialList,'Location','NorthEast');
    ylabel('Time [s]');
    title(timeFigName, 'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 5 %solenoid step
    figure();
    hold on
    for i=1:m
        %         step1 = [];
        %         step2 = [];
        %         step4 = [];
        %         for m = 1:1:length(ValueMatrix{i,1})
        %             if rem(ValueMatrix{i,1}(m,1),2) < 1
        %                 step1(m) = 0;
        %             else
        %                 step1(m) = 1;
        %             end
        %             if 2*rem(ValueMatrix{i,1}(m,1),2) < 2
        %                 step2(m) = 0;
        %             else
        %                 step2(m) = 1;
        %             end
        %             if 4*rem(ValueMatrix{i,1}(m,1),2) < 4
        %                 step4(m) = 0;
        %             else
        %                 step4(m) = 1;
        %             end
        %         end
        
        P_S_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,2}(:,1),'LineWidth',3);
        %P_S_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
        %              plot(ValueMatrix{i,1}(:,1),step1,'--r','HandleVisibility','off');
        %              plot(ValueMatrix{i,1}(:,1),step2,'--g','HandleVisibility','off');
        %              plot(ValueMatrix{i,1}(:,1),step4,'--b','HandleVisibility','off');
          set(P_S_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_S_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{G1} [Psi]');
    xlabel('time [sec]');
    tit = title(fileN);
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 6 || funcNum == 7
     for i = 1:m
    Qg = gradient(ValueMatrix{i,2}(:,1)) ./ gradient(ValueMatrix{i,1}(:,1));
    %Qge = sqrt(2).*ValueMatrixE{i,2}(:,1)./ValueMatrixE{i,1}(:,1);
     end
    
    figure();
    subplot(5,1,1)
    hold on
 for i = 1:m
        P_M1_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,8}(:,1),'LineWidth',3);
        %P_M1_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,8}(1:50:end,1),-1.*ValueMatrixE{i,8}(1:50:end,1),ValueMatrixE{i,8}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M1_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M1_Plote,'Color',[0 1-i./5 i./5]);
 end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('time [sec]');
    tit = title(strcat(fileN,'_1'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    subplot(5,1,2)
    hold on
 for i = 1:m
        P_M2_Plot = plot(ValueMatrix{i,1}(:,1),Qg,'LineWidth',3);
       % P_M2_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),Qg(1:50:end,1),-1.*Qge(1:50:end,1),Qge(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M2_Plote,'Color',[0 1-i./5 i./5]);
 end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{G1} [ml/min]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,3)
    hold on
  for i = 1:m
        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,2}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);
  end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{G1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,4)
    hold on
 for i = 1:m
        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,4}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);
 end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{S1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,5)
    hold on
 for i = 1:m
        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,3}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);
 end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{D1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    
    for i =1:m
       figure();
    subplot(5,1,1)
    hold on

        P_M1_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,8}(:,1),'LineWidth',3);
        %P_M1_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,8}(1:50:end,1),-1.*ValueMatrixE{i,8}(1:50:end,1),ValueMatrixE{i,8}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M1_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M1_Plote,'Color',[0 1-i./5 i./5]);

    hold off
    ylabel('Q_{DS} [ml/min]');
    xlabel('time [sec]');
    tit = title(strcat(fileN,'_2'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    subplot(5,1,2)
    hold on

        P_M2_Plot = plot(ValueMatrix{i,1}(:,1),Qg,'LineWidth',3);
       % P_M2_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),Qg(1:50:end,1),-1.*Qge(1:50:end,1),Qge(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M2_Plote,'Color',[0 1-i./5 i./5]);

    hold off
    ylabel('Q_{G1} [ml/min]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,3)
    hold on
 
        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,2}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);

    hold off
    ylabel('P_{G1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,4)
    hold on
 
        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,4}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);

    hold off
    ylabel('P_{S1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    subplot(5,1,5)
    hold on

        P_M3_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,3}(:,1),'LineWidth',3);
        %P_M3_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,2}(1:50:end,1),-1.*ValueMatrixE{i,2}(1:50:end,1),ValueMatrixE{i,2}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
          set(P_M3_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M3_Plote,'Color',[0 1-i./5 i./5]);

    hold off
    ylabel('P_{D1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    end
%     
%     figure();
%     hold on
%     for i=1:m
%         P_M4_Plot = plot(ValueMatrix{i,2}(180:270,1),ValueMatrix{i,8}(180:270,1),'LineWidth',3);
%         %P_M4e_Plot = errorbar(ValueMatrix{i,2}(180:50:270,1),ValueMatrix{i,8}(180:50:270,1),-1.*ValueMatrixE{i,8}(180:50:270,1),ValueMatrixE{i,8}(180:50:270,1),-1.*ValueMatrixE{i,2}(180:50:270,1),ValueMatrixE{i,2}(180:50:270,1),'.','HandleVisibility','off','LineWidth',2);
%         
%           set(P_M4_Plot,'Color',[0 1-i./5 i./5]);
%           %  set(P_M4_Plote,'Color',[0 1-i./5 i./5]);
%     end
%     
%     hold off
%     leg = legend(NamesP,'Location','SouthEast');
%     set(leg,'Interpreter', 'none');
%     ylabel('Q_{DS} [ml/min]');
%     xlabel('P_{G1} [Psi]');
%     tit = title(strcat(fileN,'_Fall'));
%     set(tit,'Interpreter', 'none');
%     set(gca,'FontSize',14);
%     
%     figure();
%     hold on
%     for i=1:m
%         P_M5_Plot = plot(ValueMatrix{i,2}(50:180,1),ValueMatrix{i,8}(50:180,1),'LineWidth',3);
%         %P_M5e_Plot = errorbar(ValueMatrix{i,2}(50:50:180,1),ValueMatrix{i,8}(50:50:180,1),-1.*ValueMatrixE{i,8}(50:50:180,1),ValueMatrixE{i,8}(50:50:180,1),-1.*ValueMatrixE{i,2}(50:50:180,1),ValueMatrixE{i,2}(50:50:180,1),'.','HandleVisibility','off','LineWidth',2);
%         
%           set(P_M5_Plot,'Color',[0 1-i./5 i./5]);
%           %  set(P_M5_Plote,'Color',[0 1-i./5 i./5]);
%     end
%     
%     hold off
%     leg = legend(NamesP,'Location','SouthEast');
%     set(leg,'Interpreter', 'none');
%     ylabel('Q_{DS} [ml/min]');
%     xlabel('P_{G1} [Psi]');
%     tit = title(strcat(fileN,'_Rise'));
%     set(tit,'Interpreter', 'none');
%     set(gca,'FontSize',14);
%     
%     timeVal_1 = 10;
%     timeVal_2 = 150;
%     
%     time = [];   %PinS, PinE, PoutS, PoutE
%     timeStep = [];
%     timeStepE = [];     %only precision error
%     for r = 1:m
%         timeIdxP1_S1_S = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_1,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_1,1)-0.5)';
%         tIdxP1_S1_S = timeIdxP1_S1_S(find(timeIdxP1_S1_S(1,:) < timeVal_2,1,'last'));
%         time(r,1) = ValueMatrix{r,1}(tIdxP1_S1_S,1); timeE(r,1) = ValueMatrixE{r,1}(tIdxP1_S1_S,1);
%         timeIdxP1_S1_E = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_2,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_2,1)-0.5)';
%         tIdxP1_S1_E = timeIdxP1_S1_E(find(timeIdxP1_S1_E(1,:) > timeVal_1 & timeIdxP1_S1_E(1,:) < timeVal_2,1,'first'));
%         time(r,2) = ValueMatrix{r,1}(tIdxP1_S1_E,1);  timeE(r,2) = ValueMatrixE{r,1}(tIdxP1_S1_E,1);
%         timeIdxP2_S1_S = find(ValueMatrix{r,2} <= ValueMatrix{r,2}(timeVal_1,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_1,1)-0.5)';
%         tIdxP2_S1_S = timeIdxP2_S1_S(find(timeIdxP2_S1_S(1,:) < timeVal_2,1,'last'));
%         time(r,3) = ValueMatrix{r,1}(tIdxP2_S1_S,1); timeE(r,3) = ValueMatrixE{r,1}(tIdxP2_S1_S,1);
%         timeIdxP2_S1_E = find(ValueMatrix{r,2}<=ValueMatrix{r,2}(timeVal_2,1)+0.5 & ValueMatrix{r,2} >= ValueMatrix{r,2}(timeVal_2,1)-0.5)';
%         tIdxP2_S1_E = timeIdxP2_S1_E(find(timeIdxP2_S1_E(1,:) > timeVal_1 & timeIdxP2_S1_E(1,:) <= timeVal_2,1,'first'));
%         time(r,4) = ValueMatrix{r,1}(tIdxP2_S1_E,1); timeE(r,4) = ValueMatrixE{r,1}(tIdxP2_S1_E,1);
%         timeStep(r,1) = time(r,2) - time(r,1);
%         timeStep(r,2) = time(r,4) - time(r,3);
%         timeStepE(r,1) = (timeE(r,2)+timeE(r,1))./2;
%         timeStepE(r,2) = (timeE(r,4) + timeE(r,3))./2;
%     end
%     timeFigName = strcat(fileN,' Time Step');
%     
%     figure();
%     timePlot = bar(timeStep');
%     for r = 1:m
%         ctr(r,:) = bsxfun(@plus, timePlot(1).XData, [timePlot(r).XOffset]');
%         ydt(r,:) = timePlot(r).YData;
%     end
%     hold on
%     errtimePlot = errorbar(ctr,ydt,-1.*timeStepE,timeStepE,'.k','HandleVisibility','off','LineWidth',2);
%     
%     hold off
%     ax = gca;
%     ax.XTickLabels = NamesTime2;
%     legend(TrialList,'Location','NorthEast');
%     ylabel('Time [s]');
%     title(timeFigName, 'Interpreter', 'none');
%     set(gca,'FontSize',14);

elseif funcNum == 8 %characteristic Curve %Constant Rl line
%     figure();        %Pds
%     hold on
%     for i=1:m
%         P_V_Plot = plot(ValueMatrix{i,10}(:,1),ValueMatrix{i,8}(:,1),'--x','MarkerSize',10);
%         %P_V_Plote = errorbar(ValueMatrix{i,10}(1:3:end,1),ValueMatrix{i,8}(1:3:end,1),-1.*ValueMatrixE{i,8}(1:3:end,1),ValueMatrixE{i,8}(1:3:end,1),-1.*ValueMatrixE{i,10}(1:3:end,1),ValueMatrixE{i,10}(1:3:end,1),'.','HandleVisibility','off','LineWidth',1);
%         if fileN == 'ValveArd07-22-19_1' | fileN == 'ValveArd07-22-19_2'
%             if i == 1 || i ==2 || i ==3
%                 set(P_V_Plot,'Color',[1 0 0]);
%                % set(P_V_Plote,'Color',[1 0 0]);
%             elseif  i == 4 || i ==5 || i ==6
%                 set(P_V_Plot,'Color',[0 1 0]);
%                % set(P_V_Plote,'Color',[0 1 0]);
%             elseif  i == 7 || i ==8 || i ==9
%                 set(P_V_Plot,'Color',[0 0 1]);
%                 %set(P_V_Plote,'Color',[0 0 1]);
%             else
%                 set(P_V_Plot,'Color',[1 0 1]);
%                % set(P_V_Plote,'Color',[1 0 1]);
%             end
%         else
%                         set(P_V_Plot,'Color',[1-i./8 0 i./8]);
%           %  set(P_V_Plote,'Color',[0 1-i./5 i./5]);
%         end
%     end
%     hold off
%     leg = legend(NamesV,'Location','SouthEast');
%     set(leg,'Interpreter', 'none');
%     ylabel('Q_{DS1} [ml/min]');
%     xlabel('P_{DS1} [Psi]');
%     tit = title(strcat(fileN,'_1'));
%     set(tit,'Interpreter', 'none');
%     set(gca,'FontSize',14);
    
    %Pds where Ps = 0
    charMat = [];  
    for l = 1:length(ValueMatrix{1,1})
        for q = 1:m
            charMat{l,1}(q,1) = ValueMatrix{q,3}(l,1);
            charMat{l,2}(q,1) = ValueMatrix{q,8}(l,1);
        end
    end
    
    figure();  %Constant Pg line
    hold on
    for i=1:length(ValueMatrix{1,1})
        P_V2_Plot = plot(charMat{i,1}(:,1),charMat{i,2}(:,1),'--o','MarkerSize',12,'LineWidth',3);
        %P_V2_Plote = errorbar(ValueMatrix{i,3}(1:3:end,1),ValueMatrix{i,8}(1:3:end,1),-1.*ValueMatrixE{i,8}(1:3:end,1),ValueMatrixE{i,8}(1:3:end,1),-1.*ValueMatrixE{i,3}(1:3:end,1),ValueMatrixE{i,3}(1:3:end,1),'.','HandleVisibility','off','LineWidth',2);
        if fileN == 'ValveArd07-22-19_1' | fileN == 'ValveArd07-22-19_2'
            if i == 1 || i ==2 || i ==3
                set(P_V2_Plot,'Color',[1 0 0]);
                % set(P_V2_Plote,'Color',[1 0 0]);
            elseif  i == 4 || i ==5 || i ==6
                set(P_V2_Plot,'Color',[0 1 0]);
                %set(P_V2_Plote,'Color',[0 1 0]);
            elseif  i == 7 || i ==8 || i ==9
                set(P_V2_Plot,'Color',[0 0 1]);
                %set(P_V2_Plote,'Color',[0 0 1]);
            else
                set(P_V2_Plot,'Color',[1 0 1]);
                %set(P_V2_Plote,'Color',[1 0 1]);
            end
        else
            set(P_V2_Plot,'Color',color_array{i});
            %  set(P_V2_Plote,'Color',[0 1-i./5 i./5]);
        end
    end
    for i=1:m
        P_V_Plot = plot(ValueMatrix{i,3}(:,1),ValueMatrix{i,8}(:,1),'--','LineWidth',2);
        set(P_V_Plot,'Color',[0.5 0.5 0.5]);
    end
    
    hold off
    leg = legend(NamesChar,'Location','SouthEast');
    %set(leg,'Interpreter', 'none');
    ylabel('Q_{DS1} [ml/min]');
    xlabel('P_{DS1} [Psi]');
    tit = title(strcat(fileN,'_2'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
        
    figure(); %Pg
    hold on
    for i=1:m
        P_V2_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,2}(:,1),'--x','MarkerSize',10);
        %P_V2_Plote = errorbar(ValueMatrix{i,3}(1:3:end,1),ValueMatrix{i,8}(1:3:end,1),-1.*ValueMatrixE{i,8}(1:3:end,1),ValueMatrixE{i,8}(1:3:end,1),-1.*ValueMatrixE{i,3}(1:3:end,1),ValueMatrixE{i,3}(1:3:end,1),'.','HandleVisibility','off','LineWidth',2);
        set(P_V2_Plot,'Color',color_array{i});
        %  set(P_V2_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesV,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{G1} [psi]');
    xlabel('time [sec]');
    tit = title(strcat(fileN,'_3'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
     
    figure(); %3d plot
    Matrix3 = {};
    for i = 1:m
      Matrix3{1,1}(:,i) = ValueMatrix{i,2}(:,1);
      Matrix3{1,2}(:,i) = ValueMatrix{i,10}(:,1);
      Matrix3{1,3}(:,i) = ValueMatrix{i,8}(:,1);
    end
        P_3_Plot = surf(Matrix3{1,1},Matrix3{1,2},Matrix3{1,3});
    xlabel('P_{G} [psi]');
    ylabel('P_{D} [psi]');
    zlabel('Q_{DS} [psi]');
    tit = title(strcat(fileN,'_4'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
elseif funcNum == 9 %solenoid step
    
    figure();
    
    subplot(2,1,1)
    hold on
    for i=1:m
        P_M1_Plot = plot(ValueMatrix{i,1}(1:250,1),ValueMatrix{i,8}(1:250,1),'LineWidth',3);
        %P_M1_Plote = errorbar(ValueMatrix{i,1}(1:50:250,1),ValueMatrix{i,8}(1:50:250,1),-1.*ValueMatrixE{i,8}(1:50:250,1),ValueMatrixE{i,8}(1:50:250,1),-1.*ValueMatrixE{i,1}(1:50:250,1),ValueMatrixE{i,1}(1:50:250,1),'.','HandleVisibility','off','LineWidth',2);
        P_M2_Plot = plot(ValueMatrix{i,1}(250:end,1),ValueMatrix{i,9}(250:end,1),'HandleVisibility','off','LineWidth',3);
        %P_M2_Plote = errorbar(ValueMatrix{i,1}(250:50:end,1),ValueMatrix{i,9}(250:50:end,1),-1.*ValueMatrixE{i,9}(250:50:end,1),ValueMatrixE{i,9}(250:50:end,1),-1.*ValueMatrixE{i,1}(250:50:end,1),ValueMatrixE{i,1}(250:50:end,1),'.','HandleVisibility','off','LineWidth',2);
         
          set(P_M1_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M1_Plote,'Color',[0 1-i./5 i./5]);
            set(P_M2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M2_Plote,'Color',[0 1-i./5 i./5]);
    end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('time [sec]');
    tit = title(strcat(fileN,'_1'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    subplot(2,1,2)
    hold on
    for i = 1:m
        P_M2_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,4}(:,1),'LineWidth',3);
       % P_M2_Plote = errorbar(ValueMatrix{i,1}(1:50:end,1),ValueMatrix{i,4}(1:50:end,1),-1.*ValueMatrixE{i,4}(1:50:end,1),ValueMatrixE{i,4}(1:50:end,1),-1.*ValueMatrixE{i,1}(1:50:end,1),ValueMatrixE{i,1}(1:50:end,1),'.','HandleVisibility','off','LineWidth',2);
        
            set(P_M2_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M2_Plote,'Color',[0 1-i./5 i./5]);
        
    end
    hold off
    leg = legend(NamesS,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('P_{S1} [Psi]');
    xlabel('time [sec]');
    set(gca,'FontSize',14);
    
    figure();
    hold on
    for i=1:m
        P_M4_Plot = plot(ValueMatrix{i,4}(50:200,1),ValueMatrix{i,8}(50:200,1),'LineWidth',3);
       % P_M4e_Plot = errorbar(ValueMatrix{i,4}(50:50:200,1),ValueMatrix{i,8}(50:50:200,1),-1.*ValueMatrixE{i,8}(50:50:200,1),ValueMatrixE{i,8}(50:50:200,1),-1.*ValueMatrixE{i,2}(50:50:200,1),ValueMatrixE{i,2}(50:50:200,1),'.','HandleVisibility','off','LineWidth',2);
        
                    set(P_M4_Plot,'Color',[1-i./5 0 i./5]);
          %  set(P_M4_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesP,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('P_{S1} [Psi]');
    tit = title(strcat(fileN,'_Rise'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
    figure();
    hold on
    for i=1:m
        P_M5_Plot = plot(ValueMatrix{i,4}(300:end,1),ValueMatrix{i,9}(300:end,1),'LineWidth',3);
        %P_M5e_Plot = errorbar(ValueMatrix{i,4}(300:50:end,1),ValueMatrix{i,9}(300:50:end,1),-1.*ValueMatrixE{i,9}(300:50:end,1),ValueMatrixE{i,9}(300:50:end,1),-1.*ValueMatrixE{i,4}(300:50:end,1),ValueMatrixE{i,4}(300:50:end,1),'.','HandleVisibility','off','LineWidth',2);
        
         set(P_M5_Plot,'Color',[0 1-i./5 i./5]);
          %  set(P_M5_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesP,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('P_{S1} [Psi]');
    tit = title(strcat(fileN,'_Fall'));
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
    
    timeVal_1 = 10;
    timeVal_2 = 150;
    
    time = [];   %PinS, PinE, PoutS, PoutE
    timeStep = [];
    timeStepE = [];     %only precision error
    for r = 1:m
        timeIdxP1_S1_S = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_1,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_1,1)-0.5)';
        tIdxP1_S1_S = timeIdxP1_S1_S(find(timeIdxP1_S1_S(1,:) < timeVal_2,1,'last'));
        time(r,1) = ValueMatrix{r,1}(tIdxP1_S1_S,1); timeE(r,1) = ValueMatrixE{r,1}(tIdxP1_S1_S,1);
        timeIdxP1_S1_E = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_2,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_2,1)-0.5)';
        tIdxP1_S1_E = timeIdxP1_S1_E(find(timeIdxP1_S1_E(1,:) > timeVal_1 & timeIdxP1_S1_E(1,:) < timeVal_2,1,'first'));
        time(r,2) = ValueMatrix{r,1}(tIdxP1_S1_E,1);  timeE(r,2) = ValueMatrixE{r,1}(tIdxP1_S1_E,1);
        timeIdxP2_S1_S = find(ValueMatrix{r,4} <= ValueMatrix{r,4}(timeVal_1,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_1,1)-0.5)';
        tIdxP2_S1_S = timeIdxP2_S1_S(find(timeIdxP2_S1_S(1,:) < timeVal_2,1,'last'));
        time(r,3) = ValueMatrix{r,1}(tIdxP2_S1_S,1); timeE(r,3) = ValueMatrixE{r,1}(tIdxP2_S1_S,1);
        timeIdxP2_S1_E = find(ValueMatrix{r,4}<=ValueMatrix{r,4}(timeVal_2,1)+0.5 & ValueMatrix{r,4} >= ValueMatrix{r,4}(timeVal_2,1)-0.5)';
        tIdxP2_S1_E = timeIdxP2_S1_E(find(timeIdxP2_S1_E(1,:) > timeVal_1 & timeIdxP2_S1_E(1,:) <= timeVal_2,1,'first'));
        time(r,4) = ValueMatrix{r,1}(tIdxP2_S1_E,1); timeE(r,4) = ValueMatrixE{r,1}(tIdxP2_S1_E,1);
        timeStep(r,1) = time(r,2) - time(r,1);
        timeStep(r,2) = time(r,4) - time(r,3);
        timeStepE(r,1) = (timeE(r,2)+timeE(r,1))./2;
        timeStepE(r,2) = (timeE(r,4) + timeE(r,3))./2;
    end
    
    timeFigName = strcat(fileN,' Time Step');
    
    figure();
    timePlot = bar(timeStep');
    for r = 1:m
        ctr(r,:) = bsxfun(@plus, timePlot(1).XData, [timePlot(r).XOffset]');
        ydt(r,:) = timePlot(r).YData;
    end
    hold on
    %errtimePlot = errorbar(ctr,ydt,-1.*timeStepE,timeStepE,'.k','HandleVisibility','off','LineWidth',2);
    
    hold off
    ax = gca;
    ax.XTickLabels = NamesTime3;
    legend(TrialList,'Location','NorthEast');
    ylabel('Time [s]');
    title(timeFigName, 'Interpreter', 'none');
    set(gca,'FontSize',14);
    
else %input and output pressure
    figure();
    hold on
    for i=1:m
        P_G_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,8}(:,1),'-');
        %P_D_Plot = plot(ValueMatrix{i,1}(:,1),ValueMatrix{i,3}(:,1),'--');
        
         set(P_G_Plot,'Color',[0 1-i./5 i./5]);
        % set(P_D_Plote,'Color',[0 1-i./5 i./5]);
    end
    
    hold off
    leg = legend(NamesP,'Location','SouthEast');
    set(leg,'Interpreter', 'none');
    ylabel('Q_{DS} [ml/min]');
    xlabel('time [sec]');
    tit = title(fileN);
    set(tit,'Interpreter', 'none');
    set(gca,'FontSize',14);
end

end 