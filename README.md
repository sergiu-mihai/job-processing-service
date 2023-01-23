# Job Processing Service

This is a small HTTP service application that parses a list of tasks given in a particular JSON format.

The application is based on the MochiWeb Erlang library to receieve and process HTTP requests.
If not configured otherwise, the app will listent for requests at http://localhost:8080.

There are two POST endpoints exposed:
- **/job_tasks**, that returns a sorted list of tasks based on their execution priority;
- **/job_script**, that returns a script representation of the sorted tasks.

## Running the application

```sh
git clone https://github.com/sergiu-mihai/job-processing-service.git
cd job-processing-service
rebar3 compile
.\start-dev.sh
```