%%
%% store privacy with process PID
%% you can insert or delete this privacy-pid relationship.
%%
-module(es_store).

%% API
-export([init/0, insert/2, lookup/1, delete/1]).

-define(TABLE_ID, ?MODULE).

init() ->
	ets:new(?TABLE_ID, [public, named_table]).

insert(Privacy, Pid) ->
	ets:insert(?TABLE_ID, {Privacy, Pid}).

lookup(Privacy) ->
	case ets:lookup(?TABLE_ID, Privacy) of
		[{Privacy, Pid}] 	-> {ok, Pid};
		[] 					-> {error, not_found}
	end.

delete(Pid) ->
	ets:delete(?TABLE_ID, {'_', '_', Pid}).
