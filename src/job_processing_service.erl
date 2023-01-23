
%% @doc job_processing_service.

-module(job_processing_service).

-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the job_processing_service server.
start() ->
    job_processing_service_deps:ensure(),
    ensure_started(crypto),
    application:start(job_processing_service).


%% @spec stop() -> ok
%% @doc Stop the job_processing_service server.
stop() ->
    application:stop(job_processing_service).
