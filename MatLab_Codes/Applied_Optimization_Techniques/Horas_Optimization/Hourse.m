function [Tout] = Hourse()


members=5;
DecisionVariables=4;

DVBestVec= zeros(members,DecisionVariables);

ToutBest=zeros(members,1);


plusFactor=1;

AdditionFactorVec =[0.01 0.01 0.1 2];


%%%% initialize feasible random initial solution using FeasibleRandom()
%%%% function which satisfay the CheckFeasibility() check.


i=1;
while(i<=members)

MCPvec(i,:)=FeasibleRandom();
DVBestVec= MCPvec;                              %% Put initial best decision variables
ToutBest(i,1) = TorqueCalculate(MCPvec(i,:)) ;  %% Put initial best torque.

i=i+1;
end



g=5;


while(g>=1)




%% Seperation of variable process

i=1;
while(i<=members)

TestVec = MCPvec(i,:);

j=1;
while(j <= DecisionVariables)

inertia=5;      %%give initial inetria to the system.
START=1;        %% flag for starting the operation


  TestVec = MCPvec(i,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Plusing Operation
while(START == 1)
 
  
    
    oldVec=TestVec();

   %% TestVec(1,j) = TestVec(1,j)+ 1*plusFactor;   %%pluse the variable.
    
    
     TestVec(1,j) = TestVec(1,j)+ 1*AdditionFactorVec(1,j); 


    if(CheckFeasibility(TestVec,TestVec(1,j),j) == 1)
        %% Feasible solution


        if( TorqueCalculate(TestVec) > TorqueCalculate(oldVec) )
              
            DVBestVec(i,j)= TestVec(1,j);     %%% Update the best value of the decision variable.

            if( TorqueCalculate(TestVec) > ToutBest(i,1))  %%% Update the best torque value.

                ToutBest(i,1) = TorqueCalculate(TestVec) ;  

            %%inertia=inertia+1;
            end
            inertia=inertia+1;


         else
              inertia=inertia-1;
               
        
        end
         






    else
        inertia =inertia-1;  %%penalety for the system


    end


if(inertia == 0)

START=0;

end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





display(DVBestVec);







START=1;
inertia=5;


%%TestVec = oldVec;

TestVec = MCPvec(i,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Minusing Operation
while(START == 1)
 
    oldVec=TestVec();

    %% TestVec(1,j) = TestVec(1,j)- 1*plusFactor;   %%pluse the variable.

        TestVec(1,j) = TestVec(1,j)- 1*AdditionFactorVec(1,j); 
   
    display(TestVec(1,j))
    
    if(CheckFeasibility(TestVec,TestVec(1,j),j) == 1)
        %% Feasible solution


        if( TorqueCalculate(TestVec) > TorqueCalculate(oldVec) )
              
            DVBestVec(i,j)= TestVec(1,j);     %%% Update the best value of the decision variable.

            if( TorqueCalculate(TestVec) > ToutBest(i,1))  %%% Update the best torque value.

                ToutBest(i,1) = TorqueCalculate(TestVec) ;  
            
             
            end
             inertia=inertia+2;
         else
              inertia=inertia-1;
         
        end
         






    else
        inertia =inertia-1;  %%penalety for the system


    end


if(inertia == 0)

START=0;

end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




MCPvec(i,j)=DVBestVec(i,j)  ;  %%% Update the current decision variable with the best found.




j=j+1;
end



TqVec(1,i)=TorqueCalculate(MCPvec(i,:));
i=i+1;

end

g=g-1;


%% MCPvec = DVBestVec  ;
end




ChVec =FindBest(TqVec,members);

display(" The Decision variable of the best fit member are : ");

display(MCPvec((ChVec(1,1)),1:4));


display(" The Best Torque found using *HOURAS* technique is:  " + TorqueCalculate(MCPvec((ChVec(1,1)),1:4)) + "  N.m");

%%Tout =DVBestVec;

%%Tout=FeasibleRandom();

end