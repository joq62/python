-module(gpio_test).

-export([start/0,on/2,off/2,stop/1]).
-define(ERROR_LED,18).
-define(OK_LED,21).
-define(BUTTON_LED,5).
-define(BUTTON,26).

start()->
    {ok,Ref}=python:start([{python_path, "."},{python,"python3"}]),
    loop(Ref,100).
    

loop(Ref,0)->
     python:stop(Ref),
    ok;
loop(Ref,N) ->
    timer:sleep(300),
    T=rpc:call(node(),python,call,[Ref,temp,read,[]]),
    case T of 
	{badrpc,_Err}->
	    Pin=?ERROR_LED,
	    rpc:call(node(),python,call,[Ref,my_led,on,[Pin]]),
	    io:format("Temp Error ~n");
	T->
	    Pin=?OK_LED,
	    rpc:call(node(),python,call,[Ref,my_led,on,[Pin]]),
	    io:format("Temp = ~p~n",[T])
    end, 
    timer:sleep(1500),
    rpc:call(node(),python,call,[Ref,my_led,off,[Pin]]),    

    B=rpc:call(node(),python,call,[Ref,my_led,read,[?BUTTON]]),
    case B of
	{badrpc,Err}->
	    io:format("Button Error ~p~n",[Err]);
	1->
	    rpc:call(node(),python,call,[Ref,my_led,off,[?BUTTON_LED]]);
	0->
	    rpc:call(node(),python,call,[Ref,my_led,on,[?BUTTON_LED]])
    end,
  %  timer:sleep(1000), 
    loop(Ref,N-1).
    
stop(Ref)->
    python:stop(Ref).

on(Ref,Pin)->
   spawn(fun()-> gpio_handl(on,Ref,Pin) end).
		 
off(Ref,Pin)->
    spawn(fun()->gpio_handl(off,Ref,Pin) end).

gpio_handl(State,Ref,Pin)->
    case State of
	on->
	    python:call(Ref,on,led_on,[Pin]);
	off->
	    python:call(Ref,off,led_off,[Pin])
    end,	    
    receive
	infinity->
	    ok
    end.
