
%% @doc job_processor.

-module(job_processor).

-define(JOB_TASKS, <<"tasks">>).
-define(TASK_NAME, <<"name">>).
-define(TASK_COMMAND, <<"command">>).
-define(TASK_DEPS, <<"requires">>).

-export([parse_job/1, script_job/1]).


%% External API

parse_job(Job) ->
    Tasks = maps:get(?JOB_TASKS, Job),
    TasksParsed = parse_tasks(Tasks),
    TasksMapped = lists:map(
        fun(X) ->
            maps:remove(?TASK_DEPS, X)
        end,
        lists:uniq(TasksParsed)),
    #{?JOB_TASKS => TasksMapped}.

script_job(Job) ->
    Tasks = maps:get(?JOB_TASKS, Job),
    TasksParsed = parse_tasks(Tasks),
    lists:foldl(
        fun(X, Script) ->
            Script ++ "\n" ++ erlang:binary_to_list(maps:get(?TASK_COMMAND, X))
        end,
        "#!/usr/bin/env bash",
        lists:uniq(TasksParsed)).


%% Internal API

parse_tasks([H|T]) ->
    Deps = maps:get(?TASK_DEPS, H, []),
    DepsTasks = lists:filter(
        fun(Task) ->
            lists:any(
                fun(Dep) ->
                    maps:get(?TASK_NAME, Task) == Dep
                end, Deps)
        end, T),
    DepsTasks ++ [H] ++ parse_tasks(T);
parse_tasks([]) ->
    [].
