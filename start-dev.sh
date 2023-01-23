#!/bin/sh
exec erl \
    -pa _build/default/lib/job_processing_service/ebin \
    -pa _build/default/lib/mochiweb/ebin \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -sname job_processing_service_dev \
    -s job_processing_service \
    -s reloader
