-use_module(library(clpfd)).
 
:- set_prolog_flag(toplevel_print_options,[quoted(true), portray(true), max_depth(0)]).
% .init file in Window (pl.ini)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%             DEFINE SIZE OF THE MAZE         %%%%%%%%%%%%%%%%%%%%%
mazeSize(5,9).
size(F,S) :- mazeSize(X,Z), 
                F =< X,
                F > 0, 
                S =< Z,
                S > 0.
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%            DEFINE BARRIERS OF THE MAZE         %%%%%%%%%%%%%%%%%%%%%
 
barrier(1,8).
barrier(2,1).
barrier(2,2).
barrier(2,4).
barrier(2,5).
barrier(3,4).
barrier(3,7).
barrier(3,9).
barrier(4,4).
barrier(4,7).
barrier(4,8).
barrier(4,9).
barrier(5,2).
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%              PRINTING THE MAZE        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
print_maze(Path) :- nl, write('    '), print_hor_num(1),
                    mazeSize(Hi,Length),
                nl,write('  +'), get_line(Length), write('+'),
                nl, \+printGrit(Path,[1,1],Hi), 
                write('  +'), get_line(Length),write('+'),nl,nl.

get_line(N) :- New is N * 2 + 1, print_line(New).

print_line(0).
print_line(L) :- write('-'),
                New is L - 1,
                print_line(New).

 
print_hor_num(N) :- mazeSize(_,N), write(N),!.
print_hor_num(Y) :- print_number(Y), Next is Y + 1, print_hor_num(Next).                   
 
print_number(N) :- N < 10,
                write(N),
                write(' ').

print_number(N) :- N > 9,
                write(N).


print_value(_,A,B) :- barrier(A,B), write('X ').
 
print_value(Path,A,B) :- \+barrier(A,B), \+member([A,B],Path), write('. ').
 
print_value(Path,A,B) :- member([A,B],Path),write('* ').
 
%printLine(_,_,_).
printLine(Path,[X,Y]) :- %write(Y), %write(X),
                            print_value(Path,X,Y),
                            N is Y + 1,
                            %SS is R - 1,
                            mazeSize(_,Length),
                            N =< Length,!,
                        printLine(Path,[X,N]).
 
%printGrit([X],_,_,[X]).
printGrit(Path,[X,Y],N) :- print_number(X), write('| '),
                        \+printLine(Path,[X,Y]),
                        write('|'),
                        X1 is X + 1,nl,
                        NN is N - 1,
                        NN > 0,
                        printGrit(Path, [X1,Y], NN).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%         CHECK IF EAST PATH IS BAST WAY TO GO    %%%%%%%%%%%%%%%%%%
good_path_for_east(_, [Y], [_,T]) :- Y < T,
                                     Y < 9.
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%         CHECK IF WEST PATH IS BAST WAY TO GO    %%%%%%%%%%%%%%%%%%
 
good_path_for_west(_,[Y], [_,T]) :- Y >= T,
                                    Y > 1.
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%         CHECK IF NORTH PATH IS BAST WAY TO GO       %%%%%%%%%%%%%%%%%%
good_path_for_north(X, [_], [H,_]) :- X >= H.
                                     
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%         CHECK IF SOUTH PATH IS BAST WAY TO GO     %%%%%%%%%%%%%%%%                                  
good_path_for_south(X, [_], [H,_]) :- X =< H.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%       CHOOSE THE SHORTEST WAY TO GO       %%%%%%%%%%%%%%%%%%%%%%%%%%
 
go_outX(X,[Y],[Z,R]) :- (X > 2),
                        (Y = 3),
                        (Z = 1),
                        (R < 6).
 
go_outY(X,[Y], [Z,R]) :- (X = 2),
                        (Y = 6),
                        (Z < 4),
                        (R > 6).
 
go_outZ(X,[Y],[Z,R]) :- (X = 1),
                        (Y < 6),
                        (Y > 3),
                        (Z > 2),
                        (R = 5).
 
go_out(X,[Y],[Z,_]) :- (X > 2),
                        (X < 5),
                        (Y = 5),
                        (Z = 1).
 
go_out0(_,[Y],[Z,R]) :- Y = 6,
                        Z < 5,
                        R > 4.

go_out00(X,[Y],[Z,R]) :-(X > 3),
                        (Y = 3),
                        (Z > 1),
                        (Z < 4),
                        (R = 3).

go_out1(X,[Y],[Z,R]) :-(X > 2),
                        (X < 5),
                        (Y = 5),
                        (Z > 1),
                        (Z < 3),
                        (R = 3).
 
go_out2(X,[Y],[Z,_]) :- (Y = 3),
                        (X = 2),
                        (Z >= 3).
 
go_out3(X,[Y],[Z,R]) :- (Y =< 2),
                        (X > 2),
                        (Z = 1),
                        (R < 3).
 
go_out4(X,[Y],[_,_]) :- (X = 5),
                        (Y > 5).
 
go_out5(X,[Y],[Z,_]) :- (X < 4),
                        (Y > 5),
                        (Z = 3).

go_out6(X,[Y],[Z,R]) :- (X > 1),
                        (X < 5),
                        (Y = 3),
                        (Z > 2),
                        (Z < 5),
                        (R = 5).
 
go_out7(X,[Y],[Z,R]) :- (X > 2),
                        (X < 5),
                        (Y > 4),
                        (Y < 7),
                        (Z > 2),
                        (R < 4).
 
go_out8(X,[Y],[Z,_]) :- (X < 4),
                        (Y > 5),
                        (Z  = 5).
 
go_out9(X,[Y],[_,_]) :- (X = 3),
                        (Y = 8).
 
go_out11(X,[Y],[Z,R]) :- (X = 1),
                        (Y < 3),
                        (Z > 2),
                        (R < 5).
 
go_out12(_,[Y],[Z,R]) :- (Y = 6),
                        (Z > 2),
                        (R > 5).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%      GO EITHER NORTH, SOUTH, EAST OR WEST       %%%%%%%%%%%%%%%%%%%%%%
 
go([X|Y], To, SoFar, NewPath) :- go_outX(X, Y, To),  
                                Z is Y,
                                D is X - 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_outY(X, Y, To),  
                                Z is Y + 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].

go([X|Y], To, SoFar, NewPath) :- go_outZ(X, Y, To),  
                                Z is Y + 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out(X, Y, To),  
                                Z is Y + 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out0(X, Y, To),  
                                Z is Y,
                                D is X - 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out00(X, Y, To),  
                                Z is Y,
                                D is X - 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].

go([X|Y], To, SoFar, NewPath) :- go_out1(X, Y, To),  
                                Z is Y,
                                D is X + 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].

go([X|Y], To, SoFar, NewPath) :- go_out12(X, Y, To),  
                                Z is Y,
                                D is X + 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out2(X, Y, To),  
                                Z is Y,
                                D is X -1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out3(X, Y, To),  
                                Z is Y,
                                D is X -1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out3(X, Y, To),  
                                Z is Y + 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out4(X, Y, To),  
                                Z is Y - 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out5(X, Y, To),  
                                Z is Y - 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out6(X, Y, To),  
                                Z is Y,
                                D is X + 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].

go([X|Y], To, SoFar, NewPath) :- go_out7(X, Y, To),  
                                Z is Y,
                                D is X +1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out8(X, Y, To),  
                                Z is Y - 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out9(X, Y, To),  
                                Z is Y,
                                D is X - 1, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- go_out11(X, Y, To),  
                                Z is Y + 1,
                                D is X, 
                                size(X,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
go([X|Y], To, SoFar, NewPath) :- good_path_for_east(X,Y, To), 
                                Z is Y+1, 
                                size(X,Z), 
                                \+barrier(X,Z), 
                                \+member([X,Z],SoFar), 
                                NewPath = [X,Z].
 
go([X|Y], To, SoFar, NewPath) :- good_path_for_west(X, Y, To),  
                                Z is Y-1, 
                                size(X,Z), 
                                \+barrier(X,Z), 
                                \+member([X,Z],SoFar), 
                                NewPath = [X,Z].
 
go([X|Y], To, SoFar, NewPath) :- good_path_for_south(X, Y , To),    
                                D is X+1, 
                                Z is Y, 
                                size(D,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z]. 
 
go([X|Y], To, SoFar, NewPath) :- good_path_for_north(X, Y, To), 
                                D is X-1, 
                                Z is Y, 
                                size(D,Z), 
                                \+barrier(D,Z), 
                                \+member([D,Z],SoFar), 
                                NewPath = [D,Z].
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%          COMPARE IF TWO VALUES ARE EQUAL         %%%%%%%%%%%%%%%%%%%%%
 
compare_num([X,Y],[Z,R]) :- (X = Z), (Y = R).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%           CHECK IF THE INPUT IS VALID             %%%%%%%%%%%%%%%%%%%%%
 
is_valid([H,T]) :- size(H,T), \+barrier(H,T).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%             GET VALUE TO SOLVE MAZE         %%%%%%%%%%%%%%%%%%%%%%%%%
 
solve(From, To, Path) :- is_valid(From), 
                            is_valid(To), 
                            get_solve(From, To, [From] ,Path),print_maze(Path). 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%               FINDING PATH        %%%%%%%%%%%%%%%%%%%%%%%%%
 
get_solve(From, From, So, So).
get_solve(From, To, So, Path) :-  \+compare_num(From,To),!,
                    %   \+member(From, So),
                        go(From, To, So, New),
                        append(So, [New], SoFar),
                        get_solve(New, To, SoFar, Path).
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%        PRINT THE MAZE WHEN FILE IS LOADED      %%%%%%%%%%%%%%%%%%%%%
 
:- print_maze([]).
