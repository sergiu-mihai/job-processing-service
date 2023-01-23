
%% @doc Callbacks for the job_processing_service application.

-module(job_processing_service_app).

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for job_processing_service.
start(_Type, _StartArgs) ->
    job_processing_service_deps:ensure(),
    job_processing_service_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for job_processing_service.
stop(_State) ->
    ok.
