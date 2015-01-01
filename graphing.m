# /usr/bin/octave -qf

Data = importdata("when");

size(Data);
A = Data(:,3);
B = Data(find(A~=-1),1);
C = Data(find(A~=-1),2);
P = Data(find(A==-1),1:2);

if any(Data(:) == -1)
    X = linspace(0,B(end)-1,B(end)-1);
    plot(C,X);
    hold on;
    line([P(2),P(2)],[0,X(end)],'Color', 'r');
else
    X = linspace(0,B(end),B(end));
    plot(C,X);
endif

xlabel("Seconds");
ylabel("Tickets");
title("Sales");
print stats.png;
